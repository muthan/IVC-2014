WIDTH=1366
HEIGHT=768

%.png: %.pov
	povray -I$< +W${WIDTH} +H${HEIGHT}

%.webm: %.pov
	povray -I$< +W${WIDTH} +H${HEIGHT} +KFI0 +KFF20
	ffmpeg -y -f image2 -i '$(<:.pov=)%02d.png' -b 3M $(@:.pov=.webm)

%.gif: %.pov
	povray -I$< +W${WIDTH} +H${HEIGHT} +KFI0 +KFF20
	ffmpeg -y -f image2 -i '$(<:.pov=)%02d.png' -b 3M $(@:.pov=.webm)
	ffmpeg -i $a.webm -pix_fmt rgb24 -s qcif -loop_output 0 $a.gif

clean:
	$(RM) *.png
