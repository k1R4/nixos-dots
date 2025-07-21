{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.ignis;
in {
  options.modules.ignis = {enable = mkEnableOption "ignis";};

  config = mkIf cfg.enable {
    modules.python.pythonPackages = mkAfter [
      (inputs.ignis.packages.${pkgs.stdenv.hostPlatform.system}.ignis.override {
        extraPackages = [
          # TO BE ADDED
        ];
      })
    ];

    home-manager.users.k1r4 = {
      config,
      pkgs,
      ...
    }: {
      xdg.configFile.ignis.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/ignis";
    };
  };
}
