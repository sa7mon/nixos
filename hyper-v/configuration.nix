# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  # Networking
  networking.hostName = "nixos"; # Define your hostname.
  networking.nameservers = [ "10.0.1.175" "1.1.1.1" "8.8.8.8" ];
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 8080 ];

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     keyMap = "us";
  };


  # XFCE 
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
  };

  # Hyper-V Options
  virtualisation.hypervGuest.videoMode = "1920x1080"; # TODO: Find out if this is doing anything
  boot.loader.grub.extraConfig = ''
    set video=hyperv_fb:1920x1080
  '';

  # Configure keymap in X11
  services.xserver.layout = "us";

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    root = {
      shell = pkgs.zsh;
    };
    dan = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      shell = pkgs.zsh;
    };
  };

  # Install packages
  environment.systemPackages = with pkgs; [
	curl
	firefox
	git
	htop
	jq
	ncdu
	nmap
	pigz
	pv
	(python39.withPackages (ps: with ps; [requests]))
	sqlite
	tmux
	tree
	wget
  ];

  # Custom scripts 
  system.activationScripts.dotfiles = ''
      if [ ! -d "/home/dan/dotfiles" ]; then
        mkdir -p /home/dan/dotfiles
        /run/current-system/sw/bin/git clone https://github.com/sa7mon/dotfiles.git /home/dan/dotfiles
        chown -R dan:users /home/dan/dotfiles
        ln -s /home/dan/dotfiles/profiles/nixos_hyperv.zshrc /home/dan/.zshrc
      fi 
  '';


  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.stateVersion = "21.05";
}

