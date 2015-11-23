
EXTRA_DIR ?= extra
LIB_DIR ?= lib
BIN_DIR ?= bin
BUILD_DIR ?= .build




########### USER INFOS ######################
LIBS = libft.a

libft_SRCS = aaa.c bbb.c
libft_OBJS = $(OBJS:.c=.o)

libft_INCLUDE_DIR = .
libft_SRC_DIR = .

LIBS_NAME = $(basename $(LIBS))
LIBS_FULL = $(addprefix $(LIB_DIR)/,$(LIBS))

########### Common.mk #######################


all: main.o


main.o: main.c
	gcc -c main.c -o main.o

depend: .depend

.depend: main.c
	rm -rf ./.depend
	$(CC) -MM $^ > ./.depend

-include .depend

.PHONY: all depend
