# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  programs.nix-ld.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    libvlc
    xorg.libX11
    xorg.libXext
    xorg.libXrender
    xorg.libXtst
    xorg.libXi
    freetype
    fontconfig
    icu
  ];
  fonts.fontconfig.useEmbeddedBitmaps = true;






  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Santiago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_CL.UTF-8";
    LC_IDENTIFICATION = "es_CL.UTF-8";
    LC_MEASUREMENT = "es_CL.UTF-8";
    LC_MONETARY = "es_CL.UTF-8";
    LC_NAME = "es_CL.UTF-8";
    LC_NUMERIC = "es_CL.UTF-8";
    LC_PAPER = "es_CL.UTF-8";
    LC_TELEPHONE = "es_CL.UTF-8";
    LC_TIME = "es_CL.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.adwaita-mono
    nerd-fonts.jetbrains-mono
  ];
 
  # Define a user account. Don't forget to set a password with ‘passwd’.
  
  users.users.ale = {
    isNormalUser = true;
    description = "Ale";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      neovim
      tree-sitter
      uv
      ripgrep
      python3
      sublime3
      gcc
      discord
      libGL
      libGLU  
      spotify
      # atuin
      vscode
      zoom-us
      docker-compose
      postman
      benhsm-minesweeper
      aisleriot
      beekeeper-studio
      jetbrains-toolbox
      postgresql
   ];
  };

  # Programs
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  programs.firefox.enable = true;
  programs.dconf.enable = true;
  programs.neovim.enable = true;
  
  # Services
  services.libinput.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
  
  services.flatpak.enable = true;
  services.blueman.enable = true;
  services.postgresql = {
    enable = true;
    extraPlugins = with config.services.postgresql.package.pkgs; [
      pg_uuidv7
    ];
  };
  # Security
  security.pam.services.ly.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.rtkit.enable = true;

  
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  
  environment.systemPackages = with pkgs; [
    vim 
    wget
    curl
    foot
    git
    unzip
    zip
    waybar
    wofi
    swaylock
    swayidle
    grim
    slurp
    ranger
    wl-clipboard
    catppuccin-cursors.mochaDark
    gvfs
    nwg-dock-hyprland  # funciona en sway también
    rofi
    mako
    libnotify
    nwg-look      # configurar temas GTK
    papirus-icon-theme
    glib
    dconf
    pavucontrol
    vesktop
    nodejs_24
    stow
    openssl
    javaPackages.compiler.openjdk17-bootstrap
  ];




  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
  

  # Hardware
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;   # muestra batería de dispositivos conectados
        FastConnectable = true; # reconexión más rápida (gasta un poco más de batería)
      };
    };
  };
  hardware.graphics.enable = true;

  # Virtual Box
  virtualisation.virtualbox.host.enable = true;
  virtualisation.docker.enable = true;
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" "docker" ];

  
  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.3.4"
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

}

