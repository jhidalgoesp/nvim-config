return {
	{
		"mhartington/formatter.nvim",
		config = function()
			-- Utilities for creating configurations
			local util = require("formatter.util")

      local php_formatter = {
        function()
          return {
            exe = './node_modules/.bin/prettier',
            args = {
              '--stdin-filepath',
              vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
              '--config',
              vim.fn.getcwd() .. '/.prettierrc.json',
              '--plugin=@prettier/plugin-php',
              '--parser=php'
            },
            stdin = true
          }
        end
      }
      -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
      require("formatter").setup({
        -- Enable or disable logging
        logging = true,
        -- Set the log level
        log_level = vim.log.levels.WARN,
        -- All formatter configurations are opt-in
        filetype = {
          -- Formatter configurations for filetype "lua" go here
          -- and will be executed in order
          lua = {
            -- "formatter.filetypes.lua" defines default configurations for the
            -- "lua" filetype
            require("formatter.filetypes.lua").stylua,

						-- You can also define your own configuration
						function()
							-- Supports conditional formatting
							if util.get_current_buffer_file_name() == "special.lua" then
								return nil
							end

              -- Full specification of configurations is down below and in Vim help
              -- files
              return {
                exe = "stylua",
                args = {
                  "--search-parent-directories",
                  "--stdin-filepath",
                  util.escape_path(util.get_current_buffer_file_path()),
                  "--",
                  "-",
                },
                stdin = true,
              }
            end,
          },
          go = {
            -- Use gofmt for Go files
            function()
              return {
                exe = "gofmt",
                args = {},
                stdin = true,
              }
            end,
          },
          javascript = {
            require("formatter.filetypes.javascript").prettier,
          },
          typescript = {
            require("formatter.filetypes.typescript").prettier,
          },
          javascriptreact = {
            require("formatter.filetypes.javascriptreact").prettier,
          },
          typescriptreact = {
            require("formatter.filetypes.typescriptreact").prettier,
          },
          json = {
            require("formatter.filetypes.json").prettier,
          },
          html = {
            require("formatter.filetypes.html").prettier,
          },
          css = {
            require("formatter.filetypes.css").prettier,
          },
          ['php'] = php_formatter,
          ['ctp'] = php_formatter,
          -- Use the special "*" filetype for defining formatter configurations on
          -- any filetype
          ["*"] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            require("formatter.filetypes.any").remove_trailing_whitespace,
            -- Remove trailing whitespace without 'sed'
            -- require("formatter.filetypes.any").substitute_trailing_whitespace,
          },
        },
      })
    end,
  },
}
