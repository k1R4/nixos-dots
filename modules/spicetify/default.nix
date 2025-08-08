{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.spicetify;
in {
  options.modules.spicetify = {enable = mkEnableOption "spicetify";};

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [57621];
    networking.firewall.allowedUDPPorts = [5353];

    home-manager.users.k1r4 = {
      imports = [inputs.spicetify-nix.homeManagerModules.default];

      programs.spicetify = let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in {
        enable = true;

        enabledExtensions = with spicePkgs.extensions; [
          adblock
        ];
        enabledCustomApps = with spicePkgs.apps; [
          newReleases
          ncsVisualizer
        ];
        enabledSnippets = with spicePkgs.snippets; [
          pointer
        ];

        theme = spicePkgs.themes.bloom;
        colorScheme = "dark";
      };
    };
  };
}
