{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  hardware.opengl.enable = true;
  hardware.pulseaudio.enable = true;
  sound.enable = true;

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };

  time.timeZone = "Europe/London";

  networking = {
    hostName = "yghor-notebook";
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "dvorak";
    defaultLocale = "en_GB.UTF-8";
  };

  environment.systemPackages = with pkgs; [
    alacritty
    bash
    cryptsetup
    dmenu
    emacs
    gitFull
    gnumake
    gnupg
    iosevka
    ntfs3g
    pass
    pass-otp
    st
    udisks
    yubikey-manager
    yubikey-personalization
  ];

  programs = {
    bash.enableCompletion = true;
    chromium.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    mtr.enable = true;
    sway.enable = true;
  };

  virtualisation.docker.enable = true;

  users.users.yghor = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  system.stateVersion = "19.03";
}
