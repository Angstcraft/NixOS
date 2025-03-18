{ config, pkgs, ... }:

{

  nix.extraOptions = ''
    experimental-features = nix-command
    '';
  imports =
    [

    ./hardware-configuration.nix
   
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;




  # Configure networking
  networking.hostName = "T480";
  networking.networkmanager.enable = true;

  # Set time zone
  time.timeZone = "Europe/Berlin";

  # Set localization
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };



  # Enable X11
  services.xserver = {
  enable = true;
  displayManager.gdm.enable = true;
  desktopManager.gnome.enable = true;
  };


# Define a user account
  users.users.think = {
    isNormalUser = true;
    description = "Angstcraft";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      thunderbird
      xarchiver
	    ];
  };

  # Enable Java
  programs.java = {
    enable = true;
    package = pkgs.openjfx23;
   # package = pkgs.jdk23;
  };

  # Install Firefox
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install additional packages
  environment.systemPackages = with pkgs; [
    home-manager
    neofetch
    libGL
    scenic-view
    scenebuilder
    python3
    git
    neovim
    jetbrains.idea-community
    eclipses.eclipse-java
    vscodium
    libkvmi
    discord
    spotify
    orca-slicer
    arduino-ide
    gnuradioMinimal
    gqrx
    virtualbox

    wezterm
    obsidian
    wpsoffice
    kicad-small


    python312Packages.numpy
    gnome.gnome-keyring
    ];
 

  # Enable SSH
  # services.openssh.enable = true;

  # Firewall configuration
  # networking.firewall.enable = false;

  # System version
  system.stateVersion = "24.11";
}

