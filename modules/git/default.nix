{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.git;
in {
  options.modules.git = {enable = mkEnableOption "git";};

  config = mkIf cfg.enable {
    home-manager.users.k1r4 = {
      programs.git = {
        enable = true;
        userName = "k1R4";
        userEmail = "srijiith@outlook.com";
      };
    };
  };
}
