#!/usr/bin/env bash
set -euo pipefail
root="$(dirname "${BASH_SOURCE[0]}")"

git -C "$root" pull
git -C "$root/data/web" reset --hard
git -C "$root/data/web" pull --ff

docker compose stop && \
docker compose up --build -d
