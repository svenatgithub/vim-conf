require("custom.lazy")
-- [ TO-DO ]
-- undo tree git fugitive
-- div view nvim Harpoon
-- [ TO-DO ]

-- [ Settings ]
-- Colorscheme Name
-- Or <Leader>cs
local color = "retrobox"

vim.g.mapleader = ' '
vim.g.neovide_transparency = 0.95

vim.opt.number = true
vim.opt.relativenumber = true

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
-- netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

-- [ Autocommands, autocmd ]
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank",{ clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- [ Keymaps, Hotkeys ]
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- custom snippet
vim.keymap.set("n", ",py", ":-1read !snip/snippet.python<CR>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>c", "<CMD>Oil<CR>", { desc = "Open the filemanager" })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move marked text dow'})
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move marked text up'})

vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle, {desc = "Toggle Undotree"})

local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })

vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })

vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, {desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>cs', builtin.colorscheme, { desc = 'List all Colorschemes' })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer' })

-- It's also possible to pass additional configuration options.

vim.keymap.set('n', '<leader>s/', function()
    builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
    }
end, { desc = '[S]earch [/] in Open Files' })

-- Shortcut for searching your Neovim configuration files
vim.keymap.set('n', '<leader>vc', function()
    builtin.find_files { cwd = '/home/me/code/git/vim-conf/' }
end, { desc = '[S]earch [N]eovim files' })

-- Shortcut for searching config files
vim.keymap.set('n', '<leader>sc', function()
    builtin.find_files { cwd = '/home/me/.config/'}
end, { desc = 'Search in My Config Files' })

-- [ Colorscheme ]
vim.cmd.colorscheme(color)
