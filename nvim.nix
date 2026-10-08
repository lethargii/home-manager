{ config, pkgs, lib, nix-flatpak, ... }:
{
	programs.nixvim.colorschemes.base16 = {
		enable = true;
		colorscheme = {
			base00 = "#c6c9c8";
			base01 = "#ccffff";
			base02 = "#75cee6";
			base03 = "#b3f0c7";
			base04 = "#5788db";
			base05 = "#c6c9c8";
			base06 = "#70ffff";
			base07 = "#fdffff";
			base08 = "#1e2724";
			base09 = "#B0C3BF";
			base0A = "#6897A4";
			base0B = "#9AA99F";
			base0C = "#4F6C9D";
			base0D = "#A55E91";
			base0E = "#66BBD1";
			base0F = "#c6c9c8";
		};
	};
}
