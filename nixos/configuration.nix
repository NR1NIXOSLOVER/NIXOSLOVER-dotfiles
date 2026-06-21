{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos-btw";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Warsaw";

  # Desktop (X11/Wayland via SDDM) + SDDM Wayland.
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # KDE Plasma 6
  services.desktopManager.plasma6.enable = true;

  # Console keymap
  console.keyMap = "pl2";

  # Keymap (X11/Wayland)
  services.xserver = {
    xkb.layout = "pl";
    xkb.variant = "";
  };

  # Printing
  services.printing.enable = true;

  # Sound (PipeWire)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Users
  users.users."arizonapl" = {
    isNormalUser = true;
    description = "AriZonaPL";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-mono
  ];

  # Enable Firefox
  programs.firefox.enable = true;

  # Unfree packages
  nixpkgs.config.allowUnfree = true;

  # Hyprland (this is important for SDDM to know about the session)
  programs.hyprland = {
    enable = true;
    # If you want extra session helpers, leave defaults; NixOS modules handle it.
  };

  # System packages (single definition)
  environment.systemPackages = with pkgs; [
    vim
    kitty
    fastfetch
    git
    waybar
    rofi
    hyprpaper
    awww
    hyprlauncher
    waypaper
    cava
    cmatrix
    spotify
    tty-clock
    hyfetch
    pavucontrol
    hyprpanel
    wlogout
    neovim
    solaar
    lavat
    gcc
    clang
    ghostty
    figlet
    cowsay

    hyprland
    xdg-utils
  ];

  # Services
  services.openssh.enable = true;
  services.flatpak.enable = true;

  # Recommended for Wayland desktops to integrate with portals
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  # NixOS state version
  system.stateVersion = "26.05";
}
