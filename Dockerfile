FROM nixos/nix:2.19.6 AS builder

WORKDIR /tmp
COPY flake.nix flake.lock ./
COPY ci ./ci

RUN nix \
    --extra-experimental-features "nix-command flakes" \
    --option filter-syscalls false \
    profile install .

ENTRYPOINT ["ci.sh"]
