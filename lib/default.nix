{ inputs }:

{
  flake = rec {
    bash = system:
      let
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      in
      pkgs.runCommand "bash"
        {
          src = ../template/bash;
        } ''
        mkdir -p $out
        cp --no-preserve=mode -r $src/* $out
        cat $out/flake.nix
      '';

    darwin = system:
      let
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      in
      pkgs.runCommand "darwin"
        {
          src = ../template/darwin;
        } ''
        mkdir -p $out
        cp --no-preserve=mode -r $src/* $out
        sed -i -e "s/<username>/username/g" $out/flake.nix
        sed -i -e "s/throw //g" $out/flake.nix
        sed -i -e "s/ # TODO.*$//g" $out/flake.nix
        cat $out/flake.nix
      '';

    go-mod = system:
      let
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      in
      pkgs.runCommand "go-mod"
        {
          src = ../template/go-mod;
        } ''
        mkdir -p $out
        cp --no-preserve=mode -r $src/* $out
        cat $out/flake.nix
      '';

    go-pkg = system:
      let
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      in
      pkgs.runCommand "go-pkg"
        {
          src = ../template/go-pkg;
        } ''
        mkdir -p $out
        cp --no-preserve=mode -r $src/* $out
        cat $out/flake.nix
      '';

    nixos-desktop = system: desktop:
      let
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      in
      pkgs.runCommand "nixos-desktop"
        {
          hardware_configuration = nixos-hardware system;
          src = ../template/nixos-desktop;
        } ''
        mkdir -p $out
        cp --no-preserve=mode -r $src/* $out
        cp --no-preserve=mode $hardware_configuration $out/system/hardware-configuration.nix
        sed -i -e "s/<username>/username/g" $out/flake.nix
        sed -i -e "s/<password>/password/g" $out/flake.nix
        sed -i -e "s/throw //g" $out/flake.nix
        sed -i -e "s/ # TODO.*$//g" $out/flake.nix
        sed -i -e "s/desktop = \"gnome\"/desktop = \"${desktop}\"/g" $out/flake.nix
        sed -i -e "s/\/etc\/nixos\/hardware-configuration.nix/\.\/hardware-configuration.nix/g" $out/system/nixos.nix
        cat $out/flake.nix
        cat $out/system/nixos.nix
      '';

    nixos-hardware = system:
      let
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      in
      pkgs.runCommand "nixos-hardware" { } ''
        cat > $out <<EOF
        { config, lib, pkgs, modulesPath, ... }: {
          imports = [ ];
          boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "nvme" "usbhid" "sr_mod" ];
          boot.initrd.kernelModules = [ ];
          boot.kernelModules = [ ];
          boot.extraModulePackages = [ ];
          fileSystems."/" =
            {
              device = "/dev/disk/by-label/nixos";
              fsType = "ext4";
            };
          fileSystems."/boot" =
            {
              device = "/dev/disk/by-label/boot";
              fsType = "vfat";
            };
          networking.useDHCP = lib.mkDefault true;
          swapDevices = [ ];
        }
        EOF
        cat $out
      '';

    nixos-minimal = system:
      let
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      in
      pkgs.runCommand "nixos-minimal"
        {
          hardware_configuration = nixos-hardware system;
          src = ../template/nixos-minimal;
        } ''
        mkdir -p $out
        cp --no-preserve=mode -r $src/* $out
        cp --no-preserve=mode $hardware_configuration $out/system/hardware-configuration.nix
        sed -i -e "s/<username>/username/g" $out/flake.nix
        sed -i -e "s/<password>/password/g" $out/flake.nix
        sed -i -e "s/throw //g" $out/flake.nix
        sed -i -e "s/ # TODO.*$//g" $out/flake.nix
        sed -i -e "s/\/etc\/nixos\/hardware-configuration.nix/\.\/hardware-configuration.nix/g" $out/system/nixos.nix
        cat $out/flake.nix
        cat $out/system/nixos.nix
      '';

    ocaml = system:
      let
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      in
      pkgs.runCommand "ocaml"
        {
          src = ../template/ocaml;
        } ''
        mkdir -p $out
        cp --no-preserve=mode -r $src/* $out
        cat $out/flake.nix
      '';

    python-app = system:
      let
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      in
      pkgs.runCommand "python-app"
        {
          src = ../template/python-app;
        } ''
        mkdir -p $out
        cp --no-preserve=mode -r $src/* $out
        cat $out/flake.nix
      '';

    python-pkg = system:
      let
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      in
      pkgs.runCommand "python-pkg"
        {
          src = ../template/python-pkg;
        } ''
        mkdir -p $out
        cp --no-preserve=mode -r $src/* $out
        cat $out/flake.nix
      '';

    rust = system:
      let
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      in
      pkgs.runCommand "rust"
        {
          src = ../template/rust;
        } ''
        mkdir -p $out
        cp --no-preserve=mode -r $src/* $out
        cat $out/flake.nix
      '';
  };
}
