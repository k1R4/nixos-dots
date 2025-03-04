{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [../../modules/default.nix];

  config.modules = {
    # GUI
    ags.enable = true;
    dunst.enable = true;
    fuzzel.enable = true;
    kitty.enable = true;
    niri.enable = true;

    # Apps
    chromium.enable = true;
    gaming.enable = true;
    neovim.enable = true;
    spicetify.enable = true;
    thunar.enable = true;
    virt-manager.enable = true;
    vscodium.enable = true;

    # Misc
    git.enable = true;
    rnnoise.enable = true;
    theme.enable = true;
  };

  config.home-manager.users.k1r4 = {
    home.packages = with pkgs; [
      killall
      dnsutils
      neofetch
      pavucontrol
      (vesktop.override {electron = pkgs.electron_32;})
      qbittorrent
      prismlauncher
    ];
  };
}
