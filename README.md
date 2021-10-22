## Resources

* [Options Search](https://search.nixos.org/options?channel=21.05&from=0&size=50&sort=relevance)
* [Manual](https://nixos.org/manual/nixos/stable/index.html)


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
