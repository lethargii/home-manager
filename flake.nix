{
  description = "Home Manager configuration of lethargii";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
		flatpaks.url = "github:in-a-dil-emma/declarative-flatpak/latest";
  };

  outputs =
    { nixpkgs, home-manager, flatpaks, ... }:
    {
      homeConfigurations."lethargii" = home-manager.lib.homeManagerConfiguration {
				pkgs = nixpkgs.legacyPackages.x86_64-linux;
				extraSpecialArgs = { inherit flatpaks; };
        modules = [
					./home.nix
				];
      };
    };
}
