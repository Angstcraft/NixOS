{ config, pkgs, ... }:

{
  nix.extraOptions = ''experimental-features = nix-command '';

  imports =
    [
      ./hardware-configuration.nix
      modules/gnome.nix
      modules/vm.nix
      modules/nvim.nix 
    ];
   # Bootloader configuration
   boot.loader =
   {
       
       systemd-boot.enable = false;
       grub.enable = true;
       grub.device = "nodev";
       grub.useOSProber = true;
       grub.efiSupport = true;
       efi.canTouchEfiVariables = true;
       efi.efiSysMountPoint = "/boot";
    };

   # Configure networking
   networking.hostName = "T480";
   networking.networkmanager.enable = true;

   # Set your time zone.
   time.timeZone = "Europe/Berlin";
   i18n.defaultLocale = "en_GB.UTF-8";

   i18n.extraLocaleSettings =
   {
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

   # Enable the GNOME Desktop Environment.
   /**
   services.xserver = 
   {
     enable = true;
     videoDrivers = [ "modesetting" ];  # Ensure only 'modesetting' driver is specified
     xkb.layout = "de";

     displayManager.gdm.enable = true;
     desktopManager.gnome.enable = true;
   };
   */
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = 
  {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.qubit = 
  {
    isNormalUser = true;
    description = "qubit";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    packages = with pkgs; 
    [
     thunderbird
    ];
  };

 
  # Enable Java with OpenJFX
  programs.java = 
  {
    enable = true;
    package = pkgs.openjfx23; # Adjust JDK as needed
  };

  # Enable Firefox (using Librewolf)
  programs.firefox = 
  {
    enable = true;
    package = pkgs.librewolf;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs;
  [
  # Development tools
    alacritty
    git
    qtcreator
    vscodium
    texliveFull
    texstudio
    nodejs  

    # Java and Development Tools
    eclipses.eclipse-java
    scenic-view
    scenebuilder

    # C/C++ and Arduino Development
    arduino-ide           
    stm32cubemx # sorry NixOS is shit for the stm32 but you can use Eclipse or vs codium as an alternativ 
    gcc                # GCC for C/C++ compilation
    gdb                    # GNU Debugger for C/C++
    cmake                  # Build system for C/C++
    
    # Engineering applications
    orca-slicer
    kicad-small
    gqrx
    gnuradio3_8

    # Python Packages
    python3
    python312Packages.jupyterlab

    #Music & Art
    ardour
    blender
    krita

    # Office applications
    obsidian
    libreoffice-qt
    hunspell
    hunspellDicts.th_TH
    discord
    spotify
    bitwarden-desktop
    rustdesk-flutter
   ];
   # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  
  system.stateVersion = "24.11"; # Did you read the comment?

}
