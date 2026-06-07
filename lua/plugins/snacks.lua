return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
            git_untracked = true,
          },
          files = {
            hidden = true,
            ignored = true,
          },
        },
      },
    },
  },
}
