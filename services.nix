{ config, pkgs, lib, nix-flatpak, ... }:
{
	services = {
		protonmail-bridge.enable = true;
		awww.enable = true;
		swaync = {
			enable = true;
			#style = ./swaync/style.css;
		};
	};
}
