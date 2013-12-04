WIDTH=1366
HEIGHT=720

%.png: %.pov
	povray -I$< +W${WIDTH} +H${HEIGHT}

%.webm: %.pov
	povray -I$< +W${WIDTH} +H${HEIGHT} +KFI0 +KFF11
	ffmpeg -y -f image2 -i '$(<:.pov=)%02d.png' -b 3M $(@:.pov=.webm)

clean:
	$(RM) *.png
