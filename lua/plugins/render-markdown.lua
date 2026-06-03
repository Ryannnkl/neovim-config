return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
    opts = {
      enabled = true,
      render_modes = { "n", "c", "t" },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = false,
      },
      checkbox = {
        enabled = true,
      },
    },
    config = function(_, opts)
      local render_markdown = require("render-markdown")
      render_markdown.setup(opts)
      render_markdown.set(true)
      Snacks.toggle({
        name = "Render Markdown",
        get = render_markdown.get,
        set = render_markdown.set,
      }):map("<leader>um")
    end,
  },
}
