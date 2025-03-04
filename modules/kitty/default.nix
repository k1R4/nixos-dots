{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.kitty;
in {
  options.modules.kitty = {enable = mkEnableOption "kitty";};

  config = mkIf cfg.enable {
    home-manager.users.k1r4 = {
      config,
      pkgs,
      ...
    }: {
      home.packages = [pkgs.kitty];
      xdg.configFile.kitty.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/kitty";
    };
  };
}
