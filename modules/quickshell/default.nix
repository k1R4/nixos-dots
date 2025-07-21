{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.quickshell;
in {
  options.modules.quickshell = {enable = mkEnableOption "quickshell";};

  config = mkIf cfg.enable {
    home-manager.users.k1r4 = {
      config,
      pkgs,
      ...
    }: {
      home.packages = with pkgs; [
        quickshell
      ];

      xdg.configFile.quickshell.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/quickshell";
    };
  };
}
