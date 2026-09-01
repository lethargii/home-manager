{ config, pkgs, lib, flatpaks, ... }:

{
	imports = [
		flatpaks.homeModules.default
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
	] ++ lib.optionals (builtins.getEnv "HOSTNAME" == "spectre") [
		# Games
			##heroic
		openmw
		highscore
		melonds
		protontricks
    prismlauncher
		# Ripping
    eartag
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
		enable = true;
		remotes = {
			"flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      "flathub-beta" = "https://dl.flathub.org/beta-repo/flathub-beta.flatpakrepo";
			"orion-beta" = "https://flatpak.orionbrowser.com/orion-beta.flatpakrepo";
			"modmanager-origin" = "https://chrisdkn.github.io/Amethyst-Mod-Manager/amethyst.flatpakrepo";
		};
		packages = [
			"orion-beta:app/com.kagi.Orion//stable"
      "flathub:app/page.codeberg.M23Snezhok.Vinyl//stable"
		] ++ lib.optionals (builtins.getEnv "HOSTNAME" == "spectre") [
      "flathub:app/io.github.dzheremi2.lrcmake-gtk//stable"
      "flathub:app/nl.andreasknoben.Laser//stable"
			"modmanager-origin:app/io.github.Amethyst.ModManager//stable"
      "flathub:app/io.github.MakovWait.Godots//stable"
		] ++ [
      "flathub:app/net.trowell.kotoba//stable"
      "flathub:app/org.gtk.Gtk3theme.adw-gtk3//stable"
      "flathub:app/org.gtk.Gtk3theme.adw-gtk3-dark//stable"
		];
		overrides = {
			"global".Context = {
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
