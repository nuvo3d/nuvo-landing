#!/bin/bash

# gray 
convert $1 -fuzz 50% -fill gray -opaque gray $2.png
convert $2.png -resize 600x200 -background transparent  -gravity center -extent 600x200 $2@2x.png
mv $2@2x.png gray
convert $2.png -resize 300x100 -background transparent  -gravity center -extent 300x100 $2.png
mv $2.png gray

#white

convert $1 -fuzz 50% -fill white -opaque gray $2.png
convert $2.png -resize 600x200 -background transparent  -gravity center -extent 600x200 $2@2x.png
mv $2@2x.png white
convert $2.png -resize 300x100 -background transparent  -gravity center -extent 300x100 $2.png
mv $2.png white


