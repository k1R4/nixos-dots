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
    boot.binfmt.emulatedSystems = ["i686-linux"];

    modules.python.pythonPackages = mkAfter [
      "pwntools"
      "nclib"
      # "binsync"
      "angr"
      "z3-solver"
    ];

    home-manager.users.k1r4 = {
      home.packages = with pkgs; [
        inputs.pwndbg.packages.${system}.default
        gef
        ghidra
        binaryninja-free
        gcc_multi
        glibc_multi.dev
        libgcc
        z3
        ropr
        one_gadget
        vmlinux-to-elf
        gdb
      ];

      programs.fish.shellInit = ''
        set -gx TERM xterm
      '';
    };

    programs.nix-ld.libraries = with pkgs; [
      libgcc
      glibc_multi
      cairo
      dbus
      fontconfig
      freetype
      glib
      gtk3
      libdrm
      libGL
      libkrb5
      libsecret
      libsForQt5.qtbase
      libunwind
      libxkbcommon
      openssl
      stdenv.cc.cc
      xorg.libICE
      xorg.libSM
      xorg.libX11
      xorg.libXau
      xorg.libxcb
      xorg.libXext
      xorg.libXi
      xorg.libXrender
      xorg.xcbutilimage
      xorg.xcbutilkeysyms
      xorg.xcbutilrenderutil
      xorg.xcbutilwm
      zlib
    ];
  };
}
