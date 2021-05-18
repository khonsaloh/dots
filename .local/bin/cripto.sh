#!/bin/sh

if [ -f "$1" ]; then
	tipo="$(file -b --mime-type "$1" | rev| cut -d' ' -f1 | rev)"
	case $tipo in
	  application/pg*) gpg -d "$1";;
	  *) gpg -ca "$1";;
	esac
else
	#a=$(pwd)
	a="$(file --mime-type * | grep 'application/pgp')" \
		&& b="$(printf "$a" | fzf)" && [ -n "$b" ] \
		&& name=$(echo "$b" |cut -d' ' -f1 |tr -d ':') \
		&& tipo=$(echo "$b" |rev | cut -d' ' -f1|rev)
	[ -z "$b" ] && exit
		case $tipo in
	  		application/pg*) gpg -d "$name";;
		esac
fi
