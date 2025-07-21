{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  # Auto-generated
  boot.initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = ["xe"];
  boot.extraModulePackages = [];
  boot.kernelModules = ["kvm-intel" "hp-wmi"];
  hardware.enableRedistributableFirmware = lib.mkDefault true;

  # Luks
  boot.initrd.luks.devices."luks-11c8a583-e1d2-4edf-8eb5-a6c44fcc2ad3".device = "/dev/disk/by-uuid/11c8a583-e1d2-4edf-8eb5-a6c44fcc2ad3";

  # File system
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/C8F9-704E";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/d8741fa7-73d2-484b-87fa-d6d85688c7a9";
    fsType = "ext4";
  };

  fileSystems."/shared" = {
    device = "/dev/disk/by-uuid/2CB1-CB8B";
    fsType = "exfat";
    options = ["rw" "uid=1000" "gid=100" "umask=0022"];
  };

  swapDevices = [];

  # CPU
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # GPU
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      vpl-gpu-rt
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.intel-media-driver
    ];
  };

  hardware.nvidia = {
    open = true;
    nvidiaSettings = true;
    dynamicBoost.enable = true;
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      sync.enable = true;
    };
  };
  services.xserver.videoDrivers = ["xe" "nvidia"];

  # Boot specialisation
  specialisation = {
    on-the-go.configuration = {
      system.nixos.tags = ["on-the-go"];
      hardware.nvidia = {
        powerManagement.enable = lib.mkForce true;
        powerManagement.finegrained = lib.mkForce true;
        prime = {
          offload.enable = lib.mkForce true;
          offload.enableOffloadCmd = lib.mkForce true;
          sync.enable = lib.mkForce false;
        };
      };
    };
  };

  # Power Profiles
  services.power-profiles-daemon.enable = true;

  # SSD
  services.fstrim.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
}
