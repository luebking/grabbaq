#!/bin/sh

# relies on redshift being installed, configured and working
# and makes convenient assumptions about "night" being from 0:00 to 4:00
# dusk has a slight redshift but full brightness, only day uses the light color scheme
# color-schemes from https://github.com/luebking/grabbaq/tree/main/color-schemes

SCHEME_DAY=arch-day
SCHEME_NIGHT=arch-night

########### hands off ######################

scheme="$SCHEME_NIGHT"
rshift=(-P -o -b 1.0:0.5)
mode="$1"
if [[ -z "$mode" ]]; then
    value=$(LC_ALL=C redshift -op 2>/dev/null | sed '/Color temperature/!d; s/Color temperature: \([0-9]*\)K/\1/')
    if (($value > 5500)); then
        mode=day
    else
        hour=$(date +%H)
        hour=${hour##0}
        if ((hour < 4)); then
            mode=night
        elif ((hour < 12)); then
            mode=dawn
        else
            mode=dusk
        fi
    fi
fi
case "$mode" in
d|day|bright)
    scheme="$SCHEME_DAY"
    rshift=(-x)
    ;;
dusk)
    rshift=(-PO 5500)
    ;;
dawn)
    rshift=(-x)
    ;;
n|night|dark)
    rshift=(-PO 4500 -b 0.5:0.5)
    ;;
*)
    value=$(LC_ALL=C redshift -op 2>/dev/null | sed '/Color temperature/!d; s/Color temperature: \([0-9]*\)K/\1/')
    if (($value > 5500)); then
        scheme="$SCHEME_DAY"
        rshift=(-x)
    fi
    ;;
esac
for qterm in $(qdbus6 | grep org.lxqt.QTerminal); do
    for term in $(qdbus6 $qterm | grep "/terminals/"); do
        qdbus6 $qterm $term setColorScheme $scheme
    done
done
redshift ${rshift[@]} > /dev/null 2>&1