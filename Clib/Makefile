
NAME = libft libft2


libft_SRC_DIR = src
libft_INCLUDE_DIR = include
libft_SRCS = aaa.c bbb.c
#libft_INCLUDES = libft.h

libft2_SRC_DIR = src
libft2_INCLUDE_DIR = include
libft2_SRCS = ccc.c ddd.c
#libft2_INCLUDES = libft2.h

EXTRA_DIR = extra
LIB_DIR = lib
BIN_DIR = bin

TEST ?= main

BUILD_DIR = .build

NAME_PATH_TMP = $(addsuffix .a,$(NAME))
NAME_PATH = $(addprefix $(LIB_DIR)/,$(NAME_PATH_TMP))

LDLIBS = $(subst lib,-l,$(NAME))
LDFLAGS = -L $(LIB_DIR)
CFLAGS += -Wall -Wextra -std=c89 -ansi
CFLAGS += $(foreach x,$(NAME),-I $($(x)_INCLUDE_DIR))

all: $(NAME_PATH)

$(foreach x,$(NAME),$(eval $(x)_OBJS = $(addprefix $(BUILD_DIR)/$(x)/,$($(x)_SRCS:.c=.o))))
$(foreach x,$(NAME),$(eval $(x)_INCLUDES = $(addprefix $($(x)_INCLUDE_DIR)/,$($(x)_INCLUDES))))
#$(foreach x,$(NAME),$(eval $(x)_SRCS = $(addprefix $($(x)_SRC_DIR)/$(x)/,$($(x)_SRCS))))

#SRC_DIRS = $(foreach x,$(NAME),$($(x)_SRC_DIR))
#INC_DIRS = $(foreach x,$(NAME),$($(x)_INCLUDE_DIR))
#OBJ_DIRS = $(foreach x,$(NAME),build/$($(x)_OBJ_DIR))

lol:
	@echo $(CFLAGS)

ifneq ($(LIB_DIR),.)
$(LIB_DIR):
	@mkdir -p $(LIB_DIR)
endif

ifneq ($(BIN_DIR),.)
$(BIN_DIR):
	@mkdir -p $(BIN_DIR)
endif
# 1 : objdir
# 2 : srcdir
# 3 : dep lists
define CC_TEMPLATE
$(1):
	@mkdir -p $(1)
$(1)/%.o: $(2)/%.c $(3) $(1)
	$(CC) -c $$< -o $$@ $(CFLAGS)
endef
$(foreach x,$(NAME),$(eval $(call CC_TEMPLATE,$(BUILD_DIR)/$(x),$($(x)_SRC_DIR),$($(x)_INCLUDES))))

define AR_TEMPLATE
$(LIB_DIR)/$(1).a: $($(1)_OBJS) $(LIB_DIR)
	@echo Creating $(1)
	$(AR) rcs $(LIB_DIR)/$(1).a $($(1)_OBJS)
endef
$(foreach x,$(NAME),$(eval $(call AR_TEMPLATE,$(x))))



clean:
	@echo Clean $(BUILD_DIR) folder
	@$(RM) -r $(foreach x,$(NAME),$(addprefix $(BUILD_DIR)/,$(x)))

cleanlib:
	@$(RM) -r $(NAME_PATH)
	@$(RM) $(BIN_DIR)/$(TEST)
	@rmdir $(LIB_DIR) 2> /dev/null || true
	@rmdir $(BUILD_DIR) 2> /dev/null || true
	@$(RM) -r $(BIN_DIR) 2> /dev/null || true

fclean: clean cleanlib
	@echo Full clean OK.

re: fclean all

test: all $(BIN_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) $(LDLIBS) $(EXTRA_DIR)/$(TEST).c -o $(BIN_DIR)/$(TEST)

.PHONY: clean fclean re all test
