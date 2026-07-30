{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    helium-flake.url = "github:oxcl/nix-flake-helium-browser";
    helium-flake.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { nixpkgs, helium-flake, stylix, home-manager, ... }: {
    nixosConfigurations.pc2010 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./common.nix
        ./dwl.nix
        ./hosts/pc2010/configuration.nix
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        helium-flake.nixosModules.default
        ({ pkgs, ... }: {
          nixpkgs.overlays = [ helium-flake.overlays.default ];
          programs.helium.enable = true;
          programs.helium.flags = [ "--disable-accelerated-video-decode" ];
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nicolas = import ./home/pc2010.nix;
        })
      ];
    };

    nixosConfigurations.t14gen2 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./common.nix
        ./hosts/t14gen2/configuration.nix
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        helium-flake.nixosModules.default
        ({ pkgs, ... }: {
          nixpkgs.overlays = [ helium-flake.overlays.default ];
          programs.helium.enable = true;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nicolas = import ./home/t14gen2.nix;
        })
      ];
    };
  };
}
