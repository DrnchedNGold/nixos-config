#
# Hardware settings for HP ProBook 650 G1 15.6" Laptop
# Dual boot active. Windows @ sda4 / NixOS @ sda5
#
# flake.nix
#  └─ ./hosts
#      └─ ./laptop
#          ├─ default.nix
#          └─ hardware-configuration.nix *
#
# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.

{ config, lib, pkgs, modulesPath, host, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usbhid" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];  #amdgpu, nvidia?
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/cef5ca58-992d-4bd9-b108-3b874fa78e8a";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/D81F-34A5";
      fsType = "vfat";
    };

  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/mnt/windows-partition" =
    { device = "/dev/disk/by-uuid/8C0A20ED0A20D64C";
      fsType = "ntfs-3g";
      options = [ "rw" "uid=1000" ];  # (terminal)$ id
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp4s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
