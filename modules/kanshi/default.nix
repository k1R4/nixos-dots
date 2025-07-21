{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.kanshi;
in {
  options.modules.kanshi = {enable = mkEnableOption "kanshi";};

  config = mkIf cfg.enable {
    home-manager.users.k1r4 = {
      config,
      pkgs,
      ...
    }: {
      services.kanshi.enable = true;

      xdg.configFile.kanshi.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/kanshi";
    };
  };
}
