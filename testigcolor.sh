#!/bin/sh
#
# $ testigcolor.sh - test-replace blue in tig colors with something else $

case ${BASH_VERSION-} in *.*) set -o posix; shopt -s xpg_echo; esac
case ${ZSH_VERSION-} in *.*) emulate ksh; esac

set -euf

saved_IFS=$IFS; readonly saved_IFS

die () { printf '%s\n' "$@"; exit 1; } >&2

test $# -ge 1 || die '' \
    "Usage: [GIT_DIR=...] [TIGRC_SYSTEM=...] $0 color [tig options]" '' \
	"  color: replaces 'blue' -- enter <number> or 'color'<number>" '' \
	'  hints the environment variables mentioned above ' '' \
	'    GIT_DIR      -- use to point somewhere else than $PWD/.git' \
	'    TIGRC_SYSTEM -- use to point somewhere else than /etc/tigrc' ''

tigrc_system=${TIGRC_SYSTEM:-/etc/tigrc}
test -f "$tigrc_system" || die "'$tigrc_system': no such file"

color=$1
shift

tigrc=`exec mktemp`
trap "rm -f $tigrc" 0

tig_config=${XDG_CONFIG_HOME:-$HOME/.config}/tig/config
test -f "$tig_config" || tig_config=$HOME/.tigrc

{	if test -f "$tig_config"
	then echo source $tig_config
	fi
	sed -n "/^color/ s/blue/$color/p" "$tigrc_system"
} > $tigrc

TIGRC_USER=$tigrc tig "$@"

# execute trap

# Local variables:
# mode: shell-script
# sh-basic-offset: 8
# tab-width: 8
# End:
# vi: set sw=8 ts=8
