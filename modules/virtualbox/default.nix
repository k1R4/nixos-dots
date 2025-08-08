{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.virtualbox;
in {
  options.modules.virtualbox = {enable = mkEnableOption "virtualbox";};

  config = mkIf cfg.enable {
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = ["k1r4"];
  };
}
