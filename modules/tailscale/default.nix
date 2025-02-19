{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.tailscale;
in {
  options.modules.tailscale = {enable = mkEnableOption "tailscale";};

  config = mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      openFirewall = true;
      useRoutingFeatures = "client";
    };
  };
}
