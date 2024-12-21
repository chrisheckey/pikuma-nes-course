build: clean compile link 
	echo "complete"

run: build
	fceux starter.nes

compile:
	ca65 ./src/starter.asm -g -o starter.o

link:
	ld65 -o starter.nes -C starter.cfg starter.o -m starter.map.txt -Ln starter.labels.txt --dbgfile starter.nes.dbg

clean:
	rm -f starter.o starter.nes starter.map.txt starter.labels.txt starter.nes.ram.nl starter.nes.0.nl starter.nes.1.nl
