{ config, pkgs, ... }:


{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ 
      pkgs.vim
      pkgs.coreutils
    ];

  imports = [ <home-manager/nix-darwin> ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;
  programs.fish.enable = true;

  environment = {
    shells = [ pkgs.fish ];
    variables.LANG = "en_US.UTF-8";
    variables.EDITOR = "vim";
    variables.VISUAL = "vim";
  };

  users.users.kamiishiyasuyuki = {
    name = "kamiishiyasuyuki";
    home = "/Users/kamiishiyasuyuki";
    shell = pkgs.fish;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
  # home-manager
  home-manager.users.kamiishiyasuyuki = { pkgs, ... }: {
    home.stateVersion = "22.11";
    home.packages = with pkgs; [
      atool
      httpie
      ripgrep
      fzf
      starship
      nerdfonts
      stow
      rustup
      rust-analyzer
      jq
      gitui
      tree
      libtool
      graphviz
      imagemagick
      ffmpeg
    ];

    programs.tmux = {
      enable = true;
    };

    programs.emacs = {
      enable = true;
    };

    programs.neovim = {
      enable = true;
    };

    programs.git = {
      enable = true;
      userName = "Yasuyuki Ageishi";
      userEmail = "y4suyuki@protonmail.com";
      aliases = {
        co = "checkout";
        pl = "pull";
      };
    };

    programs.gh = {
      enable = true;
    };

    programs.alacritty = {
      enable = true;
      settings = {
        window.opacity = 0.7;
        shell.program = builtins.getEnv "HOME" + "/.nix-profile/bin/fish";
        font.size = 14;
        font.normal = {
          family = "mononoki Nerd Font";
        };
      };
    };

    programs.fish = {
      enable = true;
      shellAliases = {
        v = "nvim";
        vi = "nvim";
      };
      shellAbbrs = {
        l = "less";
        gs = "git status";
        gd = "git diff";
	gg = "git log --oneline --graph --all --decorate";
	ga = "git add";
      };
      interactiveShellInit = ''
      fish_add_path $HOME/.cargo/bin
      fish_add_path $HOME/google-cloud-sdk/bin
      fish_add_path $HOME/.local/bin
      fish_vi_key_bindings
      . "$HOME/.asdf/asdf.fish"
      . "$HOME/.asdf/completions/asdf.fish"
      starship init fish | source 
      '';
    };

    fonts.fontconfig.enable = true;
  };
}
