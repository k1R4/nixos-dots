{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.dunst;
in {
  options.modules.dunst = {enable = mkEnableOption "dunst";};

  config = mkIf cfg.enable {
    home-manager.users.k1r4 = {
      config,
      pkgs,
      ...
    }: {
      home.packages = [pkgs.dunst];
      home.file.".config/dunst/dunstrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/dunst/dunstrc";
    };
  };
}
