#!/usr/bin/env bash
#
# mlp_install.sh
#
# Michael Potter
# 2021-06-07

prefix=~/.mozilla/firefox/
profile_dir=$(
	cd $prefix
	fd prefs.js |
		tr '/' ' ' |
		acut 2 | 
		sort -u |
		sed "s,^,$prefix,g" |
		fzf --prompt="pick a user directory: "
)

fail() {
	echo >&2 "$@"
	exit 1
}

[[ -d $profile_dir ]] || fail "ERROR: profile dir not found"

mkdir -p $profile_dir/chrome
cp user.js $profile_dir
cp -r *.css $profile_dir/chrome
