{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  # flakes support
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Optimise store
  nix.optimise.automatic = true;

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # nix-ld
  programs.nix-ld.enable = true;

  # Clear /tmp
  boot.tmp.cleanOnBoot = true;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  # Networking
  networking.useDHCP = lib.mkDefault true;
  networking.enableIPv6 = true;
  networking.networkmanager.enable = true;

  # Timezone and locale
  # time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";
  services.automatic-timezoned.enable = true;

  # Configure console keymap
  console.keyMap = "dvorak";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "us";
  };

  # SDDM
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # User account
  programs.fish.enable = true;
  users.users.k1r4 = {
    isNormalUser = true;
    description = "k1r4";
    extraGroups = ["networkmanager" "wheel" "docker"];
    shell = pkgs.fish;
  };

  # Docker
  virtualisation.docker.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    wget
    neovim
    git
    htop
    zip
    unzip
    unrar
    p7zip
    networkmanagerapplet
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
