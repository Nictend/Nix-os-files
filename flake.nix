{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    helium-flake.url = "github:oxcl/nix-flake-helium-browser";
    helium-flake.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { nixpkgs, helium-flake, ... }: {
    nixosConfigurations.pc2010 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./common.nix
        ./dwl.nix
        ./hosts/pc2010/configuration.nix
        helium-flake.nixosModules.default
        ({ pkgs, ... }: {
          nixpkgs.overlays = [ helium-flake.overlays.default ];
          programs.helium.enable = true;
          programs.helium.flags = [ "--disable-accelerated-video-decode" ];
          # programs.helium.policies = { SyncDisabled = true; };
        })
      ];
    };

    nixosConfigurations.t14gen2 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./common.nix
        ./hosts/t14gen2/configuration.nix
        helium-flake.nixosModules.default
        ({ pkgs, ... }: {
          nixpkgs.overlays = [ helium-flake.overlays.default ];
          programs.helium.enable = true;
          #  programs.helium.flags = [ "--disable-accelerated-video-decode" ];
        })
      ];
    };
  };
}
