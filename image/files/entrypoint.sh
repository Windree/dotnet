#!/usr/bin/env bash
set -Eeuxo pipefail

function stop() {
  pkill -9 dotnet || true
  pkill -9 node || true
  pkill -9 npm || true
}

trap stop EXIT

dotnet dev-certs https &&
  cd /data/App &&
  npm -C "Node" install &&
  dotnet nuget locals --clear all &&
  dotnet restore &&
  dotnet watch --non-interactive
