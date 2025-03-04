{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.niri;
in {
  options.modules.niri = {enable = mkEnableOption "niri";};

  config = mkIf cfg.enable {
    programs.niri.enable = true;
    services.displayManager.sddm.settings = {
      Autologin = {
        Session = "niri";
        User = "k1r4";
      };
    };

    home-manager.users.k1r4 = {
      config,
      pkgs,
      ...
    }: {
      xdg.configFile.niri.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/niri";

      home.packages = with pkgs; [
        swww
        xwayland-satellite
      ];

      services.gnome-keyring.enable = true;
      xdg.mimeApps.enable = true;
      xdg.portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
          pkgs.xdg-desktop-portal-gnome
        ];
        config.common = {
          default = [
            "gnome"
            "gtk"
          ];
          "org.freedesktop.impl.portal.Access" = "gtk";
          "org.freedesktop.impl.portal.Notification" = "gtk";
          "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
        };
      };
    };
  };
}
