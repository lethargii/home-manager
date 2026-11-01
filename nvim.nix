{
  ...
}:
{
  programs.nixvim = {
    enable = true;
    nixpkgs.config.allowUnfree = true;
    globals.mapleader = " ";
    opts = {
      tabstop = 2;
      shiftwidth = 2;
      clipboard = "unnamedplus";
      number = true;
    };
    diagnostic.settings = {
      virtual_lines = {
        current_line = true;
      };
      virtual_text = false;
    };

    plugins = {
      lsp = {
        enable = true;
        servers = {
          lua_ls.enable = true;
          vtsls.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
          roslyn_ls.enable = true;
          nixd.enable = true;
          clangd.enable = true;
          asm_lsp.enable = true;
          bashls.enable = true;
          cssls.enable = true;
          dockerls.enable = true;
          fish_lsp.enable = true;
          html.enable = true;
          emmet_ls.enable = true;
          jdtls.enable = true;
          phpactor.enable = true;
          pyright.enable = true;
          sqls.enable = true;
          tailwindcss.enable = true;
          gitlab_ci_ls.enable = true;
          matlab_ls.enable = true;
          ruby_lsp.enable = true;
          perlpls.enable = true;
          kotlin_language_server.enable = true;
          glsl_analyzer.enable = true;
        };
      };
      lint = {
        enable = true;
        lintersByFt = {
          html = [ "htmlhint" ];
          css = [ "stylelint" ];
          javascript = [ "eslint_d" ];
          typescript = [ "eslint_d" ];
          javascriptreact = [ "eslint_d" ];
          typescriptreact = [ "eslint_d" ];
          c = [
            "clangtidy"
            "cppcheck"
          ];
          cpp = [
            "clangtidy"
            "cppcheck"
          ];
          lua = [ "selene" ];
          python = [ "ruff" ];
          php = [
            "phpcs"
            "phpstan"
          ];
          r = [ "lintr" ];
          sql = [ "sqlfluff" ];
          ruby = [ "rubocop" ];
          perl = [ "perlcritic" ];
        };
      };
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            html = [ "prettierd" ];
            css = [ "prettierd" ];
            javascript = [ "prettierd" ];
            typescript = [ "prettierd" ];
            javascriptreact = [ "prettierd" ];
            typescriptreact = [ "prettierd" ];
            java = [ "google-java-format" ];
            csharp = [ "csharpier" ];
            c = [ "clang-format" ];
            cpp = [ "clang-format" ];
            lua = [ "stylua" ];
            python = [ "ruff_format" ];
            php = [ "php-cs-fixer" ];
            sql = [ "sqlfluff" ];
            ruby = [ "rubocop" ];
            rust = [ "rustfmt" ];
            perl = [ "perltidy" ];
            nix = [ "nixfmt" ];
            kotlin = [ "ktlint" ];
          };
          format_on_save = "{ timeout_ms = 500 }";
        };
      };
      # blink-cmp = {
      # 	enable = true;
      # 	setupLspCapabilities = true;
      # 	settings = {
      # 		completion.list.selection = {
      # 			auto_insert = false;
      # 			preselect = false;
      # 		};
      # 		sources = {
      # 			default = [
      # 				"lsp"
      # 				"buffer"
      # 				"path"
      # 				"snippets"
      # 			];
      # 		};
      # 		keymap = {
      # 			"<S-Tab>" = [
      # 				"select_prev"
      # 				"fallback"
      # 			];
      # 			"<Tab>" = [
      # 				"select_next"
      # 				"fallback"
      # 			];
      # 			"<C-space>" = [
      # 				"show"
      # 				"show_documentation"
      # 				"hide_documentation"
      # 			];
      # 			"<Enter>" = [
      # 				"accept"
      # 				"fallback"
      # 			];
      # 			"<Up>" = [
      # 				"fallback"
      # 			];
      # 			"<Down>" = [
      # 				"fallback"
      # 			];
      # 		};
      # 	};
      # };
      mini-completion = {
        enable = true;
        settings = {
          mappings = {
          };
        };
      };
      treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
      };
      mini-clue = {
        enable = true;
        settings = {
          triggers = [
            {
              keys = "<Leader>";
              mode = "n";
            }
          ];
        };
      };
      mini-statusline.enable = true;
      mini-pairs.enable = true;
      mini-tabline.enable = true;
      mini-comment.enable = true;
      mini-indentscope.enable = true;
      mini-git.enable = true;
      mini-files.enable = true;
      mini-icons.enable = true;
      mini-snippets.enable = true;
      mini-keymap = {
        enable = true;
        luaConfig.post = ''
                    					local map_multistep = require("mini.keymap").map_multistep
          										local minisnippets_stop = {
          											condition = function() return MiniSnippets.session.get() ~= nil end,
          											action = function() return function() MiniSnippets.session.stop() end end,
          										}
                    					map_multistep('i', '<Tab>',   { 'pmenu_next', 'minisnippets_next', 'minisnippets_expand' })
                    					map_multistep('i', '<S-Tab>', { 'pmenu_prev', 'minisnippets_prev' })
                    					map_multistep('i', '<CR>',    { 'pmenu_accept', minisnippets_stop, 'minipairs_cr' })
                    					map_multistep('i', '<BS>',    { 'minipairs_bs' })
                    				'';
      };
      dap.enable = true;
      dap-ui.enable = true;
      none-ls.enable = true;
      friendly-snippets.enable = true;
      transparent.enable = true;
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>lua MiniFiles.open()<CR>";
      }
      {
        mode = "n";
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
      }
      {
        mode = "x";
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
      }
    ];
  };
}
