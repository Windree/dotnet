#!/usr/bin/env bash
set -euo pipefail
root="$(dirname "${BASH_SOURCE[0]}")"

function main() {
    cd "$root"
    echo "Start" && date
    while true; do
        echo "Wating for hook" && date
        nc -I 1 -l 46468 >/dev/null
        echo "Redeploy" && date
        docker compose stop &&
            git -C "data/web" reset --hard &&
            git -C "data/web" pull --ff &&
            docker compose up -d || true
        echo "Complete" && date
    done
}

main | tee -a "$root/deploy.log"
