local configs = require("nvchad.configs.lspconfig")

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

local servers = { "html", "cssls", "clangd" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_init = on_init,
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

lspconfig["gopls"].setup({
	on_init = on_init,
	on_attach = on_attach,
	capabilities = vim.tbl_deep_extend("force", capabilities, {
		settings = {
			gopls = {
				analyses = {
					unusedparams = true,
				},
				staticcheck = true,
				gofumpt = true,
				completeUnimported = true,
			},
		},
	}),
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
})
