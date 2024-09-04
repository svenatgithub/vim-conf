-- [ TO-DO ]
-- Treesitter 
-- bracket line plugin
-- undo tree
-- git fugitive
-- div view nvim
-- Harpoon
-- [ TO-DO ]

-- [ Settings ]
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
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.cursorline = true

vim.opt.splitright = true

vim.opt.scrolloff = 20

vim.opt.hlsearch = true

-- [ Settings ]

-- [ Autocommands, autocmd ]

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank",{ clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- [ Autocommands, autocmd ]



-- [ Lazy, Package manager ]
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
        -- Colorscheme
        {"tanvirtin/monokai.nvim"},
		-- Git helper
		{"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~'},
				delete = { text = '_'},
				topdelete = { text = '‾'},
				changedelete = { text = '~'},
			},},
		},
		-- Fuzzy Finder (files, lsp, etc)
		{'nvim-telescope/telescope.nvim',
		event = 'VimEnter',
		branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
			{ 'nvim-telescope/telescope-ui-select.nvim' },
			{ 'nvim-tree/nvim-web-devicons', enabled = true },
		},
		config = function()
		require('telescope').setup {
				extensions = {
					['ui-select'] = {
						require('telescope.themes').get_dropdown(),
					},
				},
			}
			pcall(require('telescope').load_extension, 'fzf')
			pcall(require('telescope').load_extension, 'ui-select')
			end,
		},
		-- Collection of various small independent plugins/modules
        {'echasnovski/mini.nvim',
                config = function()
                    local statusline = require 'mini.statusline'
                    statusline.setup { use_icons = true } 

                    statusline.section_location = function()
                        return '%2l:%-2v'
                    end
                end,

        },
		-- File manager
        {'stevearc/oil.nvim',
            opts = {},
            dependencies = { { "echasnovski/mini.icons", opts = {} } },
        },
        -- auto close stuff
        {"windwp/nvim-autopairs",
            even = "InsertEnter",
            config = true
        },
		},

	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "default" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
-- [ Lazy ]

-- [ Keymaps, Hotkeys ]
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>c", "<CMD>Oil<CR>", { desc = "Open the filemanager" })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move marked text dow'})
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move marked text up'})


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
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = '[ ] Find existing buffers' })

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
vim.keymap.set('n', '<leader>sn', function()
    builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })

-- [ Keymaps ]
