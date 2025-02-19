{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.gaming;
in {
  options.modules.gaming = {enable = mkEnableOption "gaming";};

  config = mkIf cfg.enable {
    programs.gamescope.enable = true;
    programs.gamemode.enable = true;

    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    home-manager.users.k1r4 = {
      home.packages = with pkgs; [
        bottles
        heroic
      ];
    };
  };
}
