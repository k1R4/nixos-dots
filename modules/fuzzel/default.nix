{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.fuzzel;
in {
  options.modules.fuzzel = {enable = mkEnableOption "fuzzel";};

  config = mkIf cfg.enable {
    home-manager.users.k1r4 = {
      config,
      pkgs,
      ...
    }: {
      home.packages = with pkgs; [
        fuzzel
      ];

      xdg.configFile.fuzzel.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/fuzzel";
    };
  };
}
