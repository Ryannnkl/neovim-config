local M = {}

M.path = vim.fn.stdpath("state") .. "/lazyvim-colorscheme.txt"

function M.get(default)
  local ok, lines = pcall(vim.fn.readfile, M.path)
  local colorscheme = ok and lines[1] or nil

  if colorscheme and colorscheme ~= "" then
    return colorscheme
  end

  return default
end

function M.set(colorscheme)
  if not colorscheme or colorscheme == "" then
    return
  end

  vim.fn.mkdir(vim.fn.fnamemodify(M.path, ":h"), "p")
  pcall(vim.fn.writefile, { colorscheme }, M.path)
end

function M.pick()
  Snacks.picker.colorschemes({
    confirm = function(picker, item)
      picker:close()
      if item then
        picker.preview.state.colorscheme = nil
        vim.schedule(function()
          M.set(item.text)
          vim.cmd.colorscheme(item.text)
        end)
      end
    end,
  })
end

return M
