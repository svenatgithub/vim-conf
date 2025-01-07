require("custom.lazy")
-- [ TO-DO ]
-- Harpoon
-- blink.cmp
-- [ TO-DO ]

-- [ Settings ]
-- Colorscheme Name
-- Or <Leader>cs

--  .oooooo.                  .    o8o                                 
-- d8P'  `Y8b               .o8    `"'                                 
--888      888 oo.ooooo.  .o888oo oooo   .ooooo.  ooo. .oo.    .oooo.o 
--888      888  888' `88b   888   `888  d88' `88b `888P"Y88b  d88(  "8 
--888      888  888   888   888    888  888   888  888   888  `"Y88b.  
--`88b    d88'  888   888   888 .  888  888   888  888   888  o.  )88b 
-- `Y8bood8P'   888bod8P'   "888" o888o `Y8bod8P' o888o o888o 8""888P' 
--              888                                                    
--             o888o                                                   
--                                                                     

local color = "habamax"

vim.g.mapleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.timeoutlen = 750

vim.opt.mouse = 'a'

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.showmode = false

vim.opt.undofile = true
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'

vim.opt.signcolumn = 'yes'
vim.opt.wrap = false

vim.opt.list = true
vim.opt.listchars = { multispace = '.', trail = '·', nbsp = '␣' }

vim.opt.cursorline = true
vim.g.undotree_WindowLayout = 2
vim.opt.splitright = true

vim.opt.scrolloff = 15
vim.opt.sidescrolloff = 8

vim.opt.hlsearch = true
-- [ Colorscheme ]
vim.cmd.colorscheme(color)

-- netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

-- [ Autocommands, autocmd ]
---                          .                                               .o8  
--                        .o8                                              "888  
-- .oooo.   oooo  oooo  .o888oo  .ooooo.   .ooooo.  ooo. .oo.  .oo.    .oooo888  
--`P  )88b  `888  `888    888   d88' `88b d88' `"Y8 `888P"Y88bP"Y88b  d88' `888  
-- .oP"888   888   888    888   888   888 888        888   888   888  888   888  
--d8(  888   888   888    888 . 888   888 888   .o8  888   888   888  888   888  
--`Y888""8o  `V88V"V8P'   "888" `Y8bod8P' `Y8bod8P' o888o o888o o888o `Y8bod88P" -
--
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank",{ clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
--oooo    oooo                                                                       
--`888   .8P'                                                                        
-- 888  d8'     .ooooo.  oooo    ooo ooo. .oo.  .oo.    .oooo.   oo.ooooo.   .oooo.o 
-- 88888[      d88' `88b  `88.  .8'  `888P"Y88bP"Y88b  `P  )88b   888' `88b d88(  "8 
-- 888`88b.    888ooo888   `88..8'    888   888   888   .oP"888   888   888 `"Y88b.  
-- 888  `88b.  888    .o    `888'     888   888   888  d8(  888   888   888 o.  )88b 
--o888o  o888o `Y8bod8P'     .8'     o888o o888o o888o `Y888""8o  888bod8P' 8""888P' 
--                       .o..P'                                   888                
--                       `Y8P'                                   o888o               
-- [ Keymaps, Hotkeys ]
local map = vim.keymap.set
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- custom snippet
map("n", ",py", ":-1read !".. vim.fn.getcwd() .."/snip/snippet.python<CR> 9kA")
map("n", ",sh", ":-1read !".. vim.fn.getcwd() .."/snip/snippet.bash<CR> 4kA")

map("n", "<Esc>", "<cmd>nohlsearch<CR>")

map("n", "<leader>c", "<CMD>Oil<CR>", { desc = "Open the filemanager" })

map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move marked text dow'})
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move marked text up'})

map('n', '<leader><F5>', vim.cmd.UndotreeToggle, {desc = "Toggle Undotree"})

local builtin = require('telescope.builtin')
local themes = require('telescope.themes')

map('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })

map('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })

map('n', '<leader>pf', builtin.find_files, { desc = '[S]earch [F]iles' })

map('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })

map('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })

map('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })

map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })

map('n', '<leader>s.', builtin.oldfiles, {desc = '[S]earch Recent Files ("." for repeat)' })

map('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })

map('n', '<leader>cs', builtin.colorscheme, { desc = 'List all Colorschemes' })


map('n', '<leader>v', vim.cmd.vsplit , { desc = 'Open current frame in new split buffer' })

-- Slightly advanced example of overriding default behavior and theme
map('n', '<leader>/', function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    builtin.current_buffer_fuzzy_find(themes.get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer' })

-- It's also possible to pass additional configuration options.

map('n', '<leader>s/', function()
    builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
    }
end, { desc = '[S]earch [/] in Open Files' })

-- Shortcut for searching your Neovim configuration files
map('n', '<leader>vc', function()
    builtin.find_files { cwd = vim.fn.getcwd() }
end, { desc = '[S]earch [N]eovim files' })

-- Shortcut for searching config files
map('n', '<leader>sc', function()
    builtin.find_files { cwd = '/home/me/.config/'}
end, { desc = 'Search in My Config Files' })

local harpoon = require("harpoon")

map("n", "<C-e>", function ()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, {desc = "Toggle the harpoon menu"})

