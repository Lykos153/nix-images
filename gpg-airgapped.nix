# This module defines a small NixOS installation CD.  It does not
# contain any graphical stuff.
{ config, pkgs, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>

    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>

    ./common.nix
  ];

  isoImage.isoBaseName = pkgs.lib.mkForce "gpg-airgapped";
  isoImage.squashfsCompression = "lz4";


  ## Make sure networking is disabled in every way possible.

  boot.initrd.network.enable = false;
  networking.dhcpcd.enable = false;
  networking.dhcpcd.allowInterfaces = [];
  networking.firewall.enable = true;
  networking.useDHCP = false;
  networking.useNetworkd = false;
  networking.wireless.enable = false;

  # Always copytoram so that, if the image is booted from, e.g., a
  # USB stick, nothing is mistakenly written to persistent storage.

  boot.kernelParams = [ "copytoram" ];

  environment.systemPackages = with pkgs; [
    tmux
    cfssl
    cryptsetup
    diceware
    ent
    git
    gitAndTools.git-extras
    gnupg
    (haskell.lib.justStaticExecutables haskellPackages.hopenpgp-tools)
    paperkey
    parted
    pcsclite
    pcsctools
    pgpdump
    pinentry-curses
    pwgen
    yubikey-manager
    yubikey-personalization
  ];

  services.udev.packages = [
    pkgs.yubikey-personalization
  ];

  services.pcscd.enable = true;
}
