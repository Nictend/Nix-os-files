{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    helium-flake.url = "github:oxcl/nix-flake-helium-browser";
    helium-flake.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, helium-flake, ... }: {
    # Attribute name matches the hostname nixos-rebuild will look for
    # (your machine's hostname is currently "nixos").
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        helium-flake.nixosModules.default
        ({ pkgs, ... }: {
          nixpkgs.overlays = [ helium-flake.overlays.default ];
          programs.helium.enable = true;
          programs.helium.flags = [ "--disable-accelerated-video-decode" ];
          # programs.helium.policies = { SyncDisabled = true; };
        })
      ];
    };
  };
}
