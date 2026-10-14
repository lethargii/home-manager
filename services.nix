{ config, pkgs, lib, nix-flatpak, ... }:
{
	services = {
		awww.enable = true;
		swaync = {
			enable = true;
			#style = ./swaync/style.css;
		};
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
}
