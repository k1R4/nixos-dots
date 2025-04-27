{
  description = "k1R4's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pwndbg.url = "github:pwndbg/pwndbg";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    ags.url = "github:aylur/ags";

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
          config.permittedInsecurePackages = ["python-2.7.18.8"];
        };
        modules = [
          {networking.hostName = hostname;}
          ./hosts/common/configuration.nix
          (./. + "/hosts/${hostname}/hardware-configuration.nix")
          ./hosts/common/home.nix
          (./. + "/hosts/${hostname}/user.nix")
        ];
      };
  in {
    nixosConfigurations = {
      enderman = mkSystem "x86_64-linux" "enderman";
    };
  };
}
