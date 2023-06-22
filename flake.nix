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
      gpg-airgapped = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = [
          ./gpg-airgapped.nix
        ];
        format = "iso";
      };
      rescue-image = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = [
          ./rescue-image.nix
        ];
        format = "qcow";
      };
    };
  };
}
