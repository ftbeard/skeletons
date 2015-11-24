###########################################
### Generic.mk by trapcodien@hotmail.fr ###
###########################################

CFLAGS = -Wall -Wextra

EXTRA_DIR ?= extra
LIB_DIR ?= lib
BIN_DIR ?= bin
BUILD_DIR ?= .build

INCLUDE_DIR ?= include
SRC_DIR ?= src

ARFLAGS = rcs



########### USER INFOS ######################

OUT = a.out


a.out_INCLUDE_DIRS = include include2
a.out_SRC_DIR = src
a.out_LIB_DIR = .
a.out_BIN_DIR = .
a.out_SRCS = main.c a.c 


a.out_LIBS = libft

$(foreach x,$(a.out_LIBS),$(eval a.out_$(x)_INCLUDE_DIRS ?= $(INCLUDE_DIR)))
$(foreach x,$(a.out_LIBS),$(eval a.out_$(x)_LIB_DIR ?= $(LIB_DIR)))
$(foreach x,$(a.out_LIBS),$(eval a.out_$(x)_DIR ?= $(x)))



a.out_LDFLAGS ?= $(LDFLAGS)
a.out_LDLIBS ?= $(LDLIBS)

### set a.out_LDFLAGS (libft, etc...) (+=)
### set a.out_LDLIBS (libft, etc...) (+=)

## set libft/lib/libft.a rule (make)
## set variable :  a.out_LIBS_FULL = libft/lib/libft.a libtest/lib/libtest.a


a.out_NAME = $(OUT) ### TODO

a.out_LIB_DIR ?= $(LIB_DIR)
a.out_BIN_DIR ?= $(BIN_DIR)
a.out_SRC_DIR ?= $(SRC_DIR)
a.out_INCLUDE_DIRS ?= $(INCLUDE_DIR)

$(foreach x,$(a.out_LIBS),$(eval a.out_INCLUDE_DIRS += $(addprefix $(a.out_$(x)_DIR)/,$(a.out_$(x)_INCLUDE_DIRS))))



ifeq ($(suffix $(a.out_NAME)),.a)
  OUT_FULL += $(a.out_LIB_DIR)/$(a.out_NAME)
else
  OUT_FULL += $(a.out_BIN_DIR)/$(a.out_NAME)
  a.out_OUT := ## Why ?  
endif

a.out_CFLAGS += $(addprefix -I ,$(a.out_INCLUDE_DIRS))
a.out_CFLAGS += $(CFLAGS)


########### Common.mk #######################

#OUT_NAME = $(basename $(OUT))
#OUT_FULL = $(addprefix $(LIB_DIR)/,$(OUT))


all: $(a.out_SRC_DIR)/$(BUILD_DIR) $(OUT_FULL)

$(LIB_DIR):
	@mkdir -p $(LIB_DIR)

$(BIN_DIR):
	@mkdir -p $(BIN_DIR)



#./libft/lib/libft.a:
#	@make -C libft lib/libft.a



a.out_SRCS_FULL = $(addprefix $(a.out_SRC_DIR)/,$(a.out_SRCS))

a.out_OBJS = $(a.out_SRCS:.c=.o)
a.out_OBJS_FULL = $(addprefix $(a.out_SRC_DIR)/$(BUILD_DIR)/,$(a.out_OBJS))


$(a.out_SRC_DIR)/$(BUILD_DIR):
	@mkdir -p $(a.out_SRC_DIR)/$(BUILD_DIR)



$(a.out_SRC_DIR)/$(BUILD_DIR)/%.o: $(a.out_SRC_DIR)/%.c
	$(CC) $(a.out_CFLAGS) -c $< -o $@
	@$(CC) $(a.out_CFLAGS) -MM -MT $@ $< >> .depend
	@sort -u .depend > .depend.tmp
	@mv .depend.tmp .depend


ifeq ($(suffix $(a.out_NAME)),.a)
$(a.out_LIB_DIR)/$(a.out_NAME): $(a.out_LIB_DIR) $(a.out_OBJS_FULL)
	$(AR) $(ARFLAGS) $(a.out_LIB_DIR)/$(a.out_NAME) $(a.out_OBJS_FULL)
else
$(a.out_BIN_DIR)/$(a.out_NAME): $(a.out_BIN_DIR) $(a.out_OBJS_FULL) $(a.out_LIBS_FULL)
	$(CC) $(CFLAGS) $(a.out_LDFLAGS) $(a.out_LDLIBS) $(a.out_OBJS_FULL) -o $(a.out_BIN_DIR)/$(a.out_NAME)
endif



clean_a.out:
	@$(RM) -r $(a.out_SRC_DIR)/$(BUILD_DIR)

ifeq ($(suffix $(a.out_NAME)),.a)
cleanout_a.out:
	@$(RM) $(a.out_LIB_DIR)/$(a.out_NAME)
	@rmdir $(a.out_LIB_DIR) 2> /dev/null || true
else
cleanout_a.out:
	@$(RM) $(a.out_BIN_DIR)/$(a.out_NAME)
	@rmdir $(a.out_BIN_DIR) 2> /dev/null || true
endif

.PHONY += clean_a.out cleanout_a.out


cleanout: cleanout_a.out
clean: clean_a.out
	@echo ---- CLEAN ----
	@$(RM) .depend

fclean: clean cleanout
	@echo ---- FULL CLEAN ----

re: fclean all


#.depend: $(a.out_SRCS_FULL) ### TODO: ALL_SRCS ?
#	@echo --- Create dependencies ---
#	@$(RM) $@
#	@#echo -----------------------  ---
#	@echo ----------------------- $(join $(addsuffix .build/,$(dir $^)),$(notdir $(^:.c=.o))) ---
#	$(CC) $(INCLUDE_DIR_LIST) -MM -MT src/.build/main.o -MM -MT src/.build/a.o $^ > $@ || $(RM) $@ 

-include .depend


.PHONY: all re clean fclean $(.PHONY)
