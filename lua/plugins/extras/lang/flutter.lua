return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "dart" })
    end,
  },
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "RobertBrunhage/flutter-riverpod-snippets",
      {
        "nvim-neotest/neotest",
        dependencies = {
          { "sidlatau/neotest-dart" },
        },
        opts = function(_, opts)
          vim.list_extend(opts.adapters, {
            require("neotest-dart")({ command = "flutter" }),
          })
        end,
      },
    },
    config = function()
      require("flutter-tools").setup({
        experimental = { lsp_derive_paths = true },
        debugger = { enabled = true },
        widget_guides = { enabled = true, debug = true },
        dev_log = { open_cmd = "tabedit" },
        outline = { open_cmd = "30vnew" },
        lsp = {
          on_attach = function(client, bufnr)
            require("lsp").on_attach(client, bufnr)
            require("flutter-tools").lsp.on_attach(client, bufnr)
          end,
        },
      })
    end,
  },
}
