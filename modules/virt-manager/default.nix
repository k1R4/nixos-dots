{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.virt-manager;
in {
  options.modules.virt-manager = {enable = mkEnableOption "virt-manager";};

  config = mkIf cfg.enable {
    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = ["k1r4"];
    virtualisation.libvirtd.enable = true;

    home-manager.users.k1r4 = {
      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = ["qemu:///system"];
          uris = ["qemu:///system"];
        };
      };
    };
  };
}
