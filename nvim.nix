{ config, pkgs, lib, nix-flatpak, ... }:
{
	programs.nixvim.colorschemes.base16 = {
		enable = true;
		colorscheme = {
			base00 = "#1e2724";
			base01 = "#4F6C9D";
			base02 = "#A55E91";
			base03 = "#6897A4";
			base04 = "#66BBD1";
			base05 = "#9AA99F";
			base06 = "#B0C3BF";
			base07 = "#c6c9c8";
			base08 = "#637a72";
			base09 = "#4F6C9D";
			base0a = "#A55E91";
			base0b = "#6897A4";
			base0c = "#66BBD1";
			base0d = "#9AA99F";
			base0e = "#B0C3BF";
			base0f = "#c6c9c8";
		};
	};
}
