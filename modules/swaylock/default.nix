{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.swaylock;
in {
  options.modules.swaylock = {enable = mkEnableOption "swaylock";};

  config = mkIf cfg.enable {
    home-manager.users.k1r4 = {
      config,
      pkgs,
      ...
    }: {
      home.packages = with pkgs; [
        swaylock
      ];

      xdg.configFile.swaylock.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/swaylock";
    };
  };
}
