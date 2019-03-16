#!/bin/sh
#
# $ print88palette.sh $

case ${BASH_VERSION-} in *.*) set -o posix; shopt -s xpg_echo; esac
case ${ZSH_VERSION-} in *.*) emulate ksh; esac

set -euf

colorbar () {
	# used `tput setaf 39 | hexdump -C` to figure out (and tput sgr0...)
	printf ' %2d ' $(($1 % 100))
	printf '|''\033[38;5;'$1'm''####''\033[m''|'
}

echo
amax=7 gmax=8
case ${TERM-} in *256*)
	echo
	echo "Saw '256' in TERM $TERM. Printing 256-color palette instead!"
	amax=26 gmax=29
esac

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
a=0
while test $a -le $amax
do
	for b in 0 1 2 3 4 5 6 7
	do colorbar $((a * 8 + b + 16))
	done
	echo
	a=$((a + 1))
done
v=$((a * 8 + 16))
test $v -ge 100 && echo $v v || echo
while test $a -le $gmax
do
	for b in 0 1 2 3 4 5 6 7
	do colorbar $((a * 8 + b + 16))
	done
	echo
	a=$((a + 1))
done
echo

if test $a -lt 20
then
  for r in 0 1 2 3
  do	for g in 0 1 2 3
	do	printf '  '
		for b in 0 1 2 3
		do printf '  %2d #'$r$g$b $(($r * 16 + $g * 4 + $b + 16))
		done
		case $g in [13]) echo ;; esac
	done
  done
else
  for r in 0 1 2 3 4 5
  do	for g in 0 1 2 3 4 5
	do	printf '  '
		for b in 0 1 2 3 4 5
		do printf '    %3d #'$r$g$b $(($r * 36 + $g * 6 + $b + 16))
		done
		echo
	done
  done
fi
echo


# Local variables:
# mode: shell-script
# sh-basic-offset: 8
# tab-width: 8
# End:
# vi: set sw=8 ts=8
