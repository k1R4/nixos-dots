{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.gammastep;
in {
  options.modules.gammastep = {enable = mkEnableOption "gammastep";};

  config = mkIf cfg.enable {
    services.geoclue2 = {
      enable = true;
      enableDemoAgent = true;
    };

    home-manager.users.k1r4 = {
      services.gammastep = {
        enable = true;
        provider = "geoclue2";
      };
    };
  };
}
