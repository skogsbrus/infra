#!/usr/bin/env bash
set -euo pipefail

usage() {
    echo "usage: $0 ACTION DIR BACKEND_CONFIG"
    exit 1
}

init() {
    terraform init -backend-config="$BACKEND_CONFIG"
}

plan() {
    init
    terraform plan
}

apply() {
    init
    terraform apply
}

if [[ "$#" -ne 3 ]]; then
    usage
fi

ACTION=$1
DIR=$2
BACKEND_CONFIG=$3

cd "$DIR"

case "$ACTION" in
    plan|--plan) plan && break ;;
    apply|--apply) apply && break ;;
    help|--help) usage ;;
    *) echo "Unknown action '$ACTION'" && usage "$@" ;;
esac
