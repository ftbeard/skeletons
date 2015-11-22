
NAMES = libft libft2

libft_SRCS = aaa.c bbb.c
libft_INCLUDES = libft.h

libft2_SRCS = ccc.c ddd.c
libft2_INCLUDES = libft2.h




EXTRA_DIR = extra
TESTS = main main2
main_TEST_SRCS = main.c
main2_TEST_SRCS = main.c




EXTRA_DIR ?= .
LIB_DIR ?= lib
BIN_DIR ?= bin

BUILD_DIR = .build


$(foreach x,$(TESTS),$(eval $(x)_TEST_DIR ?= $(EXTRA_DIR)))

$(foreach x,$(NAMES),$(eval $(x)_SRC_DIR ?= src))
$(foreach x,$(NAMES),$(eval $(x)_INCLUDE_DIR ?= include))


NAMES_PATH_TMP = $(addsuffix .a,$(NAMES))
NAMES_PATH = $(addprefix $(LIB_DIR)/,$(NAMES_PATH_TMP))

LDLIBS = $(subst lib,-l,$(NAMES))
LDFLAGS = -L $(LIB_DIR)
CFLAGS += -Wall -Wextra -std=c89 -ansi
CFLAGS += $(foreach x,$(NAMES),-I $($(x)_INCLUDE_DIR))

all: $(NAMES_PATH)

$(foreach x,$(NAMES),$(eval $(x)_OBJS = $(addprefix $(BUILD_DIR)/$(x)/,$($(x)_SRCS:.c=.o))))
$(foreach x,$(NAMES),$(eval $(x)_INCLUDES = $(addprefix $($(x)_INCLUDE_DIR)/,$($(x)_INCLUDES))))


ifneq ($(LIB_DIR),.)
$(LIB_DIR):
	@mkdir -p $(LIB_DIR)
endif

ifneq ($(BIN_DIR),.)
$(BIN_DIR):
	@mkdir -p $(BIN_DIR)
endif


define LIB_CC_TEMPLATE
$(1):
	@mkdir -p $(1)
$(1)/%.o: $(2)/%.c $(3) $(1)
	$(CC) -c $$< -o $$@ $(CFLAGS)
endef
$(foreach x,$(NAMES),$(eval $(call LIB_CC_TEMPLATE,$(BUILD_DIR)/$(x),$($(x)_SRC_DIR),$($(x)_INCLUDES))))

define LIB_AR_TEMPLATE
$(LIB_DIR)/$(1).a: $($(1)_OBJS) $(LIB_DIR)
	@echo Creating $(1)
	$(AR) rcs $(LIB_DIR)/$(1).a $($(1)_OBJS)
endef
$(foreach x,$(NAMES),$(eval $(call LIB_AR_TEMPLATE,$(x))))



define TEST_TEMPLATE
.PHONY += test_$(1)
test_$(1): all $(BIN_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) $(LDLIBS) $(addprefix $($(1)_TEST_DIR)/,$(2)) -o $(BIN_DIR)/$(1)
endef
$(foreach x,$(TESTS),$(eval $(call TEST_TEMPLATE,$(x),$($(x)_TEST_SRCS))))



clean:
	@echo Clean $(BUILD_DIR) folder
	@$(RM) -r $(foreach x,$(NAMES),$(addprefix $(BUILD_DIR)/,$(x)))

cleanlib:
	@$(RM) -r $(NAMES_PATH)
	@$(RM) $(addprefix $(BIN_DIR)/,$(TESTS))
	@rmdir $(LIB_DIR) 2> /dev/null || true
	@rmdir $(BUILD_DIR) 2> /dev/null || true
	@rmdir $(BIN_DIR) 2> /dev/null || true

fclean: clean cleanlib
	@echo Full clean OK.

re: fclean all

refresh: all fclean

#test: all $(BIN_DIR)
#	$(CC) $(CFLAGS) $(LDFLAGS) $(LDLIBS) $(EXTRA_DIR)/$(TEST).c -o $(BIN_DIR)/$(TEST)

.PHONY: clean fclean re all refresh
