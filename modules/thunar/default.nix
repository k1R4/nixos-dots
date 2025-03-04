{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.thunar;
in {
  options.modules.thunar = {enable = mkEnableOption "thunar";};

  config = mkIf cfg.enable {
    programs.xfconf.enable = true;

    services.gvfs.enable = true;
    services.tumbler.enable = true;

    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

    home-manager.users.k1r4 = {
      xdg.mimeApps.defaultApplications = {
        "inode/directory" = "thunar.desktop";
      };
    };
  };
}
