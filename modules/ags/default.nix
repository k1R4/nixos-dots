{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.ags;
in {
  options.modules.ags = {enable = mkEnableOption "ags";};

  config = mkIf cfg.enable {
    services.upower.enable = true;

    home-manager.users.k1r4 = {
      config,
      pkgs,
      ...
    }: {
      imports = [inputs.ags.homeManagerModules.default];

      home.packages = with pkgs; [
        orbitron
      ];

      programs.ags = {
        enable = true;
        extraPackages = with pkgs; [
          inputs.ags.packages.${pkgs.system}.battery
          inputs.ags.packages.${pkgs.system}.bluetooth
          inputs.ags.packages.${pkgs.system}.cava
          inputs.ags.packages.${pkgs.system}.mpris
          inputs.ags.packages.${pkgs.system}.network
          inputs.ags.packages.${pkgs.system}.tray
          inputs.ags.packages.${pkgs.system}.wireplumber
          fzf
        ];
      };
      xdg.configFile.ags.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/ags";
    };
  };
}
