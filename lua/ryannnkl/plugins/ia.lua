return {
  "kiddos/gemini.nvim",
  opts = {
    completion = {
      enabled = false,
    },
    task = {
      enabled = true,
      get_system_text = function()
        return "You are an AI assistant that helps user write code."
          .. "\n* You should output the new content for the Current Opened File"
          .. "\n* You should not write comments between the code"
          .. "\n* Your response does not need to contain explaination."
      end,
      get_prompt = function(bufnr, user_prompt)
        local buffers = vim.api.nvim_list_bufs()
        local file_contents = {}

        for _, b in ipairs(buffers) do
          if vim.api.nvim_buf_is_loaded(b) then -- Only get content from loaded buffers
            local lines = vim.api.nvim_buf_get_lines(b, 0, -1, false)
            local abs_path = vim.api.nvim_buf_get_name(b)
            local filename = vim.fn.fnamemodify(abs_path, ":.")
            local filetype = vim.api.nvim_get_option_value("filetype", { buf = b })
            local file_content = table.concat(lines, "\n")
            file_content = string.format("`%s`:\n\n```%s\n%s\n```\n\n", filename, filetype, file_content)
            table.insert(file_contents, file_content)
          end
        end

        local current_filepath = vim.api.nvim_buf_get_name(bufnr)
        current_filepath = vim.fn.fnamemodify(current_filepath, ":.")

        local context = table.concat(file_contents, "\n\n")
        return string.format("%s\n\nCurrent Opened File: %s\n\nTask: %s", context, current_filepath, user_prompt)
      end,
    },
  },
}
