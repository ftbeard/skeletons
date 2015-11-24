
EXTRA_DIR ?= extra
LIB_DIR ?= lib
BIN_DIR ?= bin
BUILD_DIR ?= .build

INCLUDE_DIR ?= include
SRC_DIR ?= src

ARFLAGS = rcs



########### USER INFOS ######################

LIBS = a.out


libft_INCLUDE_DIRS = include include2
libft_SRC_DIR = src
libft_LIB_DIR = .
libft_BIN_DIR = .
libft_SRCS = main.c a.c 







libft_NAME = $(LIBS) ### TODO

libft_LIB_DIR ?= $(LIB_DIR)
libft_BIN_DIR ?= $(BIN_DIR)
libft_SRC_DIR ?= $(SRC_DIR)
libft_INCLUDE_DIRS ?= $(INCLUDE_DIR)

ifeq ($(suffix $(libft_NAME)),.a)
  LIBS_FULL += $(libft_LIB_DIR)/$(libft_NAME)
else
  LIBS_FULL += $(libft_BIN_DIR)/$(libft_NAME)
endif

libft_CFLAGS = $(addprefix -I ,$(libft_INCLUDE_DIRS))


########### Common.mk #######################

#LIBS_NAME = $(basename $(LIBS))
#LIBS_FULL = $(addprefix $(LIB_DIR)/,$(LIBS))


all: $(libft_SRC_DIR)/$(BUILD_DIR) $(LIBS_FULL)

$(LIB_DIR):
	@mkdir -p $(LIB_DIR)

$(BIN_DIR):
	@mkdir -p $(BIN_DIR)

	

libft_SRCS_FULL = $(addprefix $(libft_SRC_DIR)/,$(libft_SRCS))

libft_OBJS = $(libft_SRCS:.c=.o)
libft_OBJS_FULL = $(addprefix $(libft_SRC_DIR)/$(BUILD_DIR)/,$(libft_OBJS))


$(libft_SRC_DIR)/$(BUILD_DIR):
	@mkdir -p $(libft_SRC_DIR)/$(BUILD_DIR)



$(libft_SRC_DIR)/$(BUILD_DIR)/%.o: $(libft_SRC_DIR)/%.c
	$(CC) $(libft_CFLAGS) -c $< -o $@
	@$(CC) $(libft_CFLAGS) -MM -MT $@ $< >> .depend
	@sort -u .depend > .depend.tmp
	@mv .depend.tmp .depend


ifeq ($(suffix $(libft_NAME)),.a)
$(libft_LIB_DIR)/$(libft_NAME): $(libft_LIB_DIR) $(libft_OBJS_FULL)
	$(AR) $(ARFLAGS) $(libft_LIB_DIR)/$(libft_NAME) $(libft_OBJS_FULL)
else
$(libft_BIN_DIR)/$(libft_NAME): $(libft_BIN_DIR) $(libft_OBJS_FULL)
	$(CC) $(libft_OBJS_FULL) -o $(libft_BIN_DIR)/$(libft_NAME)
endif

clean_libft:
	@$(RM) -r $(libft_SRC_DIR)/$(BUILD_DIR)



ifeq ($(suffix $(libft_NAME)),.a)
cleanout_libft:
	@$(RM) $(libft_LIB_DIR)/$(libft_NAME)
	@rmdir $(libft_LIB_DIR) 2> /dev/null || true
else
cleanout_libft:
	@$(RM) $(libft_BIN_DIR)/$(libft_NAME)
	@rmdir $(libft_BIN_DIR) 2> /dev/null || true
endif

cleanout: cleanout_libft
clean: clean_libft
	@echo ---- CLEAN ----
	@$(RM) .depend

fclean: clean cleanout
	@echo ---- FULL CLEAN ----

re: fclean all


#.depend: $(libft_SRCS_FULL) ### TODO: ALL_SRCS ?
#	@echo --- Create dependencies ---
#	@$(RM) $@
#	@#echo -----------------------  ---
#	@echo ----------------------- $(join $(addsuffix .build/,$(dir $^)),$(notdir $(^:.c=.o))) ---
#	$(CC) $(INCLUDE_DIR_LIST) -MM -MT src/.build/main.o -MM -MT src/.build/a.o $^ > $@ || $(RM) $@ 

-include .depend


.PHONY: all depend clean_depend cleanout_libft fclean
