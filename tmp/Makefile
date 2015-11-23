
EXTRA_DIR ?= extra
LIB_DIR ?= lib
BIN_DIR ?= bin
BUILD_DIR ?= .build

INCLUDE_DIR ?= include
SRC_DIR ?= src

ARFLAGS = rcs



########### USER INFOS ######################

LIBS = libft.a

LIBS_FULL = $(addprefix $(LIB_DIR)/,$(LIBS))

libft_INCLUDE_DIR = include
libft_SRC_DIR = src
libft_SRCS = main.c a.c 






########### Common.mk #######################

#LIBS_NAME = $(basename $(LIBS))
#LIBS_FULL = $(addprefix $(LIB_DIR)/,$(LIBS))

all: $(LIBS_FULL)

$(LIB_DIR):
	@mkdir -p $(LIB_DIR)

	

libft_NAME = libft.a
libft_SRCS_FULL = $(addprefix $(libft_SRC_DIR)/,$(libft_SRCS))

libft_OBJS = $(libft_SRCS:.c=.o)
libft_OBJS_FULL = $(addprefix $(libft_SRC_DIR)/$(BUILD_DIR)/,$(libft_OBJS))


$(libft_SRC_DIR)/$(BUILD_DIR):
	@mkdir -p $(libft_SRC_DIR)/$(BUILD_DIR)


$(libft_SRC_DIR)/$(BUILD_DIR)/%.o: $(libft_SRC_DIR)/%.c $(libft_SRC_DIR)/$(BUILD_DIR)
	$(CC) -I $(libft_INCLUDE_DIR) -c $< -o $@



$(LIB_DIR)/$(libft_NAME): $(LIB_DIR) $(libft_OBJS_FULL)
	$(AR) $(ARFLAGS) $(LIB_DIR)/$(libft_NAME) $(libft_OBJS_FULL)

clean_libft:
	$(RM) -r $(libft_SRC_DIR)/$(BUILD_DIR)

cleanout_libft:
	$(RM) $(LIB_DIR)/$(libft_NAME)
	@rmdir $(LIB_DIR) 2> /dev/null || true


fclean: clean_libft cleanout_libft

re: fclean all

depend: .depend


INCLUDE_DIR_LIST = -I $(libft_INCLUDE_DIR) ### TODO
.depend: $(libft_SRCS_FULL) ### TODO
	@echo --- Create dependencies ---
	@$(RM) $@
	@$(CC) $(INCLUDE_DIR_LIST) -MM $^ > $@ || $(RM) $@ 

-include .depend

.PHONY: objects depend
