# NixOS Hyper-V Setup


## Bootstrap new machine from ISO

```
parted /dev/sda -- mklabel msdos
parted /dev/sda -- mkpart primary 1MiB -8GiB
parted /dev/sda -- mkpart primary linux-swap -8GiB 100%

mkfs.ext4 -L nixos /dev/sda1
mkswap -L swap /dev/sda2

mount /dev/disk/by-label/nixos /mnt
swapon /dev/sda2

nixos-generate-config --root /mnt
nano /mnt/etc/nixos/configuration.nix
(Set boot.loader.grub.device and enable DHCP for ethernet device)

nixos-install
reboot
```
