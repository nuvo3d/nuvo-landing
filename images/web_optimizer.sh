#!/bin/bash 

# List of converted PNGs: 
declare -a converted_pngs

find . -name '*.jpg' -o -name '*.png' | while read line ;
	do echo "$line"				
	sizeoriginal=`wc -c $line`
	sizeoriginal=${sizeoriginal% *}

	# Check if image is a transparent png (Opaque pngs will be converted nonetheless)
	format=`identify -format '%[opaque]' $line`
	if [ "$format" == 'False' ]
	then
		echo "  Skip transparent image"
	  continue	
	fi

	convert $line -sampling-factor 4:2:0 -strip -quality 85 -interlace JPEG -colorspace sRGB __temp__.jpg
	sizetemp=`wc -c __temp__.jpg`
	sizetemp=${sizetemp% *}
	#echo "  comparing $sizetemp against $sizeoriginal"
	if [ $sizetemp -gt $sizeoriginal ]
	then
		echo "    optimized image is bigger than original. Aborting"
		continue
	fi
	echo "    optimizing image $line"
	mv __temp__.jpg "${line%.*}.jpg"

	# If file was not a jpg
  if [ "${line##*.}" != 'jpg' ]
  then
		converted_pngs+=($line)
  fi
done
	
echo "DONE: THE FOLLOWING OPAQUE PNG IMAGES WERE CONVERTED TO JPG. PLEASE CHANGE THEIR ADDRESS IN YOUR HTML FILES: "
echo ${converted_pngs[@]}
