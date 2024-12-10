-- Collection of various small independent plugins/modules
return {
        {
                'echasnovski/mini.nvim',
                enabled = false,
                config = function()
                    local statusline = require 'mini.statusline'
                    statusline.setup { use_icons = true }

                    statusline.section_location = function()
                        return '%2l:%-2v'
                    end
                end,

        }
}
