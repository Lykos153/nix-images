{ pkgs, ...}:
{
  # Enable SSH in the boot process.
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDKlRduYVKvoKkxxYEiAxV0ncosPctELxAYmEBzgx8GekyJxhSpGF7D0AwVpVF4UBa4z8XoVUrZB7IlVu/RuCHbq4LMHqsm14F6pW4BqRqZlkdHCMGQiR/qYiMlm0YItZ8lgtqH6yiVtN4vnJQ4jO2L8U4vsjWidiri+bHSiIYwggkGEgY2XcTLwWNHZNwR8u8WzGbnGOpHHKU3e69HHw45SnoyK31fxdXfxQxZMrnaUVTylnbWHO5jcr3Pfj67wyPQofKvETXUzCx4mTBjaZDKgMISeYbKz61Xgi07zXJFSRY9KB5XeBEZrmTM3AXfKcyuC4el7EtEDmVmj5Cu8q27 silvio@silvio-pc"
  ];


  environment.systemPackages = with pkgs; [
    tmux
    upterm
  ];
  system.stateVersion = "23.05";
}
