{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Automatic cleanup
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 5d";
  nix.optimise.automatic = true;

  networking.networkmanager.enable = true;

  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  services.xserver.xkb = {
    layout = "br";
  };
  console.keyMap = "br-abnt2";

  environment.sessionVariables = {
    XKB_DEFAULT_LAYOUT = "br";
  };

  users.users."nicolas" = {
    isNormalUser = true;
    description = "nicolas";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
  stylix.image = ./wallpaper.png;
  stylix.targets.grub.enable = true;
  stylix.fonts = {
  monospace = {
    package = pkgs.nerd-fonts.jetbrains-mono;
    name = "JetBrainsMono Nerd Font";
  };
  sansSerif = {
    package = pkgs.dejavu_fonts;
    name = "DejaVu Sans";
  };
  serif = {
    package = pkgs.dejavu_fonts;
    name = "DejaVu Serif";
  };
  emoji = {
  package = pkgs.noto-fonts-color-emoji;
  name = "Noto Color Emoji";
  };
};
 
  programs.fish.enable = true; 
  users.users.nicolas.shell = pkgs.fish;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim
    wget
    btop
    git
    vscodium
  ];

  system.stateVersion = "26.05";
}
