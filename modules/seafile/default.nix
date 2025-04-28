{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.seafile;
in {
  options.modules.seafile = {enable = mkEnableOption "seafile";};

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.seafile-shared];
    systemd.services.seafile-daemon = {
      wantedBy = ["multi-user.target"];
      path = [pkgs.seafile-shared];
      script = ''
        seaf-cli start
      '';
      serviceConfig = {
        Type = "forking";
        User = "k1r4";
      };
    };
  };
}
