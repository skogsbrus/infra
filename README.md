# ☁️ skogsbrus/infra ☁️

This repository defines my private cloud infrastructure.

## Structure

`envs` contain the root files for all environments. Modules are then sourced from `modules/*`.

## Setup

### Nix

If you use `direnv`:

```bash
echo "use flake >> .envrc" && direnv allow
```

### Others

See `flake.nix` for required dependencies.

## Development

### CI/CD

Changes to `.tf` files will trigger the CI/CD pipeline. Changes on `main` are
auto-applied whereas only `terraform plan` will run on unmerged pull requests.
Unlike Gitlab CI, there doesn't seem to be any nice mechanisms for manual job
triggers unless you're on Github Pro. But hey, it works.

The pipeline uses a combination of Nix and Docker, inspired by [this blog
post](https://mitchellh.com/writing/nix-with-dockerfiles), where the built
container uses Nix internally to guarantee reproducible builds.

### Making changes

The `dev` and `prod` environments are meant to reflect each other. Any change in `prod` should first be done in `dev` to ensure that the operation is valid and safe.
