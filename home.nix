{ config, pkgs, lib, nix-flatpak, ... }:
let
	background = builtins.fetchurl { url = "https://press.na.square-enix.com/Files/File?url=Q81XdHF0AZe4uWM4lLOQQd7x8HGL%2baOSgQvmSqo3pyIvT%2fvnzXhGwKr7g4vg2vwNatD4Zb2qzmqMT0SmR3gej48B4X8DeGtlC6FnAJtbT48jGu7JQ3KUTuuikGG9GF%2bW7RmfusbixLuNHMh27qfAhgQV81cMvXzxTaZZjk%2bNFA3FJFoMF2zP8y%2bvU4%2fje1DbypGYSYA7EQEEgLsYhRjxinKp%2fPYoeit%2fN4lMF9S4cZVr3cvSRIB4WyNWApKw6RvruoomtKhTCyrqqTg0zet7iqfNk0CzMbppvlqf4voFd2R23myLLMNFcrl1OZkyA7xOf4%2biRTcF9UoR0ikr5WI8LzB0DWxu7DNKR01i42E%2fj43Njn6WDtQjS1R9RaszIYyg4uWab52IvwSdQm48IL1Zb9wNqhNJRBwnHnGwk3UsPP%2fL6sZ5zO8M02VjWpwh68tqWBAFt%2bfrL0Ju5Aqo9q1UYKjETIjKFt1g4InQp9O1UbU%2bc02qeqHJtyJSjTf%2bOMMhgbU2V7EZ8R6RYvaWxIjW7A%3d%3d"; name = "background"; sha256 = "547f40b369c6455f56541466f58335e497ffc6c98ec6a5af37685a980df26f74"; };
in
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
		inkscape
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
		".config/wpg/templates/config_gtk-4.0_colors.css.base".source = ./config_gtk-4.0_colors.css.base;
		".config/wpg/templates/config_gtk-3.0_colors.css.base".source = ./config_gtk-3.0_colors.css.base;
		".config/wpg/templates/config_AdwSteamGtk_custom.css.base".source = ./config_AdwSteamGtk_custom.css.base;
		".config/wpg/templates/config_ashell_config.toml.base".source = ./config_ashell_config.toml.base;
		".config/wpg/templates/config_niri_colors.kdl.base".source = ./config_niri_colors.kdl.base;
		".config/wpg/templates/config_wofi_colors.css.base".source = ./config_wofi_colors.css.base;
		".config/wpg/templates/cache_wal_colors-wal.vim.base".source = ./cache_wal_colors-wal.vim.base;
		".config/wpg/templates/ghostty_themes_Matugen.base".source = ./ghostty_themes_Matugen.base;
		".config/wpg/templates/vesktop_themes_midnight-discord.css.base".source = ./vesktop_themes_midnight-discord.css.base;
		".config/fish/config.fish".source = ./config.fish;
		".config/gtk-3.0/gtk.css".source = ./gtk.css;
		".config/gtk-4.0/gtk.css".source = ./gtk.css;
		".config/ghostty/config.ghostty".source = ./config.ghostty;
		".config/niri/config.kdl".source = ./config.kdl;
		".config/niri/wofi.sh".source = ./wofi.sh;
		".config/tmux/tmux.conf".source = ./tmux.conf;
		".config/ashell/config.toml".source = ./config.toml;
		".config/wofi/config".source = ./config;
		".config/wofi/style.css".source = ./style.css;
		".config/background".source = background;
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
						completion.list.selection = {
							auto_insert = false;
							preselect = false;
						};
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
								"accept"
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

	gtk = {
		enable = true;
		gtk3.theme = {
			name = "adw-gtk3-dark";
			package = pkgs.adw-gtk3;
		};
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
			"io.github.tobagin.karere"
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
