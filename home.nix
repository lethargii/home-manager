{ config, pkgs, lib, nix-flatpak, ... }:
{
	imports = [
		nix-flatpak.homeManagerModules.nix-flatpak
	] ++ lib.optionals (builtins.getEnv "DESKTOP" == "1") [
    ./nvim.nix
		./nvim_colors.nix
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

	services = {
		protonmail-bridge.enable = true;
		awww.enable = true;
		swaync = {
			enable = true;
			#style = ./swaync/style.css;
		};
		swayosd.enable = true;
	};

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
    zrythm
		(bottles.override { removeWarningPopup = true;})
		qucs-s
		spice-up
		inkscape
		ironbar
		swaynotificationcenter
    swayosd
    fractal
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
		".config/background".source = builtins.fetchurl { url = "https://press.na.square-enix.com/Files/File?url=Q81XdHF0AZe4uWM4lLOQQd7x8HGL%2baOSgQvmSqo3pyIvT%2fvnzXhGwKr7g4vg2vwNatD4Zb2qzmqMT0SmR3gej48B4X8DeGtlC6FnAJtbT48jGu7JQ3KUTuuikGG9GF%2bW8MIW3RLk6VN2UI8sc6HnNY09SWN2z9UKtRPpBzO%2by6GHbGFeEco5XyZON4Elj0diq5C1RXJvAmngunFgxXdyWrrq6%2fDaHf6LX%2fAseIPz0MLwOAOq0BIn5wqwPKSmeYuuP6Eo0eEWOiLQUdqAmLy25ODlfxF5iMP2skP4dh1%2fMWvG%2ffghoQoj644A0r3HOhwZL3tzTfIq9wZmmcuDIQ1xcw%2bifhiFXjLgL4xGIzxmFbx5aH%2bXnifrF7uny1hsR1y3ysBdJ3lI%2fsa4zeHGhqld6Ul%2ba8NleBBvKZ7tJc0mVh0AN0mVSwOvByChhBhbK7t%2fwHxWbEiVkcPblH8EB7QllVT4QZoC7X05LexG6N2k%2bRxhp%2bO552zCwGK1%2f8dikbDBoN91OsuaI9mEzp7JYcZGAw%3d%3d"; name = "background"; };
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
