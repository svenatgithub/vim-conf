-- Oil filemanager
function _G.get_oil_winbar()
  local dir = require("oil").get_current_dir()
  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end
return {
    {
        'stevearc/oil.nvim',
        enable = true,
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {
            defaul_file_explorer = true,
            skip_confirm_for_simple_edits = false,
        },
        win_options = {
           winbar = "%!v:lua.get_oil_winbar()",
        },
        -- Optional dependencies
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    }
}
