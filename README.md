# grabbaq
scripts and assets around qterminal and qiq

## backdrops
Various translucent images you can use as background images in your terminal

## color-schemes
Well, color schemes for qterminal/konsole…
Put them into ~/.config/qterminal.org/color-schemes/

* arch-day and arch-night
    Actually useful palettes cycling around the archlinux azure (#1793d0) as blue
* Amber, Emerald and Lumon
    Silly monochromatic schemes emulating old MGA CRTs
    (or in case of Lumon: fake, because blue CRTs were not really a thing)

## scripts
* man
   manpage viewer that does not require mandb but tries to find local mapages or draws them from man.archlinux.org
* nightshift.sh
  Script to toggle daylight/time driven color schemes and gamma ramps (brightness/redness) - requires working redshift setup
* qterm
  Helper functions required by some other scripts
* xncmpc
  ncmpcpp (mpd client) wrapper showcasing qterm functions and qterminal dbus interface
* forq
   Prototype function for cat9-a-like output splitting/job management, only tested on zsh for now