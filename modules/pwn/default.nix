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
    modules.python.pythonPackages = mkAfter ["pwntools" "binsync" "z3-solver"];
    home-manager.users.k1r4 = {
      home.packages = with pkgs; [
        inputs.pwndbg.packages.${system}.default
        gef
        ghidra
        binaryninja-free
        gcc
        glibc
        pkgsi686Linux.libgcc
      ];
    };
  };
}
