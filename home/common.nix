{ pkgs, ... }:

{
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    eza        # nicer ls
    bat        # nicer cat
    fzf        # fuzzy finder, wired into fish below
  ];

  programs.fish = {
    enable = true;

    shellAliases = {
      ll = "eza -l --icons";
      la = "eza -la --icons";
      cat = "bat";
      gs = "git status";
      ga = "git add -A";
      gc = "git commit -m";
      gp = "git push";
      gl = "git pull";
    };

    functions = {
      rebuild = ''
        sudo nixos-rebuild switch --flake /etc/nixos#(hostname)
      '';
      rebuild-test = ''
        nixos-rebuild build --flake /etc/nixos#(hostname)
      '';
    };

    interactiveShellInit = ''
      set fish_greeting   # disable the default fish welcome banner
    '';
  };

  programs.starship = {
  enable = true;
  enableFishIntegration = true;
  settings = {
    format = "$username$directory$character";
    add_newline = true;

    username = {
      style_user = "bg:blue fg:white bold";
      style_root = "bg:red fg:white bold";
      format = "[ $user ]($style)";
      show_always = true;
    };

    directory = {
      style = "bg:blue fg:white";
      format = "[ $path ]($style)";
      truncation_length = 3;
      truncate_to_repo = true;
    };

    character = {
      success_symbol = "[](bold blue) ";
      error_symbol = "[](bold red) ";
    };

    time = {
      disabled = false;
      style = "bg:blue fg:white bold";
      format = "[ $time ]($style)";
      time_format = "%H:%M";
    };
  };
};

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };
}
