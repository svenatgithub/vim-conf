vim.g.mapleader = ' ' 



vim.opt.number = true

vim.opt.mouse = 'a'

vim.opt.showmode = false


vim.opt.undofile = true
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'

vim.opt.signcolumn = 'yes'



vim.opt.cursorline = true



vim.opt.scrolloff = 10
vim.opt.hlsearch = true 
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank",{ clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})


vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move marked text dow'})
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move marked text up'})



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
		-- add your plugins here
		{"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~'},
				delete = { text = '_'},
				topdelete = { text = '‾'},
				changedelete = { text = '~'},
			},},}
	},
	{ -- Fuzzy Finder (files, lsp, etc)
		'nvim-telescope/telescope.nvim',
		event = 'VimEnter',
		branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				'nvim-telescope/telescope-fzf-native.nvim',

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = 'make',

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
			{ 'nvim-telescope/telescope-ui-select.nvim' },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
		},
		config = function()
			-- Telescope is a fuzzy finder that comes with a lot of different things that
			-- it can fuzzy find! It's more than just a "file finder", it can search
			-- many different aspects of Neovim, your workspace, LSP, and more!
			--
			-- The easiest way to use Telescope, is to start by doing something like:
			--  :Telescope help_tags
			--
			-- After running this command, a window will open up and you're able to
			-- type in the prompt window. You'll see a list of `help_tags` options and
			-- a corresponding preview of the help.
			--
			-- Two important keymaps to use while in Telescope are:
			--  - Insert mode: <c-/>
			--  - Normal mode: ?
			--
			-- This opens a window that shows you all of the keymaps for the current
			-- Telescope picker. This is really useful to discover what Telescope can
			-- do as well as how to actually do it!

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			require('telescope').setup {
				-- You can put your default mappings / updates / etc. in here
				--  All the info you're looking for is in `:help telescope.setup()`
				--
				-- defaults = {
					--   mappings = {
						--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
						--   },
						-- },
						-- pickers = {}
						extensions = {
							['ui-select'] = {
								require('telescope.themes').get_dropdown(),
							},
						},
					}

					-- Enable Telescope extensions if they are installed
					pcall(require('telescope').load_extension, 'fzf')
					pcall(require('telescope').load_extension, 'ui-select')

					-- See `:help telescope.builtin`
					local builtin = require 'telescope.builtin'
					vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
					vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
					vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
					vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
					vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
					vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
					vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
					vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
					vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
					vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

					-- Slightly advanced example of overriding default behavior and theme
					vim.keymap.set('n', '<leader>/', function()
						-- You can pass additional configuration to Telescope to change the theme, layout, etc.
						builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
							winblend = 10,
							previewer = false,
						})
					end, { desc = '[/] Fuzzily search in current buffer' })

					-- It's also possible to pass additional configuration options.
					--  See `:help telescope.builtin.live_grep()` for information about particular keys
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
				end,
			},

	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
