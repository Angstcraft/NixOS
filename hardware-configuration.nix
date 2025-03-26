# This file describes the hardware configuration for NixOS
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Kernel modules to load for system boot
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];

  # Filesystem configuration
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/e56c0b9f-6838-484e-9b04-28d337903efe";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/1E30-A507";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  # Swap configuration
  swapDevices = [{ device = "/swapfile"; }]; # Make sure to create a swap file as indicated prior

  # Networking configuration
  networking.interfaces.enp0s31f6.useDHCP = true; # Replace with your Ethernet interface name
  networking.interfaces.wlp61s0.useDHCP = true; # Replace with your Wi-Fi interface name

  # Package configuration
  nixpkgs.hostPlatform = "x86_64-linux";

  # Hardware-specific configurations
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = true; # Apply microcode updates for Intel CPUs

  # Power management
  powerManagement.cpuFreqGovernor = "conservative"; # Choose either "conservative" or "ondemand"

  # X Server configuration, if using a GUI
  services.xserver.enable = true; # Enable X Server
  services.xserver.videoDrivers = [ "modesetting" ]; # Use modesetting driver instead of Intel

  # Additional configurations can be added below
}
