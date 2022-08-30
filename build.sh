#!/usr/bin/env bash

#
# Usage:
#    ./build.sh lineageos-begonia
#

set -e
set -u
PS4=" $ "

config="$1"; shift

ARGS=(
	--out-link "$config"
	--arg configuration "./$config.nix"
	-A ota                          # Flashable zip we care about
	-A bootImg                      # boot.img, necessary for "boot as recovery" machines
	-A config.build.debugEnterEnv   # kA
	"$@"
)

case "$config" in
	"lineageos-begonia"      |\
	"lineageos-lavender"      \
	)
		ARGS+=(
			-A recoveryImg                  # recovery.img, for other targets (XXX: may not exist?)
		)
	;;
esac

set -x

time nix-build "${ARGS[@]}"
