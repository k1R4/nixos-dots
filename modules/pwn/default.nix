{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.pwn;
in {
  options.modules.pwn = {enable = mkEnableOption "pwn";};
  config = mkIf cfg.enable {
    home-manager.users.k1r4 = {
      home.packages = with pkgs; [
        (python311.withPackages (ps:
          with ps; [
            pwntools
            binsync
          ]))
        inputs.pwndbg.packages.${system}.default
        gef
        ghidra
        binaryninja-free
      ];
    };
  };
}
