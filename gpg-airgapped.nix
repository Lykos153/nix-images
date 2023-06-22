{ config, pkgs, lib, ... }:
{
  imports = [
    ./common.nix
  ];



  ## Make sure networking is disabled in every way possible.
  nixpkgs = {
    overlays = [
      (self: super: {
        linuxNoNetwork = pkgs.linuxPackagesFor (pkgs.linux.override {
          structuredExtraConfig = with lib.kernel; {
            CONFIG_NET = no;
          };
          ignoreConfigErrors = true;
        });
      })
    ];
  };
  boot.kernelPackages = pkgs.linuxNoNetwork;

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
    # (haskell.lib.justStaticExecutables haskellPackages.hopenpgp-tools)
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
