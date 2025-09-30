return {
  "kiddos/gemini.nvim",
  opts = {
    model_config = {
      model_id = "gemini-2.5-flash",
      temperature = 0.10,
      top_k = 128,
      response_mime_type = "text/plain",
    },
    chat_config = {
      enabled = true,
    },
    completion = {
      enabled = true,
      blacklist_filetypes = { "help", "qf", "json", "yaml", "toml", "xml" },
      blacklist_filenames = { ".env" },
      completion_delay = 800,
      insert_result_key = "<Tab>",
      move_cursor_end = true,
      can_complete = function()
        return vim.fn.pumvisible() ~= 1
      end,
      get_system_text = function()
        return "You are a coding AI assistant that autocomplete user's code."
          .. "\n* Your task is to provide code suggestion at the cursor location marked by <cursor></cursor>."
          .. "\n* Your response does not need to contain explaination."
      end,
      get_prompt = function(bufnr, pos)
        local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
        local prompt = "Below is the content of a %s file `%s`:\n"
          .. "```%s\n%s\n```\n\n"
          .. "Suggest the most likely code at <cursor></cursor>.\n"
          .. "Wrap your response in ``` ```\n"
          .. "eg.\n```\n```\n\n"
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        local line = pos[1]
        local col = pos[2]
        local target_line = lines[line]
        if target_line then
          lines[line] = target_line:sub(1, col) .. "<cursor></cursor>" .. target_line:sub(col + 1)
        else
          return nil
        end
        local code = vim.fn.join(lines, "\n")
        local abs_path = vim.api.nvim_buf_get_name(bufnr)
        local filename = vim.fn.fnamemodify(abs_path, ":.")
        prompt = string.format(prompt, filetype, filename, filetype, code)
        return prompt
      end,
    },
  },
}
