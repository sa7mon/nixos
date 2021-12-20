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

## Persistent Data Stuff


https://old.reddit.com/r/NixOS/comments/g8c734/how_to_clone_a_repository_at_a_specific_location/

https://github.com/yrashk/nix-home/blob/master/home.nix

https://stackoverflow.com/questions/53658303/fetchfromgithub-filter-down-and-use-as-environment-etc-file-source

https://www.reddit.com/r/NixOS/comments/emnc9d/your_home_in_nix_dotfile_management_with_home/

https://www.reddit.com/r/NixOS/comments/fb1p1o/replacing_dotfiles_with_nix/
