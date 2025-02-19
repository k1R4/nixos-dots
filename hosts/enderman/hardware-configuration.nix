{
  config,
  pkgs,
  lib,
  inputs,
  modulesPath,
  ...
}: {
  # Auto-generated
  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "usb_storage" "usbhid" "sd_mod" "sdhci_pci"];
  boot.initrd.kernelModules = ["amdgpu"];
  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.enableRedistributableFirmware = lib.mkDefault true;

  # Luks
  boot.initrd.luks.devices."luks-0ac0206b-6d81-483a-af9b-ec34e1206db3".device = "/dev/disk/by-uuid/0ac0206b-6d81-483a-af9b-ec34e1206db3";
  boot.initrd.luks.devices."luks-a9134043-8f2b-4e9e-bb13-0ef82454d2e9".device = "/dev/disk/by-uuid/a9134043-8f2b-4e9e-bb13-0ef82454d2e9";

  # File system
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/e7e30582-c08d-49c0-94cf-b58a10b8e8bb";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/109F-4011";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/a26fe5e1-c959-45aa-99de-66a7ee6fc51c";}
  ];

  # Graphics
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    nvidiaSettings = true;
    prime = {
      amdgpuBusId = "PCI:6:0:0";
      nvidiaBusId = "PCI:1:0:0";
      offload.enable = true;
      offload.enableOffloadCmd = true;
    };
  };

  hardware.amdgpu.amdvlk = {
    enable = true;
    support32Bit.enable = true;
  };

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  services.xserver.videoDrivers = ["modesetting" "nvidia" "amdgpu"];

  # CPU
  boot.kernelParams = ["amd_pstate=active"];
  boot.blacklistedKernelModules = ["k10temp"];
  boot.extraModulePackages = [config.boot.kernelPackages.zenpower];
  boot.kernelModules = ["kvm-amd" "zenpower"];
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Asusd
  services = {
    asusd = {
      enable = true;
      enableUserService = true;
    };
  };

  # SSD
  services.fstrim.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Audio
  boot.extraModprobeConfig = ''
    options snd-hda-intel model=auto
  '';
}
