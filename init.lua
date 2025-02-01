vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set cursorline")
vim.cmd("hi CursorLine cterm=NONE ctermbg=242")
vim.cmd("set tabstop=8")
vim.cmd("set shiftwidth=8")
vim.cmd("set ignorecase")
vim.cmd("set smartcase")
vim.cmd("set smarttab")
vim.cmd("set autoindent")
vim.cmd("set showmatch")
vim.cmd("set hlsearch")
vim.cmd("set ruler")
vim.cmd("set modeline")
vim.cmd("set modelines=5")
vim.cmd("set clipboard+=unnamedplus")
vim.cmd("set nofoldenable")
vim.cmd("set list")
vim.cmd("set noswapfile")
vim.opt.listchars =  { eol = '↩', tab = '◦◦', space = '◦' }
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	{ "EdenEast/nightfox.nvim" },
	{ 'nvim-telescope/telescope.nvim', tag = '0.1.5', dependencies = { 'nvim-lua/plenary.nvim' }},
	{ 'nvim-telescope/telescope-ui-select.nvim' },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
	{ "nvim-neo-tree/neo-tree.nvim", branch = "v3.x", dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim",}},
	{ 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }},
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" },
	-- { 'hrsh7th/nvim-cmp' },
	{ "iguanacucumber/magazine.nvim", name = "nvim-cmp" },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'L3MON4D3/LuaSnip', version = "v2.*", build = "make install_jsregexp", dependencies = { 'rafamadriz/friendly-snippets', }},
	{ 'saadparwaiz1/cmp_luasnip' },
	{ 'nvimdev/lspsaga.nvim' },
	{ 'NeogitOrg/neogit', dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim", "nvim-telescope/telescope.nvim" }},
	{ 'lewis6991/gitsigns.nvim' },
	{ 'IogaMaster/neocord', event = "VeryLazy" },
	{ 'shellRaining/hlchunk.nvim' },
	{ 'HiPhish/rainbow-delimiters.nvim' },
	{ 'folke/noice.nvim', event = 'VeryLazy', dependencies = { 'rcarriga/nvim-notify' }},
	{ 'RRethy/vim-illuminate' },
	{ 'mvllow/modes.nvim' },
	{ 'rcarriga/nvim-dap-ui', dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' }},
	{ 'RaafatTurki/hex.nvim' },
	{ 'marcussimonsen/let-it-snow.nvim', cmd = "LetItSnow", opts = { delay = 100 } }
}
local opts = {}

require("lazy").setup(plugins, opts)

-- Theme
require('nightfox').setup({
	options = {
		transparent = true,
		colorblind = {
			enable = true,
			severity = {
				protan = 0.25,
			},
		},
	},
	groups = {
		all = {
			NormalFloat = { fg = "fg1", bg = "NONE" },
			NormalNC = { fg = "fg1", bg = "NONE" }
		}
	}
})
vim.cmd("colorscheme nordfox")

require("notify").setup({
  background_colour = "#000000",
})

-- Fuzzy selector
local builtin = require('telescope.builtin')
require('telescope').setup {
	defaults = {
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown {
				}
			}
		}
	}
}
require("telescope").load_extension("ui-select")

vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

-- Formating
local configs = require("nvim-treesitter.configs")
configs.setup({
	ensure_installed = { "lua", "javascript", "html", "bash", "c", "c_sharp", "cmake", "css", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "ini", "json", "make", "python", "rust", "yaml", "asm", "xml", "glsl" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false
	},
	indent = { enable = true },
})

local highlight = {
	"RainbowRed",
	"RainbowYellow",
	"RainbowBlue",
	"RainbowOrange",
	"RainbowGreen",
	"RainbowViolet",
	"RainbowCyan",
}

local style = {
	"#E06c75",
	"#E5C07B",
	"#61AFEF",
	"#D19A66",
	"#98C379",
	"#C678DD",
	"#56B6C2"
}
vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })

require('hlchunk').setup({
	chunk = {
		enable = true,
		style = {
			{ fg = "#639bff" },
			{ fg = "#700000" }
		}
	},
	indent = {
		enable = true,
		chars = { "│", "¦", "┆", "┊", },
		style = style
	},
	line_num = {
		enable = true,
		style = "#639bff"
	},
	blank = {
		enable = true,
		chars = { "" },
		style = style
	}
})
require('rainbow-delimiters.setup').setup { highlight = highlight }

require('illuminate').configure({})

-- File Explorer
vim.keymap.set('n', '<C-f>', ':Neotree filesystem reveal left<CR>', {})
require("noice").setup({
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = false,
			["vim.lsp.util.stylize_markdown"] = false,
			["cmp.entry.get_documentation"] = false
		}
	},
	presets = {
		command_palette = true,
		long_message_to_split = true,
		lsp_doc_border = true
	}
})

-- GIt Status
require('lualine').setup()

-- LSP
require("mason").setup()
require("mason-lspconfig").setup {
	ensure_installed = { "lua_ls", "rust_analyzer", "bashls", "clangd", "cmake", "cssls", "html", "jsonls", "biome", "taplo", "gitlab_ci_ls", "ruff", "csharp_ls", "lemminx", "pyright" }
}
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup({capabilities = capabilities})
lspconfig.rust_analyzer.setup({capabilities = capabilities})
lspconfig.bashls.setup({capabilities = capabilities})
lspconfig.clangd.setup({capabilities = capabilities})
lspconfig.cmake.setup({capabilities = capabilities})
lspconfig.cssls.setup({capabilities = capabilities})
lspconfig.html.setup({capabilities = capabilities})
lspconfig.jsonls.setup({capabilities = capabilities})
lspconfig.biome.setup({capabilities = capabilities})
lspconfig.taplo.setup({capabilities = capabilities})
lspconfig.gitlab_ci_ls.setup({capabilities = capabilities})
lspconfig.ruff.setup({capabilities = capabilities})
lspconfig.csharp_ls.setup({capabilities = capabilities})
lspconfig.lemminx.setup({capabilities = capabilities})
lspconfig.pyright.setup({capabilities = capabilities})

require'lspconfig'.rust_analyzer.setup {
	settings = {
    		['rust-analyzer'] = {
			cachePriming = {
				enable = true;
			}
		}
	}
}

vim.lsp.start_client({
  name = 'robust-lsp',
  cmd = {'robust-lsp'},
  root_dir = vim.fs.dirname(vim.fs.find({'RobustToolbox'})[1]),
})

require('lspsaga').setup {
	symbol_in_winbar = { enable = false },
	lightbulb = { enable = false },
	ui = {
		winblend = 100,
		colors= { normal_bg = "NONE" }
	},
	code_action = {
		extend_gitsigns = false
	}
}

vim.keymap.set('n', 'K', ':Lspsaga hover_doc<CR>', {})
vim.keymap.set('n', 'gD', ':Lspsaga goto_definition<CR>', {})
vim.keymap.set('n', 'gd', ':Lspsaga peek_definition<CR>', {})
vim.keymap.set('n', 'gf', ':Lspsaga finder<CR>', {})
vim.keymap.set({ 'n', 'v' }, '<leader>ca', ':Lspsaga code_action<CR>', {})

vim.cmd("LspStart")

-- DAP
local dap = require("dap")
vim.keymap.set('n', '<leader>dr', function() dap.run_last() end)
vim.keymap.set('n', '<leader>dt', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<leader>dc', function() dap.continue() end)
vim.keymap.set('n', '<leader>do', function() dap.step_over() end)
vim.keymap.set('n', '<leader>di', function() dap.step_into() end)
vim.keymap.set('n', '<leader>de', function() dap.step_out() end)

dap.adapters.coreclr = {
	type = 'executable',
	command = '/home/gwen/.local/share/nvim/mason/bin/netcoredbg',
	args = {'--interpreter=vscode'}
}

dap.configurations.cs = {
	{
		type = "coreclr",
    		name = "launch - netcoredbg",
    		request = "launch",
		program = function()
			return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
		end,
	},
}

local dapui = require("dapui")
dapui.setup({
	layouts = {
		{
			elements = {
				{
					id = "scopes",
					size = 0.5
				},
				{
					id = "watches",
					size = 0.25
				},
				{
					id = "stacks",
					size = 0.125
				},
				{
					id = "breakpoints",
					size = 0.125
				}
			},
			position = "left",
			size = 40
			},
			{
				elements = {
					{
						id = "repl",
						size = 1
					}
			},
			position = "bottom",
			size = 10
		}
	}
})

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

-- Autocomplete
local cmp = require'cmp'
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<TAB>'] = cmp.mapping.confirm({ select = true }), 
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = 'vsnip' },
	}, {
		{ name = 'buffer' },
	}),
})

-- Git
local neogit = require("neogit")
neogit.setup {
	graph_style = "unicode",
	integrations = {
		telescope = true,
		diffview = true,
	}
}
local gitsigns = require("gitsigns")
gitsigns.setup {}
vim.keymap.set('n', 'gb', ':Gitsigns blame_line<CR>', {})

-- Rpc
local rpc = require("neocord")
rpc.setup({})

-- Hex
require 'hex'.setup()
