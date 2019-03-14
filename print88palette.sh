#!/bin/sh
#
# $ print88palette.sh $

case ${BASH_VERSION-} in *.*) set -o posix; shopt -s xpg_echo; esac
case ${ZSH_VERSION-} in *.*) emulate ksh; esac

set -euf

colorbar () {
        # used `tput setaf 39 | hexdump -C` to figure out (and tput sgr0...)
        printf ' %2d ' $1
        printf '|''\033[38;5;'$1'm''####''\033[m''|'
}

echo
echo
for c in 0 1 2 3 4 5 6 7
do colorbar $c
done
echo
for c in 8 9 10 11 12 13 14 15
do colorbar $c
done
echo
echo
for a in 0 1 2 3 4 5 6 7
do
        for b in 0 1 2 3 4 5 6 7
        do colorbar $((a * 8 + b + 16))
        done
        echo
done
echo
for c in 80 81 82 83 84 85 86 87
do colorbar $c
done
echo
echo

printf '  '
for r in 0 1 2 3
do      for g in 0 1 2 3
        do      for b in 0 1 2 3
                do printf '  %2d #'$r$g$b $(($r * 16 + $g * 4 + $b + 16))
                done
                case $g in [02]) printf '  ' ;; *) printf '\n  ' ;; esac
        done
done
echo


# Local variables:
# mode: shell-script
# sh-basic-offset: 8
# tab-width: 8
# End:
# vi: set sw=8 ts=8
