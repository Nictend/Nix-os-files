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
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };
}
