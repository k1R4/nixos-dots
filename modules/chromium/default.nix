{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.chromium;
in {
  options.modules.chromium = {enable = mkEnableOption "chromium";};

  config = mkIf cfg.enable {
    home-manager.users.k1r4 = {
      programs.chromium = {
        enable = true;
        package = pkgs.chromium.override {enableWideVine = true;};
        extensions = [
          "nngceckbapebfimnlniiiahkandclblb"
          "cjpalhdlnbpafiamejdnhcphjbkeiagm"
          "mnjggcdmjocbbbhaepdhchncahnbgone"
          "eimadpbcbfnmbkopoojfekhnkhdbieeh"
        ];
      };
    };
  };
}
