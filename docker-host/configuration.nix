{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # GRUB 2
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  # Networking
  networking.hostName = "nixos-docker";
  networking.nameservers = [ "10.0.1.175" "1.1.1.1" "8.8.8.8" ];
  networking.useDHCP = false; # Disable global DHCP, enable just for interface
  networking.interfaces.ens18.useDHCP = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  time.timeZone = "America/Chicago";

  # Users
  users.users = {
    root = {
      shell = pkgs.zsh;
    };
    dan = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDbhzUxkKECvtEMh5R0BtW8iK7ln9b6j0VouSPsKu0cKqlNynCCxkecAj/ogmV+fP7pxb/YTsk/TGyc9tuXgz4SRWeTl+7FONipHxLy1ceUTq2dTHBKu70cl+R70wJ//vrELKvYiuW3rjHZHr5hzSB0pI37ugSu+jmQKiUq71PzGYbSmn7p886Ia0qltaRGvZAxOv3PugFHKSO99mJs3vs+6JUfKI7XV/MDHX5ziRXpXMFhdupUZtv4jFNpp4/Y6/+prUTjkNHIVgIkdnMmMhb8emA3EPdDkdpEOXypEJS1gpt9MpIiFPVh/SibPS2t4Etv3m0iJN24XMhjbOBj2gN9pIJEzf05aKZU4WPwHH9N3nStRy+YFCUr6P2IvQIur/eKLxxQgeCrNTl+EiCPC2xLeh4IBjuHX0Q+CNY522B+IDnIL1kxqLyfwfidC9yQko3yYc2QzvFp4ln+UVDtxT3O1z8KKtAXNG1XdFHBqsREESK2/VlkgwTrr4cmeXodxjnCbcvoriGKGUtB7Dia402FiYFGpmBnAqguH0tPOKf4NIdscI7rIEg0Lfv8WHOXhCxWlX0WrWLunFSfikYNdDd/1FzixYn29rtzIpg6BE6Y/fl/wdAFhgrQxqV/3rHDG+I5U2p/487wGIjq5l7NqFTRggmiLQK666GpVm7VZsq7QQ== dan.sa7mon@gmail.com" ];
    };
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    git
    htop
    tmux
    wget
  ];

  programs.zsh.enable = true;

  # OpenSSH
  services.openssh.enable = true;
  services.openssh.authorizedKeysFiles = [".ssh/authorized_keys"];

  # Docker
  #virtualisation.docker.enable = true;

  system.stateVersion = "21.05";
}
