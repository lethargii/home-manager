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
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs =
    { nixpkgs, home-manager, nix-flatpak, nixvim, ... }:
    let
      arch = builtins.getEnv "ARCH";
      pkgs = nixpkgs.legacyPackages.${arch};
      user = builtins.getEnv "USER";
    in
    {
      homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				extraSpecialArgs = { inherit nix-flatpak; };
        modules = [
					nixvim.homeModules.nixvim
					./home.nix
				];
      };
    };
}
