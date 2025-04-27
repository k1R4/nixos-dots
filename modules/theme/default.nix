{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.theme;
in {
  options.modules.theme = {enable = mkEnableOption "theme";};

  config = mkIf cfg.enable {
    fonts = {
      fontconfig = {
        enable = true;
        defaultFonts = {
          serif = ["Source Serif Pro"];
          sansSerif = ["Open Sans"];
          monospace = ["Hermit" "JetBrains Mono"];
          emoji = ["Noto Color Emoji"];
        };
      };
    };

    environment.sessionVariables = {
      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = 32;
    };

    home-manager.users.k1r4 = {
      home.packages = with pkgs; [
        nwg-look
        jetbrains-mono
        open-sans
        source-serif-pro
        nerd-fonts.blex-mono
        fira-code
        noto-fonts-emoji
      ];

      home.pointerCursor = {
        x11.enable = true;
        gtk.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 32;
      };

      gtk = {
        enable = true;
        cursorTheme.package = pkgs.bibata-cursors;
        cursorTheme.name = "Bibata-Modern-Classic";
        cursorTheme.size = 24;

        theme.package = pkgs.orchis-theme;
        theme.name = "Orchis-Dark";

        iconTheme.package = pkgs.qogir-icon-theme;
        iconTheme.name = "Qogir";
      };
    };
  };
}
