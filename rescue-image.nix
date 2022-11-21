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

  # Enable SSH in the boot process.
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDKlRduYVKvoKkxxYEiAxV0ncosPctELxAYmEBzgx8GekyJxhSpGF7D0AwVpVF4UBa4z8XoVUrZB7IlVu/RuCHbq4LMHqsm14F6pW4BqRqZlkdHCMGQiR/qYiMlm0YItZ8lgtqH6yiVtN4vnJQ4jO2L8U4vsjWidiri+bHSiIYwggkGEgY2XcTLwWNHZNwR8u8WzGbnGOpHHKU3e69HHw45SnoyK31fxdXfxQxZMrnaUVTylnbWHO5jcr3Pfj67wyPQofKvETXUzCx4mTBjaZDKgMISeYbKz61Xgi07zXJFSRY9KB5XeBEZrmTM3AXfKcyuC4el7EtEDmVmj5Cu8q27 silvio@silvio-pc"
  ];


  isoImage.isoBaseName = pkgs.lib.mkForce "rescue-image";
  isoImage.squashfsCompression = "lz4";
  environment.systemPackages = with pkgs; [
    tmux
    upterm
  ];
}
