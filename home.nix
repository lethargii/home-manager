{ config, pkgs, lib, nix-flatpak, ... }:
{
	imports = [
		nix-flatpak.homeManagerModules.nix-flatpak
	];
  home.username = "lethargii";
  home.homeDirectory = "/home/lethargii";

  home.stateVersion = "26.05";

	services.protonmail-bridge.enable = true;

  home.packages = with pkgs; [
    # GUI
    firefox
		mullvad-browser
    tor-browser
    papers
    cavasik
    foliate
    geary
		seahorse
		baobab
		gnome-disk-utility
	] ++ lib.optionals (builtins.getEnv "GAMING" == "1") [
		# Games
		heroic
		openmw
		highscore
		melonds
		protontricks
    prismlauncher
	] ++ lib.optionals (builtins.getEnv "RIPPING" == "1") [
		# Ripping
    eartag
	] ++ lib.optionals (builtins.getEnv "TABLET" == "1") [
		# Tablet
    pinta
    rnote
	] ++ [
    vesktop
    ghostty
    vscodium
    eyedropper
    onlyoffice-desktopeditors
    impression
    nautilus
    gnome-online-accounts-gtk
    zrythm
		(bottles.override { removeWarningPopup = true;})
    # TUI
    tmux
    fish
    fastfetch
    git
		github-cli
    # Interpreters and compilers
    python3
    gcc
    lua
    luarocks
    rustc
    cargo
    dotnet-sdk_10
    bun
    # CLI
		nix-index
    unzip
		asciiquarium
    postgresql
		rsync
		imagemagick
		e2fsprogs
  ];

  home.file = {
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs = {
		home-manager.enable = true;
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
			"com.kagi.Orion"
      "page.codeberg.M23Snezhok.Vinyl"
		] ++ lib.optionals (builtins.getEnv "RIPPING" == "1") [
      "io.github.dzheremi2.lrcmake-gtk"
      "nl.andreasknoben.Laser"
		] ++ lib.optionals (builtins.getEnv "GAMING" == "1") [
			"modmanager-origin:app/io.github.Amethyst.ModManager"
      "io.github.MakovWait.Godots"
		] ++ lib.optionals (builtins.getEnv "DESKTOP" == "1") [
      "net.trowell.kotoba"
      "org.gtk.Gtk3theme.adw-gtk3"
      "org.gtk.Gtk3theme.adw-gtk3-dark"
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

}
