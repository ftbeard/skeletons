OUTPUTS = libft.a a.out


libft_SRCS = libft.c
libft_LANGUAGE = c

a.out_SRC_DIR = src
a.out_INCS = include2 include
a.out_SRCS = main.c a.c
a.out_LANGUAGE=c
a.out_LIBS = libft
a.out_libft_DIR = .



include include/Meta.mk
