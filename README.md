
Replace `blue` in `tig(1)` default colorscheme
==============================================

on 88-color terminals
---------------------

The `blue` color of `tig(1)` default colors on dark background
(e.g `black`, *rgb* `#000`) is somewhat hard to read.

There are quite a few tig colorschemes availabe out there, but
usually those are meant for 256-color terminals -- breaks badly
on 88-color terminal since the color indexes goes out of range.

Here we replace just the `blue` color from default colors with
something else (e.g `color39`, `#113`) for 88-color terminal
window.

(note: on 256-color urxvt `color39` is `#035`, which also looks
workable. there `color105` (`#225`) is probably closest to `39`
on 88-color terminal -- if anyone cared. for more details look
*color tech* at the end of this document.)

After the "installation" of the above replacement there are
instructions and tools that can be used to easily to visualize
any other color from the 88-color palette...


## "Installation" ##

(with pretty high probability that it works)

As executed in modern /bin/sh compatible shell.

<!--- hint:  less -X README.md  -->

<pre>
$ test ! -d ~/.config/tig || mv -v ~/.config/tig ~/.config/tig.bak

$ mkdir -pv ~/.config/tig

$ sed -n '/^color/ s/blue/color39/p' /etc/tigrc | tee ~/.config/tig/colors

$ echo '
# recreate tig-colors from (updated) /etc/tigrc for urxvt-88 dark bg with:
# sed -n '/^color/ s/blue/color39/p' /etc/tigrc | tee ~/.config/tig/colors

source ~/.config/tig/colors
' > ~/.config/tig/config

$ cat ~/.config/tig/config
</pre>

Now, if you had content in `~/.config/tig.bak` or `~/.tigrc` merge those to
`~/.config/tig/config` (if the latter exists (and is supported in your
 environment) it is read instead of `~/.tigrc`).

### Alternative (destructive) oneliner ###

    $ sed -n '/^color/ s/blue/color39/p' /etc/tigrc | tee ~/.tigrc

- overwrites old content if any
- may not be read if `~/.config/tig/config` exists


## Experiment with other colors ##

See [palette88.png](palette88.png) for sample of the default 88 colors
available on urxvt (and apparently xterm).

You can run [`./print88palette.sh`](print88palette.sh) on your terminal to
see how the above sample looks in your environment (that tool has been
updated to print 256-color palette when $TERM contains '256' in its value).

The tool [`./testigcolor.sh`](./testigcolor.sh) can be used to do quick
tests how `tig` behaves with any color you choose for `blue` replacement.
If you cloned this repo you can run e.g. `./testigcolor.sh 27`. Otherwise
`cd` to any git workspace (or set GIT_DIR) and then try testigcolor.sh...
`testigcolor.sh` provides usage information when run without arguments.


## A bit of urxvt(/xterm) color tech ##

On 88-color `urxvt` first 8 colors are "basic" colors, next 8 "high-intensity"
colors, next 64 (16-79) forms standard 4x4x4 color cube (and `man urxvt` says
the same as 88 color `xterm` so this should work there too) and rest 8 (80-87)
evenly spaced grey.

The color index from color cube is calculated using the following formula:

        r * 16 + g * 4 + b + 16

The `blue` color is `#002` -- too dark. The color `#113`, tried, then chosen
for replacement above was calculated as:

        1 * 16 + 1 * 4 + 3 + 16  =  39

For `tig(1)` that can be given as `color39` -- or just `39`. In this
context using `color39` is clearer.

### Experiments on 256-color terminal ###

I'm using 88-color urxvt terminal emulator since it has been good enough
for me; `urxvt` terminfo is more common than `urxvr-26color` and so on.

Anyway, since in `tig(1)` configuration one can (afaik) *only* configure
non-basic colors using color index -- and that index gives different color
when terminal color capabilities differ.

On 256-color `uxrvt` first 16 colors are like in 88-color `urxvt`. Next
216 (17-231) forms 6x6x6 color cube. Rest 24 (232-255) evenly shaped grey.

The color index from color cube is calculated using the following formula:

        r * 36 + g * 6 + b + 16

With that, `color39` gives `#035` (3 * 6 + 5 + 16), and `#225` `color105`
(2 * 36 + 2 * 6 + 5 + 16) -- just as related example to demonstrate how
these calculations work.

[`./print88palette.sh`](print88palette.sh) on 256-color terminal can
print 256-color palette (if $TERM contains '256' in is value -- if not,
prefix `TERM=256` to your `print88palette.sh` command line).

Last (and least), wasted some time to create this picture:
[blue-and-replacements.png](blue-and-replacements.png) to show how color39
looks on 88 and 256 color terminals.
