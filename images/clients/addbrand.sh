#!/bin/bash
grayscale=''

# print instructions
print_usage() {
	printf "Usage addbrand.sh [-g] <input_file.png> <output_number>"
}

while getopts ':gh' flag; do
	case "${flag}" in 
		g ) grayscale='true' ;;
		h ) print_usage ;;
	    \? ) echo "Invalid option: -$OPTARG" 1>&2 ; exit ;;
	esac 
done
shift $((OPTIND -1))

file_in=$1; shift
out=$1

for color in color gray white; do
	echo Exporting to $color/...
	if [[ $color = 'color' ]]; then
		cp $file_in $out.png
	else 
		if [[ "${grayscale}" ]]; then
			convert $file_in -colorspace gray $out.png
		else
			convert $file_in -fuzz 50% -fill $color -opaque gray $out.png
		fi
	fi
	
	convert $out.png -resize 600x200 -background transparent  -gravity center -extent 600x200 $out@2x.png
	mv $out@2x.png $color
	convert $out.png -resize 300x100 -background transparent  -gravity center -extent 300x100 $out.png
	mv $out.png $color
done


