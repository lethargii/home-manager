{ config, pkgs, lib, nix-flatpak, ... }:
{
	imports = [
		nix-flatpak.homeManagerModules.nix-flatpak
	] ++ lib.optionals (builtins.getEnv "DESKTOP" == "1") [
    ./nvim.nix
		./nvim_colors.nix
	] ++ lib.optionals (builtins.getEnv "RICE" == "1") [
		./services.nix
	];

	nixpkgs.overlays = [
		(final: prev: {
    	swaynotificationcenter = prev.swaynotificationcenter.overrideAttrs (old: {
      	postInstall = (old.postInstall or "") + ''
        	echo "" > $out/etc/xdg/swaync/style.css
      	'';
    	});
  	})
	];
  home.username = builtins.getEnv "USER";
  home.homeDirectory = "/home/${config.home.username}";

  home.stateVersion = "26.05";

	targets.genericLinux.enable = (builtins.getEnv "SYSTEM" != "nixos");

	systemd.user.services.ironbar = {
    Unit = {
      Description = "Run ironbar.";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
      Requisite = [ "graphical-session.target" ];
    };
		Install = {
			WantedBy = [ "niri.service" ];
		};
    Service = {
      ExecStart = "${pkgs.ironbar}/bin/ironbar";
		};
  };


	nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # GUI
    nautilus
    geary
    papers
    foliate
    gnome-calendar
		decibels
		recordbox
	] ++ lib.optionals (builtins.getEnv "DESKTOP" == "1") [
    ghostty
    firefox
		mullvad-browser
    tor-browser
    cavasik
		seahorse
		baobab
		gnome-disk-utility
    vesktop
    vscodium
		cambalache
    eyedropper
    onlyoffice-desktopeditors
    impression
    gnome-online-accounts-gtk
		(bottles.override { removeWarningPopup = true;})
		qucs-s
		spice-up
		inkscape
		ironbar
		swaynotificationcenter
    swayosd
    fractal
		mission-center
		networkmanagerapplet
		anyrun
		awww
	] ++ lib.optionals (builtins.getEnv "PHONE" == "1") [
    ptyxis
    showtime
    gnome-clocks
    snapshot
    gnome-contacts
		folio
		epiphany
    ] ++ lib.optionals (builtins.getEnv "GAMING" == "1") [
		## Games
    adwsteamgtk
		heroic
		openmw
		highscore
		melonds
		protontricks
    prismlauncher
		supertuxkart
	] ++ lib.optionals (builtins.getEnv "RIPPING" == "1") [
		## Ripping
    eartag
	] ++ lib.optionals (builtins.getEnv "TABLET" == "1") [
		## Tablet
    pinta
    rnote
	] ++ [
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
		graphviz
		ffmpeg
		wl-mirror
		jq
		libnotify
		hellwal
		pywal16
		wallust
		matugen
    # Interpreters and compilers
    python3
    gcc
    lua
    luarocks
    rustc
    cargo
    dotnet-sdk_10
    bun
		jdk
    # Modding
		android-tools
  ] ++ [
		# Theming
    adw-gtk3
    wpgtk
		# Fonts
    nerd-fonts.departure-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.adwaita-mono
    nerd-fonts.fira-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-sans-static
    noto-fonts-cjk-serif
    noto-fonts-cjk-serif-static
    noto-fonts-color-emoji
		corefonts
	];

  home.file = {
		".config/wpg/templates/config_gtk-3.0_colors.css.base".source = ./wpg/config_gtk-3.0_colors.css.base;
		".config/wpg/templates/config_gtk-4.0_colors.css.base".source = ./wpg/config_gtk-4.0_colors.css.base;
		".config/wpg/templates/config_niri_colors.kdl.base".source = ./wpg/config_niri_colors.kdl.base;
		".config/swayosd".source = ./swayosd;
		".config/anyrun".source = ./anyrun;
		#".config/ironbar".source = ./ironbar;
		".config/fish/config.fish".source = ./fish/config.fish;
		".config/gtk-3.0/gtk.css".source = ./gtk/gtk.css;
		".config/gtk-4.0/gtk.css".source = ./gtk/gtk.css;
		".config/ghostty/config.ghostty".source = ./ghostty/config.ghostty;
		".config/niri/config.kdl".source = ./niri/config.kdl;
		".config/tmux/tmux.conf".source = ./tmux/tmux.conf;
  };

  home.sessionVariables = {
  };

  programs = {
		home-manager.enable = true;
		direnv = {
			enable = true;
			enableFishIntegration = true;
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

  fonts.fontconfig.enable = true;
}
