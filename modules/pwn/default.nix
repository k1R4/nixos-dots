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
    modules.python.pythonPackages = mkAfter [
      "pwntools"
      "nclib"
      "binsync"
      "z3-solver"
      "dn3"
    ];
    home-manager.users.k1r4 = {
      home.packages = with pkgs; [
        inputs.pwndbg.packages.${system}.default
        gef
        ghidra
        binaryninja-free
        # musl.dev
        gcc
        glibc.dev
        libgcc
        # pkgsi686Linux.libgcc
      ];

      programs.fish.shellInit = ''
        set -gx TERM xterm
        set -gx FFSEND_HOST http://send.shell.phish
      '';
    };

    virtualisation.docker.extraOptions = ''
      --insecure-registry docker.shell.phish
    '';

    program.nix-ld.packages = with pkgs; [
      libgcc
      libGL
      glibc
    ];
  };
}
