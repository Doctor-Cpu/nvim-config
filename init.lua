vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set cursorline")
vim.cmd("hi CursorLine cterm=NONE ctermbg=242")
vim.cmd("set tabstop=4")
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
		{ 'hrsh7th/nvim-cmp' },
		{ 'hrsh7th/cmp-nvim-lsp' },
		--{ 'L3MON4D3/LuaSnip', version = "v2.*", build = "make install_jsregexp", dependencies = { 'saadparwaiz1/cmp_luasnip', 'rafamadriz/friendly-snippets', }},

		{ 'L3MON4D3/LuaSnip', version = "v2.*", build = "make install_jsregexp", dependencies = { 'rafamadriz/friendly-snippets', }},
		{ 'saadparwaiz1/cmp_luasnip' },
		{ 'NeogitOrg/neogit', dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim", "nvim-telescope/telescope.nvim" }},
		{ 'IogaMaster/neocord', event = "VeryLazy" },
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
			}
		})
vim.cmd("colorscheme nordfox")

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

-- Treesitter
local configs = require("nvim-treesitter.configs")
configs.setup({
		ensure_installed = { "lua", "javascript", "html", "bash", "c", "c_sharp", "cmake", "css", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "ini", "json", "make", "python", "rust", "yaml" },
		highlight = { enable = true },
		indent = { enable = true },
})

-- File Explorer
vim.keymap.set('n', '<C-f>', ':Neotree filesystem reveal left<CR>', {})

-- GIt Status
require('lualine').setup()

-- LSP
require("mason").setup()
require("mason-lspconfig").setup {
		ensure_installed = { "lua_ls", "rust_analyzer", "bashls", "clangd", "cmake", "cssls", "html", "jsonls", "biome", "taplo", "yamlls", "jedi_language_server", "csharp_ls" },
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
lspconfig.yamlls.setup({capabilities = capabilities})
lspconfig.jedi_language_server.setup({capabilities = capabilities})
lspconfig.csharp_ls.setup({capabilities = capabilities})

vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})

vim.cmd("LspStart")

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
-- Rpc
local rpc = require("neocord")
rpc.setup({})
