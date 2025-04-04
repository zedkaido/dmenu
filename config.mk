# dmenu version
VERSION = 5.3

# paths
PREFIX = /usr/local
MANPREFIX = $(PREFIX)/share/man

OS := $(shell uname -s)
ifeq ($(OS),Linux)
	X11INC = /usr/X11R6/include
	X11LIB = /usr/X11R6/lib
	FREETYPEINC = /usr/include/freetype2
else ifeq($(OS),Darwin)
	X11INC = /opt/X11/include
	X11LIB = /opt/X11/lib
	BREW_FREETYPE = $(shell brew --prefix freetype 2>/dev/null || echo "/usr/local/bin/freetype")
	FREETYPEINC = $(BREW_FREETYPE)/include/freetype2 
else ifeq($(OS), OpenBSD)
	X11INC = /usr/X11R6/include
	X11LIB = /usr/X11R6/lib
	FREETYPEINC = $(X11INC)/freetype2
	MANPREFIX = ${PREFIX}/man
else
	$(WARNING: Unsupported OS: $(OS), using linux defaults)
	X11INC = /usr/X11R6/include
	X11LIB = /usr/X11R6/lib
	FREETYPEINC = /usr/include/freetype2
endif

# Xinerama, comment if you don't want it
XINERAMALIBS  = -lXinerama
XINERAMAFLAGS = -DXINERAMA

# freetype
FREETYPELIBS = -lfontconfig -lXft

# includes and libs
INCS = -I$(X11INC) -I$(FREETYPEINC)
LIBS = -L$(X11LIB) -lX11 $(XINERAMALIBS) $(FREETYPELIBS)

# flags
CPPFLAGS = -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_XOPEN_SOURCE=700 -D_POSIX_C_SOURCE=200809L -DVERSION=\"$(VERSION)\" $(XINERAMAFLAGS)
CFLAGS   = -std=c99 -pedantic -Wall -Os $(INCS) $(CPPFLAGS)
LDFLAGS  = $(LIBS)

# compiler and linker
CC = cc
