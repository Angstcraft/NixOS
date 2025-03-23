{ config, pkgs, ... }:

{
  # Enable experimental features for Nix
  nix.extraOptions = ''
    experimental-features = nix-command
  '';

  # Import hardware configuration
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Configure networking
  networking.hostName = "T480";
  networking.networkmanager.enable = true;

  # Set time zone
  time.timeZone = "Europe/Berlin";

  # Localization settings
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

  # Enable X11 with GNOME as the desktop environment
  services.xserver = {
    enable = true;
    xkb.layout = "de";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true; 
  };

  # Define user account with password
  users.users.think = {
    isNormalUser = true;
    description = "Angstcraft";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    password = "gamma"; # Set user password
    packages = with pkgs; [
      thunderbird
      xarchiver
    ];
  };

  # Enable Java with OpenJFX
  programs.java = {
    enable = true;
    package = pkgs.openjfx23; # You can change this to the desired JDK if necessary
  };

  # Enable Firefox
  programs.firefox = {
  enable = true;
  package = pkgs.librewolf;
};

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    
    # Development tools
    home-manager
    kitty
    git
    neovim
    vscodium

    #java
    eclipses.eclipse-java
    openjdk
    openjfx
    scenic-view
    scenebuilder
    jetbrains.idea-community
    android-studio 

    #Rust
    rustc

    #Go
    go

    #C/C++ 

    arduino-ide
    gcc                # C/C++ compiler
    cmakerc

    #Engineering
    orca-slicer
    kicad-small

    #Python Packages
    python3
    python3Packages.numpy
    python3Packages.matplotlib
    python3Packages.plotly
    python3Packages.scipy
    python3Packages.pandas
    python3Packages.jupyterlab
    

    # GNOME extensions
    gnomeExtensions.space-bar
    gnomeExtensions.switcher
    gnomeExtensions.tactile
    gnomeExtensions.just-perfection
    gnomeExtensions.tophat
    gnomeExtensions.transparent-top-bar
    gnomeExtensions.user-themes
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.forge
    gnomeExtensions.custom-window-controls
    gnomeExtensions.logo-menu

    # Office applications
    nemo   
    obsidian
    wpsoffice
    discord
    spotify
    davinci-resolve
    bottles #For vine {Windows exe}

    #Ham Radio
    libGL
    gnuradioMinimal
    
    
     ];

  # Optional configurations
  # Enable SSH
  # services.openssh.enable = true;

  # Firewall configuration
  # networking.firewall.enable = false;

  # System version
  system.stateVersion = "24.11";
}
