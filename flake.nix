# SPDX-License-Identifier: AGPL-3.0-or-later
# flake.nix - Nix flake for ipv6-only (RSR compliant: Rust-only)
{
  description = "IPv6-Only Tools - Comprehensive IPv6 networking toolkit (Rust)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };

        # Rust toolchain
        rustToolchain = pkgs.rust-bin.stable.latest.default.override {
          extensions = [ "rust-src" "rust-analyzer" "rustfmt" "clippy" ];
        };

      in
      {
        # Development shell (Rust-focused)
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Rust toolchain
            rustToolchain
            cargo-audit
            cargo-outdated
            cargo-tarpaulin

            # Deno (RSR allowed)
            deno

            # Build tools
            just
            git

            # Container tools (nerdctl/podman preferred)
            podman
            buildah
            skopeo

            # Documentation
            asciidoctor

            # Network tools
            iproute2
            iputils
            bind
            tcpdump

            # Linters and formatters
            shellcheck
            shfmt

            # Other utilities
            jq
            curl
          ];

          shellHook = ''
            echo "IPv6-Only Tools Development Environment"
            echo "========================================"
            echo ""
            echo "Available commands:"
            echo "  just --list    # Show all automation recipes"
            echo "  just setup     # Complete environment setup"
            echo "  just test      # Run all tests"
            echo "  just build     # Build all components"
            echo ""
            echo "Rust: $(rustc --version)"
            echo "Cargo: $(cargo --version)"
            echo ""
            echo "Tools:"
            echo "  just: $(just --version)"
            echo "  podman: $(podman --version | head -n1)"
            echo ""

            # Set up environment
            export PATH="$PWD/bin:$PATH"

            # IPv6 configuration
            export IPV6_TOOLS_CONFIG="$PWD/config/ipv6-tools.ncl"
            export IPV6_TOOLS_DATA="$PWD/data"
          '';
        };

        # Rust package
        packages.ipv6-only = pkgs.rustPlatform.buildRustPackage {
          pname = "ipv6-only";
          version = "0.1.0";

          src = ./.;

          cargoLock = {
            lockFile = ./Cargo.lock;
          };

          meta = with pkgs.lib; {
            description = "IPv6 address manipulation, subnet calculation, and network planning tools";
            homepage = "https://github.com/hyperpolymath/ipv6-only";
            license = with licenses; [ agpl3Plus ];
            maintainers = [ ];
            platforms = platforms.all;
          };
        };

        packages.default = self.packages.${system}.ipv6-only;

        # Container image using Nix
        packages.container = pkgs.dockerTools.buildLayeredImage {
          name = "ipv6-only";
          tag = "latest";

          contents = with pkgs; [
            self.packages.${system}.default
            iproute2
            iputils
            bind
            bashInteractive
            coreutils
            cacert
          ];

          config = {
            Cmd = [ "${pkgs.bashInteractive}/bin/bash" ];
            Env = [
              "PATH=/bin"
              "SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
            ];
            WorkingDir = "/app";
            ExposedPorts = {
              "8080/tcp" = {};
            };
            Labels = {
              "org.opencontainers.image.source" = "https://github.com/hyperpolymath/ipv6-only";
              "org.opencontainers.image.licenses" = "AGPL-3.0-or-later";
            };
          };
        };

        # Apps for running tools
        apps = {
          ipv6 = {
            type = "app";
            program = "${self.packages.${system}.default}/bin/ipv6";
          };
          default = self.apps.${system}.ipv6;
        };

        # Checks (tests)
        checks = {
          rust-tests = pkgs.runCommand "rust-tests" {
            buildInputs = [ rustToolchain ];
          } ''
            cd ${./.}
            cargo test --all-features
            touch $out
          '';

          format-check = pkgs.runCommand "format-check" {
            buildInputs = [ rustToolchain ];
          } ''
            cd ${./.}
            cargo fmt --all -- --check
            touch $out
          '';

          clippy-check = pkgs.runCommand "clippy-check" {
            buildInputs = [ rustToolchain ];
          } ''
            cd ${./.}
            cargo clippy --all-targets --all-features -- -D warnings
            touch $out
          '';
        };

        # Formatter
        formatter = pkgs.nixpkgs-fmt;
      }
    );
}
