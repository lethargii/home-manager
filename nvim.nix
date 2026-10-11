{ config, pkgs, lib, nix-flatpak, ... }:
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
					jdtls.enable = true;
					phpactor.enable = true;
					pyright.enable = true;
					sqls.enable = true;
					tailwindcss.enable = true;
					gitlab_ci_ls.enable = true;
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
					map_multistep('i', '<Tab>',   { 'minisnippets_next','minisnippets_expand','pmenu_next' })
					map_multistep('i', '<S-Tab>', { 'minisnippets_prev', 'pmenu_prev' })
					map_multistep('i', '<CR>',    { 'pmenu_accept', 'minipairs_cr' })
					map_multistep('i', '<BS>',    { 'minipairs_bs' })
				'';
			};
			dap.enable = true;
			dap-ui.enable = true;
			none-ls.enable = true;
			friendly-snippets.enable = true;
		};
		keymaps = [
			{
				mode = "n";
				key = "<leader>e";
				action = "<cmd>lua MiniFiles.open()<CR>";
			}
			{
				mode = "n";
				key = "<leader>lg";
				action = "<cmd>LazyGit<CR>";
			}
		];
	};
}
