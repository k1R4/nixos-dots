{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.neovim;
in {
  options.modules.neovim = {enable = mkEnableOption "neovim";};

  config = mkIf cfg.enable {
    home-manager.users.k1r4 = {
      config,
      pkgs,
      ...
    }: {
      programs.neovim = {
        enable = true;
        package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
        extraPackages = with pkgs; [
          gnumake
          cmake
          python3
          gcc
          ripgrep
          sshfs
          basedpyright
          ccls
          clang-tools
          gopls
          rust-analyzer
          nixd
          alejandra
          lua-language-server
          typescript-language-server
          kdePackages.qtdeclarative
        ];
      };
      home.sessionVariables."EDITOR" = "nvim";

      xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/nvim";
    };
  };
}
