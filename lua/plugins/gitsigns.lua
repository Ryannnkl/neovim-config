return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "^" },
        changedelete = { text = "~" },
        untracked = { text = "+" },
      },
      numhl = true,
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 300,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = function(_, blame_info)
        local max_length = 50
        local summary = vim.fn.strcharpart(blame_info.summary, 0, max_length)
        if vim.fn.strchars(blame_info.summary) > max_length then
          summary = summary .. "…"
        end

        return { { ("  %s • %s"):format(blame_info.author, summary), "GitSignsCurrentLineBlame" } }
      end,
    },
  },
}
