{
  description = "Home Manager configuration of lethargii";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
		nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs =
    { nixpkgs, home-manager, nix-flatpak, ... }:
    {
      homeConfigurations."lethargii" = home-manager.lib.homeManagerConfiguration {
				pkgs = nixpkgs.legacyPackages.x86_64-linux;
				extraSpecialArgs = { inherit nix-flatpak; };
        modules = [
					./home.nix
				];
      };
    };
}
