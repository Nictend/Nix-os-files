{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "t14gen2";

  boot.loader.grub.enable = true;
  # boot.loader.grub.device = "/dev/sdX"; # fill in when you're at the machine
  boot.loader.grub.useOSProber = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
}
