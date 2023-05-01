# skogsbrus/infra

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

### Making changes

The `dev` and `prod` environments are meant to reflect each other. Any change in `prod` should first be done in `dev` to ensure that the operation is valid and safe.
