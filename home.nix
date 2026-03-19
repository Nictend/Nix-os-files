{ config, pkgs, lib, inputs, ... }:
{
 
  imports = [
  inputs.spicetify-nix.homeManagerModules.default
  inputs.nixcord.homeModules.nixcord
];

  home.username = "nicolas";
  home.homeDirectory = "/home/nicolas";
  home.stateVersion = "25.11";

  # User packages
  home.packages = with pkgs; [
    wlr-randr
    pamixer
    playerctl
    brightnessctl
    unzip
    unrar
    p7zip
    arduino-ide
    fastfetch
    git
    nerd-fonts.jetbrains-mono
    curl
    jq
    python3
    swaybg
    networkmanagerapplet
    grim
    slurp
    wl-clipboard
    nautilus
    evince  
    eog      
    gruvbox-plus-icons
    glib
    gruvbox-dark-icons-gtk
    gnome-disk-utility
    baobab
    lazygit
    micro
 ];

  # Stylix targets
  stylix.targets = {
    gtk.enable = true;
    alacritty.enable = true;
    btop.enable = true;
    qt.enable = true;
    fuzzel.enable = true;
    micro.enable = true;
    lazygit.enable = true;
        librewolf = {
      enable = true;
      colorTheme.enable = true;
      profileNames = [ "nicolas" ];
  };
 };

# home.nix
programs.alacritty.enable = true;
programs.btop.enable = true;
programs.zed-editor.enable = true;
programs.fuzzel = {
  enable = true;
  settings = {
    main = {
      font = lib.mkForce "Inter:size=14";
    };
  };
};
programs.vscode.enable = true;
programs.librewolf = {
  enable = true;
  profiles = {
    nicolas = {
settings = {
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
  };
      extensions = {
        force = true;
      };
    };
  };
};

stylix.iconTheme = {
  enable = true;
  package = pkgs.gruvbox-plus-icons;
  dark = "Gruvbox-Plus-Dark";
  light = "Gruvbox-Plus-Light";
};

programs.spicetify = {
  enable = true;
};

programs.nixcord = {
  enable = true;
  discord.enable = true;
};

programs.waybar = {
  enable = true;
  settings = {
    mainBar = {
      layer = "top";
      position = "top";
      height = 20;
      modules-left = [ "river/tags" ];
      modules-center = [ "clock" ];
      modules-right = [ "pulseaudio" "backlight" "battery" "tray" ];
      "river/tags" = {
        num-tags = 9;
      };
      "battery" = {
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
      };
      "backlight" = {
        format = "󰃞 {percent}%";
      };
      "pulseaudio" = {
        format = "󰕾 {volume}%";
        format-muted = "󰖁 muted";
      };
      "clock" = {
        format = "󰥔 {:%H:%M}";
        tooltip-format = "{:%Y-%m-%d}";
      };
    };
  };
  style = ''
    * {
      font-family: "JetBrainsMono Nerd Font";
      font-size: 12px;
      min-height: 0;
      padding: 0 4px;
        }
  #tags button.focused {
    background-color: @base0D;
    color: @base00;
  }
  #tags button.occupied {
    color: @base05;
  }
  #tags button.urgent {
    background-color: @base08;
    color: @base00;
  }
  '';
};


programs.git = {
  enable = true;
  userName = "Nictend";
  userEmail = "gabrieldesouzanicolas@gmail.com";
    extraConfig = {
    safe.directory = "/etc/nixos";
    init.defaultBranch = "main";
  };
};

home.file.".config/river/init" = {
  executable = true;
  text = ''
    #!/bin/sh

    export XDG_CURRENT_DESKTOP=river
    # Import wayland env into systemd user session
systemctl --user import-environment WAYLAND_DISPLAY
dbus-update-activation-environment --systemd WAYLAND_DISPLAY
  
    # Wallpaper
    swaybg -m fill -i ${config.stylix.image} &

    # Scale
    wlr-randr --output eDP-1 --scale 1.7

    # Cursor
    riverctl xcursor-theme "Capitaine Cursors (Gruvbox)" 25
   
    # Keyboard layout
    riverctl keyboard-layout -variant thinkpad br

    # Set keyboard repeat rate
    riverctl set-repeat 50 300

    # Border
    riverctl background-color 0x002b36
    riverctl border-width 0

    # App launcher
    riverctl map normal Super D spawn fuzzel

    # Status bar
    waybar &

    # Terminal
    riverctl map normal Super T spawn alacritty

    # Close view
    riverctl map normal Super Q close

    # Exit river
    riverctl map normal Super+Shift E exit

    # Screenshots
    riverctl map normal None Print spawn 'grim ~/Pictures/$(date +%Y%m%d_%H%M%S).png'
    riverctl map normal Super Print spawn 'grim -g "$(slurp)" ~/Pictures/$(date +%Y%m%d_%H%M%S).png'

    # Focus next/previous view
    riverctl map normal Super J focus-view next
    riverctl map normal Super K focus-view previous

    # Swap views
    riverctl map normal Super+Shift J swap next
    riverctl map normal Super+Shift K swap previous

    # Focus next/previous output
    riverctl map normal Super Period focus-output next
    riverctl map normal Super Comma focus-output previous

    # Send to next/previous output
    riverctl map normal Super+Shift Period send-to-output next
    riverctl map normal Super+Shift Comma send-to-output previous

    # Bump to top of layout stack
    riverctl map normal Super Return zoom

    # Adjust main ratio
    riverctl map normal Super H send-layout-cmd rivertile "main-ratio -0.05"
    riverctl map normal Super L send-layout-cmd rivertile "main-ratio +0.05"

    # Adjust main count
    riverctl map normal Super+Shift H send-layout-cmd rivertile "main-count +1"
    riverctl map normal Super+Shift L send-layout-cmd rivertile "main-count -1"

    # Move views
    riverctl map normal Super+Alt H move left 100
    riverctl map normal Super+Alt J move down 100
    riverctl map normal Super+Alt K move up 100
    riverctl map normal Super+Alt L move right 100

    # Snap views to edges
    riverctl map normal Super+Alt+Control H snap left
    riverctl map normal Super+Alt+Control J snap down
    riverctl map normal Super+Alt+Control K snap up
    riverctl map normal Super+Alt+Control L snap right

    # Resize views
    riverctl map normal Super+Alt+Shift H resize horizontal -100
    riverctl map normal Super+Alt+Shift J resize vertical 100
    riverctl map normal Super+Alt+Shift K resize vertical -100
    riverctl map normal Super+Alt+Shift L resize horizontal 100

    # Mouse bindings
    riverctl map-pointer normal Super BTN_LEFT move-view
    riverctl map-pointer normal Super BTN_RIGHT resize-view
    riverctl map-pointer normal Super BTN_MIDDLE toggle-float

    # Tags 1-9
    for i in $(seq 1 9)
    do
        tags=$((1 << ($i - 1)))
        riverctl map normal Super $i set-focused-tags $tags
        riverctl map normal Super+Shift $i set-view-tags $tags
        riverctl map normal Super+Control $i toggle-focused-tags $tags
        riverctl map normal Super+Shift+Control $i toggle-view-tags $tags
    done

    # Tag 0 = all tags
    all_tags=$(((1 << 32) - 1))
    riverctl map normal Super 0 set-focused-tags $all_tags
    riverctl map normal Super+Shift 0 set-view-tags $all_tags

    # Float / fullscreen
    riverctl map normal Super Space toggle-float
    riverctl map normal Super F toggle-fullscreen

    # Layout orientation
    riverctl map normal Super Up    send-layout-cmd rivertile "main-location top"
    riverctl map normal Super Right send-layout-cmd rivertile "main-location right"
    riverctl map normal Super Down  send-layout-cmd rivertile "main-location bottom"
    riverctl map normal Super Left  send-layout-cmd rivertile "main-location left"

    # Passthrough mode
    riverctl declare-mode passthrough
    riverctl map normal Super F11 enter-mode passthrough
    riverctl map passthrough Super F11 enter-mode normal

    # Media keys
    for mode in normal locked
    do
        riverctl map $mode None XF86Eject spawn 'eject -T'
        riverctl map $mode None XF86AudioRaiseVolume  spawn 'pamixer -i 5'
        riverctl map $mode None XF86AudioLowerVolume  spawn 'pamixer -d 5'
        riverctl map $mode None XF86AudioMute         spawn 'pamixer --toggle-mute'
        riverctl map $mode None XF86AudioMedia spawn 'playerctl play-pause'
        riverctl map $mode None XF86AudioPlay  spawn 'playerctl play-pause'
        riverctl map $mode None XF86AudioPrev  spawn 'playerctl previous'
        riverctl map $mode None XF86AudioNext  spawn 'playerctl next'
        riverctl map $mode None XF86MonBrightnessUp   spawn 'brightnessctl set +5%'
        riverctl map $mode None XF86MonBrightnessDown spawn 'brightnessctl set 5%-'
    done

    # Rules
    riverctl rule-add -app-id 'float*' -title 'foo' float
    riverctl rule-add -app-id "bar" csd

    # Layout
    riverctl default-layout rivertile
    rivertile -view-padding 0 -outer-padding 0 -main-ratio 0.5 &
  '';
};

}
