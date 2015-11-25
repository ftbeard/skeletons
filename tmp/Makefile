###########################################
#### Meta.mk by trapcodien@hotmail.fr #####
###########################################


### USER INFOS #################################################################
OUTPUTS = a.out libft.a


a.out_SRC_DIR = src
a.out_INCS = include include2
a.out_SRCS = main.c a.c 

a.out_LIBS =


libft_SRC_DIR = src
libft_INCS = include include2
libft_SRCS = main.c a.c 
################################################################################



### USER FLAGS INTERACTIONS ####################################################
CFLAGS ?= -Wall -Wextra -std=c89 -pedantic 

EXTRA_DIR ?= extra
LIB_DIR ?= lib
BIN_DIR ?= bin
BUILD_DIR ?= .build

INCLUDE_DIR ?= include
SRC_DIR ?= src

ARFLAGS = rcs
################################################################################





################################################################################
define generateVariables
  $$(foreach x,$$($(1)_LIBS),$$(eval $(1)_$$(x)_INCS ?= $$(INCLUDE_DIR)))
  $$(foreach x,$$($(1)_LIBS),$$(eval $(1)_$$(x)_LIB_DIR ?= $$(LIB_DIR)))
  $$(foreach x,$$($(1)_LIBS),$$(eval $(1)_$$(x)_DIR ?= $$(x)))
  
  
  
  $(1)_LDFLAGS ?= $$(LDFLAGS) $$(CFLAGS)
  $(1)_LDLIBS ?= $$(LDLIBS)
  $(1)_CFLAGS ?= $$(CFLAGS)
  
  
  $(1)_NAME = $(2)
  
  
  $(1)_LIB_DIR ?= $$(LIB_DIR)
  $(1)_BIN_DIR ?= $$(BIN_DIR)
  
  $(1)_SRC_DIR ?= $$(SRC_DIR)
  $(1)_INCS ?= $$(INCLUDE_DIR)
  
  $$(foreach x,$$($(1)_LIBS),$$(eval $(1)_INCS += $$(addprefix $$($(1)_$$(x)_DIR)/,$$($(1)_$$(x)_INCS))))
  
  
  
  ifeq ($$(suffix $$($(1)_NAME)),.a)
    OUTPUTS_FULL += ./$$($(1)_LIB_DIR)/$$($(1)_NAME)
  else
    OUTPUTS_FULL += ./$$($(1)_BIN_DIR)/$$($(1)_NAME)
  endif
  
  $(1)_CFLAGS += $$(addprefix -I ,$$($(1)_INCS))
  
  DIRS_TO_MAKE += $$($(1)_SRC_DIR)/$$(BUILD_DIR)
  ifeq ($$(suffix $$($(1)_NAME)),.a)
    DIRS_TO_MAKE += $$($(1)_LIB_DIR)
  else
    DIRS_TO_MAKE += $$($(1)_BIN_DIR)
  endif

endef


define autoCallVariables
  ifeq ($$(suffix $(1)),.a)
    $$(eval $$(call generateVariables,$$(basename $(1)),$(1)))
  else
    $$(eval $$(call generateVariables,$(1),$(1)))
  endif
endef

$(foreach x,$(OUTPUTS),$(eval $(call autoCallVariables,$(x))))
################################################################################


### set a.out_LDFLAGS (libft, etc...) (+=)         LDFLAGS += foreach(x, libs, -L 1_x_LIB_DIR)
### set a.out_LDLIBS (libft, etc...) (+=)         LDLIBS += foreach(x, libs, -l$(subst lib,-l,x))

## set libft/lib/libft.a rule (make)               1_x_DIR/1_x_LIB_DIR/x.a :           =>         @make -C 1_x_DIR 1_x_LIB/x.a
## set variable :  a.out_LIBS_FULL = libft/lib/libft.a libtest/lib/libtest.a

## 1_LIBS_FULL += foreach => 1_x_DIR/1_x_LIB_DIR/x.a  




########### Common.mk #######################

#OUTPUTS_NAME = $(basename $(OUTPUTS))
#OUTPUTS_FULL = $(addprefix $(LIB_DIR)/,$(OUTPUTS))




################################################################################
DIRS_TO_MAKE := $(sort $(DIRS_TO_MAKE))

################################################################################
all: $(DIRS_TO_MAKE) $(OUTPUTS_FULL) ###############################################
################################################################################

$(DIRS_TO_MAKE):
	@mkdir -p $(@)
################################################################################

define generateRules
  $(1)_SRCS_FULL = $$(addprefix $$($(1)_SRC_DIR)/,$$($(1)_SRCS))

  $(1)_OBJS = $$($(1)_SRCS:.c=.o)
  $(1)_OBJS_FULL = $$(addprefix $$($(1)_SRC_DIR)/$$(BUILD_DIR)/,$$($(1)_OBJS))

  $$($(1)_SRC_DIR)/$$(BUILD_DIR)/%.o: $$($(1)_SRC_DIR)/%.c
	$$(CC) $$($(1)_CFLAGS) -c $$< -o $$@
	@$$(CC) $$($(1)_CFLAGS) -MM -MT $$@ $$< >> .depend
	@sort -u .depend > .depend.tmp
	@mv .depend.tmp .depend


  ifeq ($$(suffix $$($(1)_NAME)),.a)
    ./$$($(1)_LIB_DIR)/$$($(1)_NAME): $$($(1)_OBJS_FULL)
		$$(AR) $$(ARFLAGS) ./$$($(1)_LIB_DIR)/$$($(1)_NAME) $$($(1)_OBJS_FULL)
  else
    ./$$($(1)_BIN_DIR)/$$($(1)_NAME): $$($(1)_OBJS_FULL) $$($(1)_LIBS_FULL)
		$$(CC) $$($(1)_LDFLAGS) $$($(1)_LDLIBS) $$($(1)_OBJS_FULL) -o ./$$($(1)_BIN_DIR)/$$($(1)_NAME)
  endif


  clean_$(1):
	@$$(RM) -r $$($(1)_SRC_DIR)/$$(BUILD_DIR)

ifeq ($$(suffix $($(1)_NAME)),.a)
  cleanout_$(1):
	@$$(RM) $$($(1)_LIB_DIR)/$$($(1)_NAME)
	@rmdir ./$$($(1)_LIB_DIR) 2> /dev/null || true
else
  cleanout_$(1):
	@$$(RM) ./$$($(1)_BIN_DIR)/$$($(1)_NAME)
	@rmdir $$($(1)_BIN_DIR) 2> /dev/null || true
endif

  .PHONY += clean_$(1) cleanout_$(1)

  CLEANOUT_FULL += cleanout_$(1)
  CLEAN_FULL += clean_$(1)
endef

################################################################################
define autoCallRules
  ifeq ($$(suffix $(1)),.a)
    $$(eval $$(call generateRules,$$(basename $(1))))
  else
    $$(eval $$(call generateRules,$(1)))
  endif
endef

$(foreach x,$(OUTPUTS),$(eval $(call autoCallRules,$(x))))
################################################################################


cleanout: $(CLEANOUT_FULL)
clean: $(CLEAN_FULL)
	@echo ---- CLEAN ----
	@$(RM) .depend

fclean: clean cleanout
	@echo ---- FULL CLEAN ----

re: fclean all

################################################################################

-include .depend
.PHONY: all re cleanout clean fclean $(.PHONY)

