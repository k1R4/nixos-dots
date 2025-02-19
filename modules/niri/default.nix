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
      home.file.".config/niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/niri/config.kdl";

      home.packages = with pkgs; [
        swww
        fuzzel
        xwayland-satellite
      ];

      home.sessionVariables."NIXOS_OZONE_WL" = 1; # Electron/Chromium
      home.sessionVariables."DISPLAY" = ":0"; # Xwayland satellite

      xdg.portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gnome
          pkgs.xdg-desktop-portal-gtk
        ];
        config.common.default = "gnome";
      };
    };
  };
}
