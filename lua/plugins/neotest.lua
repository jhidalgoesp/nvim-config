return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    { "fredrikaverpil/neotest-golang", version = "*" }, -- Installation
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-golang"), -- Registration
      },
    })
  end,
  keys = {
    {
      "<leader>td",
      function()
        require("neotest").run.run({ suite = false, strategy = "dap" })
      end,
      desc = "Debug nearest test",
    },
    {
      "<leader>tp",
      function()
        require("neotest").run.run({
          vim.fn.expand("%:p:h"),
        })
      end,
      desc = "Debug test package",
    },
    {
      "<leader>tP",
      function()
        require("neotest").run.run(vim.fn.getcwd())
      end,
      desc = "Run whole project",
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle test summar",
    },
    {
      "<leader>to",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Toggle test output",
    }
  },
}
