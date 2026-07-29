{ ... }:
{
  # Placeholder — replace with the real output of
  # `nixos-generate-config --show-hardware-config`
  # once you're actually on the ThinkPad.
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };
  boot.initrd.availableKernelModules = [ ];
  boot.kernelModules = [ ];
}
