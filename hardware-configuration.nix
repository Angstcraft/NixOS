{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Kernel modules to load for system boot
  #boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "i915" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];
  boot.kernelPackages = pkgs.linuxPackages_zen;
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
  swapDevices = [{ device = "/swapfile"; }]; # Ensure /swapfile exists

  # Networking configuration
  networking.interfaces.enp0s31f6.useDHCP = true; # Ethernet 
  networking.interfaces.wlp61s0.useDHCP = true; # Wi-Fi 

  # Package configuration
  nixpkgs.hostPlatform = "x86_64-linux";

  # Hardware-specific configurations
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = true; # Apply microcode updates for Intel CPUs

  # Power management
  powerManagement.enable = true; # Enable power management
  powerManagement.cpuFreqGovernor = "powersave"; # Use powersave governor for battery mode

  # X Server configuration, for GNOME
  services.xserver.enable = true;# Enable X Server

   services.xserver.videoDrivers = [
    "modesetting"
    "i915"
  ];
  services.thermald.enable = true;

#  services.xserver.videoDrivers = [ "modesetting" ];  # Use Intel driver for better performance
  services.xserver.layout = "de";  # Set keyboard layout to German
hardware.opengl = {  
#      driSupport = true;
#      driSupport32Bit = true;
      enable = true;
      extraPackages = with pkgs; [
      intel-media-driver
#      (if (lib.versionOlder (lib.versions.majorMinor lib.version) "23.11") then vaapiIntel else >
#      vaapiVdpau
      libvdpau-va-gl
    ];
  };
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
  }; 
  # GNOME configuration
 # services.gnome.enable = true; # Enable GNOME 3
  #services.gnome.shell.enableExtensions = true; # Enable GNOME Shell extensions
  #services.gnome.gdm.enable = true; # Use GDM as the display manager

  # Additional GNOME optimizations
  #services.gnome.gdm.loginShell = true; # Use login shell for GNOME sessions
  #services.gnome.extensions = with pkgs.gnome3.extensions; [
    # List any useful extensions here
   # dash-to-panel
    # media-player-indicator
    # ... other extensions
  #];
  

  # Additional configurations can be added below
}
