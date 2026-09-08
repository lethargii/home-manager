{ config, pkgs, lib, nix-flatpak, ... }:
{
	imports = [
		nix-flatpak.homeManagerModules.nix-flatpak
	];
  home.username = builtins.getEnv "USER";
  home.homeDirectory = "/home/${config.home.username}";

  home.stateVersion = "26.05";

	targets.genericLinux.enable = (builtins.getEnv "SYSTEM" != "nixos");

	services.protonmail-bridge.enable = true;

	nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # GUI
    nautilus
    geary
    papers
    foliate
    gnome-calendar
	] ++ lib.optionals (builtins.getEnv "DESKTOP" == "1") [
    firefox
		mullvad-browser
    tor-browser
    cavasik
		seahorse
		baobab
		gnome-disk-utility
    vesktop
    vscodium
    eyedropper
    onlyoffice-desktopeditors
    impression
    gnome-online-accounts-gtk
    zrythm
		(bottles.override { removeWarningPopup = true;})
		qucs-s
		spice-up
	] ++ lib.optionals (builtins.getEnv "PHONE" == "1") [
    decibels
    showtime
    gnome-clocks
    snapshot
    gnome-contacts
    ptyxis
		folio
		epiphany
    ] ++ lib.optionals (builtins.getEnv "GAMING" == "1") [
		## Games
		heroic
		openmw
		highscore
		melonds
		protontricks
    prismlauncher
	] ++ lib.optionals (builtins.getEnv "RIPPING" == "1") [
		## Ripping
    eartag
	] ++ lib.optionals (builtins.getEnv "TABLET" == "1") [
		## Tablet
    pinta
    rnote
	] ++ [
    # TERMINAL
    ghostty
		## TUI
    tmux
    fish
    fastfetch
    git
		github-cli
		asciiquarium
	] ++ lib.optionals (builtins.getEnv "DESKTOP" == "1") [
    ## CLI
		nix-index
    unzip
    postgresql
		rsync
		imagemagick
		e2fsprogs
    # Interpreters and compilers
    python3
    gcc
    lua
    luarocks
    rustc
    cargo
    dotnet-sdk_10
    bun
    # Modding
		android-tools
  ] ++ [
		# Theming
    adw-gtk3
    adwsteamgtk
    wpgtk
		glib.dev
    papirus-icon-theme
		# Fonts
    nerd-fonts.departure-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-sans-static
    noto-fonts-cjk-serif
    noto-fonts-cjk-serif-static
    noto-fonts-color-emoji
		corefonts
	];

  home.file = {
  };

  home.sessionVariables = {
  };

  programs = {
		home-manager.enable = true;
		nixvim = {
      enable = true;
			nixpkgs.config.allowUnfree = true;
      globals.mapleader = " ";
      opts = {
        tabstop = 2;
        shiftwidth = 2;
				clipboard = "unnamedplus";
				number = true;
      };
      colorschemes.base16.enable = true;
			diagnostic.settings = {
				virtual_lines = {
					current_line = true;
				};
				virtual_text = false;
			};
      plugins = {
        blink-cmp = {
          enable = true;
          setupLspCapabilities = true;
          settings = {
            sources = {
              default = [
                "lsp"
                "buffer"
                "path"
                "snippets"
              ];
            };
						keymap = {
							"<S-Tab>" = [
								"select_prev"
								"fallback"
							];
							"<Tab>" = [
								"select_next"
								"fallback"
							];
							"<C-space>" = [
								"show"
								"show_documentation"
								"hide_documentation"
							];
							"<Enter>" = [
								"select_and_accept"
								"fallback"
							];
						};
          };
        };
        lualine.enable = true;
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
        treesitter = {
          enable = true;
          highlight.enable = true;
          indent.enable = true;
        };
        which-key = {
          enable = true;
        };
				nvim-autopairs.enable = true;
				barbar.enable = true;
				comment = {
					enable = true;
					settings = {
						mappings.basic = true;
					};
				};
				dap.enable = true;
				dap-ui.enable = true;
				indent-blankline.enable = true;
				lazygit.enable = true;
				luasnip.enable = true;
				none-ls.enable = true;
				nvim-tree.enable = true;
				ts-autotag = {
					enable = true;
					settings = {
						opts = {
							enable_close = true;
							enable_close_on_slash = true;
							enable_rename = true;
						};
					};
				};
				web-devicons.enable = true;
				gitsigns.enable = true;
				transparent.enable = true;
      };
			keymaps = [
				{
					mode = "n";
					key = "<leader>e";
					action = "<cmd>NvimTreeOpen<CR>";
				}
				{
					mode = "n";
					key = "<leader>lg";
					action = "<cmd>LazyGit<CR>";
				}
			];
    };
		lazygit.enable = true;
	};

	services.flatpak = {
		update.onActivation = true;
		uninstallUnmanaged = true;
		remotes = [
			{ name = "flathub"; location = "https://dl.flathub.org/repo/flathub.flatpakrepo"; }
			{ name = "flathub-beta"; location = "https://dl.flathub.org/beta-repo/flathub-beta.flatpakrepo"; }
			{ name = "orion-beta"; location = "https://flatpak.orionbrowser.com/orion-beta.flatpakrepo"; }
			{ name = "modmanager-origin"; location = "https://chrisdkn.github.io/Amethyst-Mod-Manager/amethyst.flatpakrepo"; }
		];
		packages = [
      "ca.edestcroix.Recordbox"
      "org.gtk.Gtk3theme.adw-gtk3"
      "org.gtk.Gtk3theme.adw-gtk3-dark"
		] ++ lib.optionals (builtins.getEnv "RIPPING" == "1") [
      "io.github.dzheremi2.lrcmake-gtk"
      "nl.andreasknoben.Laser"
		] ++ lib.optionals (builtins.getEnv "GAMING" == "1") [
			"moe.nomm.Nomm"
      "io.github.MakovWait.Godots"
		] ++ lib.optionals (builtins.getEnv "DESKTOP" == "1") [
			"com.kagi.Orion"
      "net.trowell.kotoba"
		] ++ lib.optionals (builtins.getEnv "PHONE" == "1") [
			"io.github.erenseymen.android-tv-remote"
		];
		overrides.settings = {
			global.Context = {
				filesystems = [
					"xdg-config/gtk-3.0/gtk.css"
					"xdg-config/gtk-3.0/colors.css"
					"xdg-config/gtk-4.0/gtk.css"
					"xdg-config/gtk-4.0/colors.css"
					"xdg-data/themes"
				];
			};
		};
	};

  fonts.fontconfig.enable = true;
}
