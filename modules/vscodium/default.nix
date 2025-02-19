{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.vscodium;
in {
  options.modules.vscodium = {enable = mkEnableOption "vscodium";};

  config = mkIf cfg.enable {
    home-manager.users.k1r4 = {
      home.packages = with pkgs; [
        alejandra
      ];

      programs.vscode = {
        enable = true;
        package = pkgs.vscodium;
        extensions = with pkgs.vscode-extensions; [
          eamodio.gitlens
          llvm-vs-code-extensions.vscode-clangd
          ms-python.python
          rust-lang.rust-analyzer
          kamadorueda.alejandra
          bbenoist.nix
          arrterian.nix-env-selector
          sumneko.lua
        ];
        userSettings = {
          "keyboard.dispatch" = "keyCode";
          "workbench.colorTheme" = "Monokai";
          "editor.fontSize" = 16;
          "editor.fontFamily" = "'JetBrains Mono', 'monospace', monospace";
        };
      };
    };
  };
}
