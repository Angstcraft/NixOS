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
      ./vm.nix
      ./nvim.nix 
     
    ];
  # Bootloader configuration
 boot.loader.systemd-boot.enable = false;
boot.loader.grub.enable = true;
boot.loader.grub.device = "nodev";
boot.loader.grub.useOSProber = true;
boot.loader.grub.efiSupport = true;
boot.loader.efi.canTouchEfiVariables = true;
boot.loader.efi.efiSysMountPoint = "/boot";

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
    videoDrivers = [ "modesetting" ];  # Ensure only 'modesetting' driver is specified
    xkb.layout = "de";

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Define user account with password
  users.users.think = {
    isNormalUser = true;
    description = "Angstcraft";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    password = "gamma"; # Consider using hashed passwords for security
    packages = with pkgs; [
      thunderbird
      xarchiver
    ];
  };
  

  # Enable Java with OpenJFX
  programs.java = {
    enable = true;
    package = pkgs.openjfx23; # Adjust JDK as needed
  };

  # Enable Firefox (using Librewolf)
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System-wide environment packages
  environment.systemPackages = with pkgs; [
    # Development tools
    home-manager
    kitty
    git
    qtcreator
    vscodium

    # Java and Development Tools
    eclipses.eclipse-java
    openjdk
    openjfx
    scenic-view
    scenebuilder
    jetbrains.idea-community
    android-studio
    
    # C/C++ and Arduino Development
    arduino-ide            # Arduino IDE
    gcc                # GCC for C/C++ compilation
    gdb                    # GNU Debugger for C/C++
    cmake                  # Build system for C/C++
    
    # Rust
    rustc

    # Go
    go

    # Engineering applications
    orca-slicer
    kicad-small

    # Python Packages
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

    gnomeExtensions.unite
    gnomeExtensions.dash-to-panel
#    gnomeExtensions.open-Bar
#    gnomeExtensions.popShell
#    gnomeExtensions.roundedWindowCornersReborn

    #Music
    lmms
    ardour

    #Art
    blender
    krita

    # Office applications
    nemo
    obsidian
    wpsoffice
    signal-cli
    discord
    spotify
    bottles # For running Windows executables
    bitwarden-desktop
    rustdesk-flutter

    # Ham Radio
    libGL
    gnuradioMinimal
  ];

  # Optional configurations
  # Enable SSH
  # services.openssh.enable = true;

  # Firewall configuration
  # networking.firewall.enable = false;

  # System version
  system.stateVersion = "24.11"; # Adjust the version according to your NixOS release
}
