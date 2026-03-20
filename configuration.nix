# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
 # boot.loader.systemd-boot.enable = true;
  boot.loader.grub = {
  enable = true;
  device = "nodev";
  efiSupport = true;
};
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "loglevel=3" "quiet" "rd.systemd.show_status=false" ];
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.plymouth.enable = true;
  
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
 # services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  #services.xserver.xkb = {
   # layout = "br";
    #variant = "thinkpad";
 # };

  # Configure console keymap
  #console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nicolas = {
    isNormalUser = true;
    description = "nicolas";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install librewolf.
  #programs.librewolf-bin.enable = true;

	programs.river-classic.enable = true;
        programs.foot.enable = false;
 
    services.fprintd.enable = true;
    security.pam.services.sudo.fprintAuth = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  git 
  ];


	programs.steam.enable = true;

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

        programs.kdeconnect.enable = true;	
  
        services.flatpak.enable = true;

  stylix = {
  enable = true;
#  image = "${inputs.nix-wallpaper.packages.${pkgs.system}.default.override {
#  preset = "gruvbox-dark";
#}}/share/wallpapers/nixos-wallpaper.png";
  targets.grub.useWallpaper = true;
  targets.plymouth.enable = true;
  image = ./forest-2.jpg;
  polarity = "dark";
  base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";
  cursor = {
  package = pkgs.capitaine-cursors-themed;
  name = "Capitaine Cursors (Gruvbox)";
  size = 20;
};
#  base16Scheme = {
#  scheme = "Dark Violet";
#  author = "ruler501 (https://github.com/ruler501/base16-darkviolet)";
#  base00 = "000000";
#  base01 = "231a40";
#  base02 = "432d59";
#  base03 = "593380";
#  base04 = "00ff00";
#  base05 = "b08ae6";
#  base06 = "9045e6";
#  base07 = "a366ff";
#  base08 = "a82ee6";
#  base09 = "bb66cc";
#  base0A = "f29df2";
#  base0B = "4595e6";
#  base0C = "40dfff";
#  base0D = "4136d9";
#  base0E = "7e5ce6";
#  base0F = "a886bf";
#};


  fonts = {
    sizes.applications = 10;
    sizes.terminal = 10;
    sizes.desktop = 15;
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
    };
    sansSerif = {
      package = pkgs.inter;
      name = "Inter";
    };
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };
  };
};

xdg.portal = {
  enable = true;
  wlr.enable = true;
  extraPortals = [ pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk ];
  config = {
    river = {
      default = [ "wlr" "gtk" ];
    };
  };
};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  environment.sessionVariables = {
  NIXOS_OZONE_WL = "1";
  MOZ_ENABLE_WAYLAND = "1";
  XCURSOR_THEME = "Capitaine Cursors (Gruvbox)";
  XCURSOR_SIZE = "20";
};

services.greetd.enable = true;
programs.regreet.enable = true;
programs.dconf.enable = true;

services.udisks2.enable = true;
services.gvfs.enable = true;

#automatic cleaing
nix.gc.automatic = true;
nix.gc.dates = "daily";
nix.gc.options = "--delete-older-than 5d";
nix.optimise.automatic = true;

#auto updates
#system.autoUpgrade.enable = true;
#system.autoUpgrade.dates = "weekly";
# system.autoUpgrade.flake = "github:yourusername/your-nixos-config";


}
