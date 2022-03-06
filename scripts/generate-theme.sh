#!/bin/sh

sass themes/theme.scss themes/theme.css
godot -s addons/godot-css-theme/convert.gd --input="res://themes/theme.css"