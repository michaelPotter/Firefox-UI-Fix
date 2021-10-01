#!/usr/bin/env bash
#
# mlp_install.sh
#
# Michael Potter
# 2021-06-07

prefix=~/.mozilla/firefox/

if [[ -d $1 ]]; then
	profile_dir=$1
else
	profile_dir=$(
		cd $prefix
		fd prefs.js |
			tr '/' ' ' |
			acut 1 |
			sort -u |
			sed "s,^,$prefix,g" |
			fzf --prompt="pick a user directory"
	)
fi

[[ -d $profile_dir ]] || (echo >&2 "profile dir not found" && exit 1)

mkdir -p $profile_dir/chrome
cp user.js $profile_dir
cp -r * $profile_dir/chrome
