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
    ];
  # Bootloader configuration
   boot.loader.grub = {
    enable = true;        # Enable GRUB
    version = 2;         # Specify GRUB version
    devices = [ "/dev/sda" ];  # List your boot device(s), adjust as necessary
  };

  # Allow EFI variables to be modified
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
    neovim
    vscodium

    # Java and Development Tools
    eclipses.eclipse-java
    openjdk
    openjfx
    scenic-view
    scenebuilder
    jetbrains.idea-community
    android-studio

    # ----- Emacs and Java/C/C++/Arduino Development Configuration -----
    emacs
    maven                  # For building Java projects
    gradle                 # Gradle build tool for Java
    openjdk11              # Java Development Kit

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

    # Office applications
    nemo
    gimp
    obsidian
    wpsoffice
    discord
    spotify
    bottles # For running Windows executables


    # Ham Radio
    libGL
    gnuradioMinimal
  ];
  
  
  /*

  # Emacs Cn
  programs.emacs = {
    enable = true; # Activate Emacs
    extraPackages = ps: with ps; [
      use-package
      lsp-mode            # Language Server Protocol support
      eglot               # LSP client for Emacs
      company             # Autocompletion
      flycheck           # Syntax checking
      java-mode           # Mode for Java files
      java-snippets       # Snippets for Java programming
      dap-mode            # Debug Adapter Protocol support for various languages

      # C/C++ support packages
      cc-mode             # C and C++ Mode
      irony               # C/C++ code completion
      company-irony       # Company mode backend for Irony
      gdb                 # GDB for debugging
      cmake-mode          # CMake mode

      # Arduino support
      arduino-mode        # Arduino mode for Emacs

      # Theme (assuming you have cattpuccin-theme package)
      (with pkgs.cattpuccin-theme; cattpuccin)
    ];

    # File to initialize Emacs
    initFile = ''
      ;; Set MELPA as a package source
      (require 'package)
      (setq package-enable-at-startup nil)
      (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
      (package-initialize)

      ;; Load Cattpuccin theme
      (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
      (load-theme 'cattpuccin t)

      ;; Programming language setup
      (require 'lsp-mode)
      (setq lsp-enable-symbol-highlighting nil)

      ;; Enable LSP for Java
      (require 'eglot)
      (add-hook 'java-mode-hook 'eglot-ensure)

      ;; C/C++ Configuration
      (add-hook 'c-mode-hook 'eglot-ensure)
      (add-hook 'c++-mode-hook 'eglot-ensure)
      (require 'irony)

      ;; Additional Java customizations
      (setq lsp-java-java-path "/path/to/your/java")  ;; Adjust to your Java path if needed
      (setq java-indent 4)
      (setq-default c-basic-offset 4)
      (add-hook 'java-mode-hook
                (lambda ()
                  (setq indent-tabs-mode nil))) ;; Use spaces, not tabs

      ;; Enable DAP for Java debugging
      (require 'dap-java)
      (dap-java-configure)

      ;; Arduino setup
      (require 'arduino-mode)

      ;; Other key bindings
      (global-set-key (kbd "C-x g") 'magit-status)
    '';
  };

 **/
 
 
 
  # Optional configurations
  # Enable SSH
  # services.openssh.enable = true;

  # Firewall configuration
  # networking.firewall.enable = false;

  # System version
  system.stateVersion = "24.11"; # Adjust the version according to your NixOS release
}
