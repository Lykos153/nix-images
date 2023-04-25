{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixos-generators, ... }: {
    packages.x86_64-linux = {
      iso = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
        format = "iso";
        
        # you can also define your own custom formats
        # customFormats = { "myFormat" = <myFormatModule>; ... };
        # format = "myFormat";
      };
      qcow = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
        format = "qcow";
      };
      openstack = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
        format = "openstack";
      };
    };
  };
}
