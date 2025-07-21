{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.hyprlock;
in {
  options.modules.hyprlock = {enable = mkEnableOption "hyprlock";};

  config = mkIf cfg.enable {
    home-manager.users.k1r4 = {
      config,
      pkgs,
      ...
    }: {
      programs.hyprlock.enable = true;
      services.hypridle.enable = true;
      xdg.configFile.hypr.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/hypr";
    };
  };
}
