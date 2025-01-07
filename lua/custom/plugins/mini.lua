-- Collection of various small independent plugins/modules
return {
        {
                'echasnovski/mini.nvim',
                enabled = true,
                config = function()
                    local statusline = require 'mini.statusline'
                    statusline.setup {
                        use_icons = true,
                        set_lsp_settings = false
                    }

                end,

        }
}
