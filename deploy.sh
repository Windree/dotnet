#!/usr/bin/env bash
set -euo pipefail
root="$(dirname "${BASH_SOURCE[0]}")"
source "$root/.env"

function main() {
    cd "$root"
    echo "$(date) Start"
    while true; do
        echo "$(date) Wating for hook"
        nc -I 1 -l "$DRAGONSOUL_ART_DEPLOY_PORT" >/dev/null
        (deploy || true) | /app/mutt/app.sh -s "Art deployed" windree@dragonsoul.com
    done
}

function deploy() {
    echo "$(date) Redeploy"
    docker compose stop &&
        git -C "data/web" clean -fd &&
        git -C "data/web" reset --hard &&
        git -C "data/web" pull --ff &&
        docker compose up -d || true
    echo "$(date) Complete"
}

main | tee -a "$root/deploy.log"
