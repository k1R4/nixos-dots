{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.pcmanfm;
in {
  options.modules.pcmanfm = {enable = mkEnableOption "pcmanfm";};

  config = mkIf cfg.enable {
    services.gvfs.enable = true;

    home-manager.users.k1r4 = {
      home.packages = with pkgs; [
        pcmanfm
        lxmenu-data
        shared-mime-info
      ];
    };
  };
}
