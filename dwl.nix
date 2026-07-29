{ config, pkgs, ... }:

{
  services.displayManager.ly.enable = true;
  programs.dwl.enable = true;

  environment.systemPackages = with pkgs; [
    foot
    wmenu
    nautilus
  ];
}
