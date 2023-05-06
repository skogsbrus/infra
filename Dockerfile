FROM nixos/nix:latest AS builder

WORKDIR /tmp
COPY flake.nix flake.lock ./
COPY ci ./ci

RUN nix \
    --extra-experimental-features "nix-command flakes" \
    --option filter-syscalls false \
    profile install .

ENTRYPOINT ["ci.sh"]
