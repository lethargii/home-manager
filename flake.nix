{
  description = "Home Manager configuration of lethargii";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:nix-community/nixvim";
    openmw-nix = {
      url = "git+https://codeberg.org/PopeRigby/openmw-nix.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixvim,
      openmw-nix,
      ...
    }:
    let
      arch = builtins.getEnv "ARCH";
      pkgs = nixpkgs.legacyPackages.${arch};
      user = builtins.getEnv "USER";
    in
    {
      homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          nixvim.homeModules.nixvim
          ./home.nix
          (
            { pkgs, lib, ... }:
            {
              home.packages =
                with openmw-nix.packages.x86_64-linux;
                lib.optionals (builtins.getEnv "GAMING" == "1") [
                  umo
                  momw-configurator
                  delta-plugin
                  groundcoverify
                  s3lightfixes
                  openmw-validator
                ];

            }
          )
        ];
      };
    };
}
