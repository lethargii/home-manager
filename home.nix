{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = lib.optionals (builtins.getEnv "DESKTOP" == "1") [
    ./nvim.nix
    ./nvim_colors.nix
  ];

  home.username = builtins.getEnv "USER";
  home.homeDirectory = "/home/${config.home.username}";

  home.stateVersion = "26.05";

  targets.genericLinux.enable = (builtins.getEnv "SYSTEM" != "nixos");

  services = {
    protonmail-bridge.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  home.packages =
    with pkgs;
    [
      # GUI
      nautilus
      convey
      papers
      foliate
      gnome-calendar
      decibels
      recordbox
      snapshot
      fotema
      loupe
      showtime
      fractal
      cobang
    ]
    ++ lib.optionals (builtins.getEnv "DESKTOP" == "1") [
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
      (bottles.override { removeWarningPopup = true; })
      qucs-s
      spice-up
      inkscape
      ironbar
      swaynotificationcenter
      swayosd
      mission-center
      gaphor
      gnome-decoder
      video-downloader
      halftone
      networkmanagerapplet
      anyrun
      awww
    ]
    ++ lib.optionals (builtins.getEnv "PHONE" == "1") [
      ptyxis
      gnome-clocks
      gnome-contacts
      folio
      epiphany
      proton-vpn
      android-tv-remote
      nano
    ]
    ++ lib.optionals (builtins.getEnv "GAMING" == "1") [
      ## Games
      adwsteamgtk
      heroic
      openmw
      highscore
      melonds
      protontricks
      prismlauncher
      supertuxkart
    ]
    ++ lib.optionals (builtins.getEnv "RIPPING" == "1") [
      ## Ripping
      eartag
    ]
    ++ lib.optionals (builtins.getEnv "TABLET" == "1") [
      ## Tablet
      pinta
      rnote
    ]
    ++ [
      ## TUI
      tmux
      fish
      fastfetch
      git
      github-cli
      asciiquarium
    ]
    ++ lib.optionals (builtins.getEnv "DESKTOP" == "1") [
      ## CLI
      nix-index
      nixfmt
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
      wineWow64Packages.staging
      winetricks
      scrcpy
      psmisc
      v4l-utils
      nixpkgs-review
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
    ]
    ++ [
      # Theming
      matugen
      pywalfox-native
      adw-gtk3
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
    ".config/swayosd".source = ./swayosd;
    ".config/anyrun".source = ./anyrun;
    ".config/fish/config.fish".source = ./fish/config.fish;
    ".config/gtk-3.0/gtk.css".source = ./gtk/gtk.css;
    ".config/gtk-4.0/gtk.css".source = ./gtk/gtk.css;
    ".config/ghostty/config.ghostty".source = ./ghostty/config.ghostty;
    ".config/niri/config.kdl".source = ./niri/config.kdl;
    ".config/tmux/tmux.conf".source = ./tmux/tmux.conf;
    ".config/matugen/config.toml".source =
      if (builtins.getEnv "PHONE" == "1") then ./matugen/config_phone.toml else ./matugen/config.toml;
    ".config/matugen/templates/firefox-colors.css".source = ./matugen/firefox-colors.css;
    ".config/matugen/templates/ghostty".source = ./matugen/ghostty;
    ".config/matugen/templates/gnome-shell.css".source = ./matugen/gnome-shell.css;
    ".config/matugen/templates/gtk-colors.css".source = ./matugen/gtk-colors.css;
    ".config/matugen/templates/heroic.css".source = ./matugen/heroic.css;
    ".config/matugen/templates/midnight-discord.css".source = ./matugen/midnight-discord.css;
    ".config/matugen/templates/niri-colors.kdl".source = ./matugen/niri-colors.kdl;
    ".config/matugen/templates/nvim_colors.lua".source = ./matugen/nvim_colors.lua;
    ".config/matugen/templates/prismlauncher.json".source = ./matugen/prismlauncher.json;
    ".config/matugen/templates/pywalfox-colors.json".source = ./matugen/pywalfox-colors.json;
    ".config/matugen/templates/qtct-colors.conf".source = ./matugen/qtct-colors.conf;
    ".config/matugen/templates/steam.css".source = ./matugen/steam.css;
    ".config/matugen/templates/vscode-colors".source = ./matugen/vscode-colors;
    ".config/matugen/templates/vscode-colors.json".source = ./matugen/vscode-colors.json;
    ".config/matugen/post-hook-scripts/gtk-themes-reload.sh".source = ./matugen/gtk-themes-reload.sh;
    ".themes/Material-Gnome/index.theme".source = ./matugen/index.theme;
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
