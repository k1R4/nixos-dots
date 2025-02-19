{
  description = "k1R4's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixvim = {
    #   url = "github:nix-community/nixvim";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    mkSystem = system: hostname:
      nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        pkgs = import nixpkgs {
          system = system;
          config.allowUnfree = true;
        };
        modules = [
          {networking.hostName = hostname;}
          ./modules/system/configuration.nix
          (./. + "/hosts/${hostname}/hardware-configuration.nix")
          ./modules/system/home.nix
          (./. + "/hosts/${hostname}/user.nix")
        ];
      };
  in {
    nixosConfigurations = {
      enderman = mkSystem "x86_64-linux" "enderman";
    };
  };
}
