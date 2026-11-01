{
  pkgs,
  ...
}:
{
  home.file = {
    ".config/autostart/org.gnome.clocks.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Clocks
      Exec=${pkgs.gnome-clocks}/bin/gnome-clocks
      X-GNOME-Autostart-enabled=true
    '';
  };
}
