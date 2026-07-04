return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
                disable = {
                  "unusedImport",
                  "unusedVariable",
                  "undefinedVariable",
                  "reportMissingImports",
                  "reportUnusedImport",
                  "reportUnusedVariable",
                  "reportUnusedClass",
                  "reportUnusedFunction",
                },
                autoFormat = false,
              },
            },
          },
          capabilities = {
            documentFormattingProvider = false,
          },
        },
        ruff = {
          filetypes = { "python" },
          single_file_support = true,
          init_options = { settings = { format = { enabled = true } } },
          capabilities = { documentFormattingProvider = true },
          keys = {
            {
              "<leader>co",
              LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
          },
        },
      },
    },
  },
}
