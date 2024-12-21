build: clean compile link 

run: build
ifeq ($(OS),Windows_NT)
	Mesen starter.nes
else
	fceux starter.nes
endif

compile:
	ca65 ./src/starter.asm -g -o starter.o

link:
	ld65 -o starter.nes -C starter.cfg starter.o -m starter.map.txt -Ln starter.labels.txt --dbgfile starter.nes.dbg

clean:
ifeq ($(OS),Windows_NT)
	- cmd.exe /C 'del /f /q starter.o starter.nes starter.map.txt starter.labels.txt starter.nes.dbg starter.nes.ram.nl starter.nes.0.nl starter.nes.1.nl 2>NUL'
else
	- rm -f starter.o starter.nes starter.map.txt starter.labels.txt starter.nes.ram.nl starter.nes.0.nl starter.nes.1.nl
endif
