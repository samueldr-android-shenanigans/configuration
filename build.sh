#!/usr/bin/env bash

#
# Usage:
#    ./build.sh lineageos-begonia -I robotnix=../
#

set -e
set -u
PS4=" $ "

config="$1"; shift

ARGS=(
	--out-link "$config"
	--arg configuration "./$config.nix"
	'<robotnix>'
	-A ota                          # Flashable zip we care about
	-A bootImg                      # boot.img, necessary for "boot as recovery" machines
	-A config.build.debugEnterEnv   # kA
	"$@"
)

set -x

time nix-build "${ARGS[@]}"
