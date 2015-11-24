
EXTRA_DIR ?= extra
LIB_DIR ?= lib
BIN_DIR ?= bin
BUILD_DIR ?= .build

INCLUDE_DIR ?= include
SRC_DIR ?= src

ARFLAGS = rcs



########### USER INFOS ######################

LIBS = libft.a


libft_INCLUDE_DIR = include
libft_SRC_DIR = src
libft_SRCS = main.c a.c 


libft_NAME = $(LIBS) ### TODO

ifeq ($(suffix $(libft_NAME)),.a)
  LIBS_FULL = $(addprefix $(LIB_DIR)/,$(LIBS))
else
  LIBS_FULL = $(addprefix $(BIN_DIR)/,$(LIBS))
endif


########### Common.mk #######################

#LIBS_NAME = $(basename $(LIBS))
#LIBS_FULL = $(addprefix $(LIB_DIR)/,$(LIBS))


all: $(LIBS_FULL)

$(LIB_DIR):
	@mkdir -p $(LIB_DIR)

$(BIN_DIR):
	@mkdir -p $(BIN_DIR)

	

libft_SRCS_FULL = $(addprefix $(libft_SRC_DIR)/,$(libft_SRCS))

libft_OBJS = $(libft_SRCS:.c=.o)
libft_OBJS_FULL = $(addprefix $(libft_SRC_DIR)/$(BUILD_DIR)/,$(libft_OBJS))


$(libft_SRC_DIR)/$(BUILD_DIR):
	@mkdir -p $(libft_SRC_DIR)/$(BUILD_DIR)


$(libft_SRC_DIR)/$(BUILD_DIR)/%.o: $(libft_SRC_DIR)/%.c $(libft_SRC_DIR)/$(BUILD_DIR)
	$(CC) -I $(libft_INCLUDE_DIR) -c $< -o $@



ifeq ($(suffix $(libft_NAME)),.a)
$(LIB_DIR)/$(libft_NAME): $(LIB_DIR) $(libft_OBJS_FULL)
	$(AR) $(ARFLAGS) $(LIB_DIR)/$(libft_NAME) $(libft_OBJS_FULL)
else
$(BIN_DIR)/$(libft_NAME): $(BIN_DIR) $(libft_OBJS_FULL)
	$(CC) $(libft_OBJS_FULL) -o $(BIN_DIR)/$(libft_NAME)
endif

clean_libft:
	$(RM) -r $(libft_SRC_DIR)/$(BUILD_DIR)



ifeq ($(suffix $(libft_NAME)),.a)
cleanout_libft:
	$(RM) $(LIB_DIR)/$(libft_NAME)
	@rmdir $(LIB_DIR) 2> /dev/null || true
else
cleanout_libft:
	$(RM) $(BIN_DIR)/$(libft_NAME)
	@rmdir $(BIN_DIR) 2> /dev/null || true
endif



fclean: clean_libft cleanout_libft

re: fclean all

depend: .depend


INCLUDE_DIR_LIST = -I $(libft_INCLUDE_DIR) ### TODO: ALL_INCLUDE_DIRS ?

.depend: $(libft_SRCS_FULL) ### TODO: ALL_SRCS ?
	@echo --- Create dependencies ---
	@$(RM) $@
	$(CC) $(INCLUDE_DIR_LIST) -MM $^ > $@ || $(RM) $@ 

-include .depend

.PHONY: objects depend clean_depend clean_libft cleanout_libft fclean
