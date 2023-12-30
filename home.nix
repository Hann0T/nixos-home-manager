{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "hann0t";
  home.homeDirectory = "/home/hann0t";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # archives
    pkgs.zip
    pkgs.unzip

    # utils
    pkgs.ripgrep
    pkgs.fzf
    pkgs.eza

    # music
    pkgs.lsp-plugins
    pkgs.guitarix
    pkgs.x42-avldrums
    pkgs.drumgizmo
    pkgs.ardour

    # dev
    pkgs.php82Packages.composer
    pkgs.nodejs
    pkgs.go

    (pkgs.nerdfonts.override { fonts = [ "Mononoki" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/hann0t/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
        set fish_greeting # Disable greeting
	alias ls="eza -al --color=always --group-directories-first"
	alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'
	alias pa ="php artisan"
	alias sa ="sail artisan"

	fish_add_path ~/.npm-global
     '';
  };

  programs.git = {
    enable = true;
    userName = "hann0t";
    userEmail = "hansolivas1@gmail.com";
  };

  programs.starship.enable = true;

  programs.alacritty = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.tmux = {
      enable = true;
      clock24 = true;
      extraConfig = ''
          unbind C-b
	  set -g prefix `
	  bind ` send-prefix
          set -g base-index 1

          setw -g mode-keys vi

          set-option -g default-terminal screen-256color

	  bind-key k select-pane -U
	  bind-key j select-pane -D
	  bind-key h select-pane -L
	  bind-key l select-pane -R

	  set -g status-style 'bg=default fg=#bbc2e0'

	  set-window-option -g mode-keys vi
	  set-window-option -g window-status-current-style 'bg=default fg=blue'
      '';
  };
}
