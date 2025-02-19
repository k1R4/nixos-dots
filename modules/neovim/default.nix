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
      programs.neovim.enable = true;
      home.sessionVariables."EDITOR" = "nvim";

      home.packages = with pkgs; [
        python3
      ];

      xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/nvim";
    };
  };
}
