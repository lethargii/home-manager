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
    geary
    papers
    foliate
    firefox
	] ++ lib.optionals (builtins.getEnv "DESKTOP" == "1") [
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
    nautilus
    gnome-online-accounts-gtk
    zrythm
		(bottles.override { removeWarningPopup = true;})
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
  ];

  home.file = {
  };

  home.sessionVariables = {
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
      "page.codeberg.M23Snezhok.Vinyl"
      "org.gtk.Gtk3theme.adw-gtk3"
      "org.gtk.Gtk3theme.adw-gtk3-dark"
		] ++ lib.optionals (builtins.getEnv "RIPPING" == "1") [
      "io.github.dzheremi2.lrcmake-gtk"
      "nl.andreasknoben.Laser"
		] ++ lib.optionals (builtins.getEnv "GAMING" == "1") [
			"modmanager-origin:app/io.github.Amethyst.ModManager"
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

}
