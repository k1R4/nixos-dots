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
    hyprlock.enable = true;
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
    gammastep.enable = true;
    git.enable = true;
    kanshi.enable = true;
    pwn.enable = true;
    python.enable = true;
    rnnoise.enable = true;
    seafile.enable = true;
    theme.enable = true;
    tailscale.enable = true;
  };

  config.home-manager.users.k1r4 = {
    home.packages = with pkgs; [
      killall
      dnsutils
      neofetch
      nvtopPackages.full
      pavucontrol
      vesktop
      qbittorrent
    ];
  };
}
