CXX=g++
CXXFLAGS=-Os -Wall
LIBS=-lX11 -lXft -lfontconfig -linih
INCLUDES=`pkg-config --cflags fontconfig`

BIN=rpbar rpbarsend

all: ${BIN}

.cc.o:
	${CXX} -c ${CXXFLAGS} $<

rpbar.o: rpbar.cc rpbar.hh settings.hh drw.h
	${CXX} -c ${CXXFLAGS} ${INCLUDES} $<

drw.o: drw.c drw.h
	${CXX} -c ${CXXFLAGS} drw.c

rpbar: rpbar.o drw.o
	${CXX} -o $@ $^ ${LIBS}

rpbarsend.o: rpbarsend.cc

rpbarsend: rpbarsend.o settings.hh
	${CXX} -o $@ $^

clean:
	rm -f *.o ${BIN}

install:
	cp rpbar /usr/local/bin/rpbar
	cp rpbarsend /usr/local/bin/rpbarsend

.PHONY: all clean
