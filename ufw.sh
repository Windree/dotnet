#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/.env"
set -Eeuo pipefail
for remote in "10.0.0.0/8" "172.16.0.0/12" "192.168.0.0/16" "fe80::/64"; do
    for port in "$HTTP_PORT" "$HTTPS_PORT"; do
        ufw allow from "$remote" to any port "$port" proto tcp
    done
done

ufw reload
