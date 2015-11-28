###########################################
#### Meta.mk by trapcodien@hotmail.fr #####
###########################################


### USER FLAGS INTERACTIONS ####################################################
CFLAGS ?= -Wall -Wextra -Werror -std=c89 -pedantic 
CXXFLAGS ?= -Wall -Wextra -Werror -std=c++11
DEBUG_FLAGS ?= -g

VALGRIND_FLAGS ?= --dsymutil=yes --leak-check=full
VALGRIND := valgrind $(VALGRIND_FLAGS)

EXTRA_DIR ?= .
LIB_DIR ?= lib
BIN_DIR ?= bin
BUILD_DIR ?= .build
CLEAN_LIB ?= 1
VERBOSE ?= 0
EXPOSED_PORTS := $(foreach x,$(EXPOSED_PORTS),-p $(x):$(x))

INCLUDE_DIR ?= include
SRC_DIR ?= src

ARFLAGS = rcs

SHARED_DIR ?= /Users/Shared
REMOTE_DIR ?= /home/garm/dev
USER ?= default

ifeq ($(DEBUG),1)
  PRE_EXEC ?= $(VALGRIND)
  DEBUG_MSG ?= (with $(DEBUG_FLAGS)) 
endif

ifeq ($(VERBOSE),0)
  V := @
endif
################################################################################

COLOR_RESET = \033[0m
COLOR_CLEAN = \033[43m\033[31m
COLOR_COMPILATION = \033[33m
COLOR_CREATION = \033[32m

################################################################################
define generateVariables
  $$(foreach x,$$($(1)_LIBS),$$(eval $(1)_$$(x)_INCS ?= $$(INCLUDE_DIR)))
  $$(foreach x,$$($(1)_LIBS),$$(eval $(1)_$$(x)_LIB_DIR ?= $$(LIB_DIR)))
  $$(foreach x,$$($(1)_LIBS),$$(eval $(1)_$$(x)_DIR ?= $$(EXTRA_DIR)/$$(x)))
  $$(foreach x,$$($(1)_LIBS),$$(eval $(1)_$$(x)_NAME ?= $$(x).a))
  

  $(1)_LANGUAGE ?= c
  
  
  $(1)_LDLIBS ?= $$(LDLIBS)
  $(1)_LDFLAGS ?= $$(LDFLAGS)
  $(1)_CFLAGS ?= $$(CFLAGS)
  $(1)_CXXFLAGS ?= $$(CXXFLAGS)

ifeq ($(DEBUG),1)
  $(1)_CFLAGS += $(DEBUG_FLAGS)
  $(1)_CXXFLAGS += $(DEBUG_FLAGS)
endif

  $(1)_ARGS ?= $$(ARGS)
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
  
  $(1)_INCS := $$(addprefix -I ,$$($(1)_INCS))

  $(1)_LDFLAGS += $$(foreach elem,$$($(1)_LIBS),-L $$($(1)_$$(elem)_DIR)/$$($(1)_$$(elem)_LIB_DIR))
  $(1)_LDLIBS += $$(foreach elem,$$($(1)_LIBS),$$(subst lib,-l,$$(elem)))

  $(1)_LIBS_FULL = $$(foreach elem,$$($(1)_LIBS),$$($(1)_$$(elem)_DIR)/$$($(1)_$$(elem)_LIB_DIR)/$$($(1)_$$(elem)_NAME))
endef

################################################################################
define autoCallVariables
  ifeq ($$(suffix $(1)),.a)
    $$(eval $$(call generateVariables,$$(basename $(1)),$(1)))
  else
    $$(eval $$(call generateVariables,$(1),$(1)))
  endif
endef

$(foreach x,$(OUTPUTS),$(eval $(call autoCallVariables,$(x))))

################################################################################
all: $(OUTPUTS_FULL) ###########################################################
################################################################################

define makeLib
  ifeq ($$(filter $$($(1)_$(2)_NAME),$$(OUTPUTS)),) 
    ifeq ($$(shell pwd),$$(realpath $$($(1)_$(2)_DIR)))
      $$(error Error: Maybe you forgotten $$($(1)_$(2)_NAME) in OUTPUTS var)
    endif
    TEMP := $$($(1)_$(2)_DIR)/$$($(1)_$(2)_LIB_DIR)/$$($(1)_$(2)_NAME)
	ifeq ($$(filter $$(TEMP),$$(RULE_ACCUMULATOR)),)
      $$(TEMP):
		@make -C $$($(1)_$(2)_DIR) $$($(1)_$(2)_LIB_DIR)/$$($(1)_$(2)_NAME) DEBUG=$$(DEBUG)
      RULE_ACCUMULATOR += $$($(1)_$(2)_DIR)/$$($(1)_$(2)_LIB_DIR)/$$($(1)_$(2)_NAME)
    endif
  endif
endef

define cleanLib
  ifeq ($$(filter $$($(1)_$(2)_NAME),$$(OUTPUTS)),) 
    ifeq ($$(shell pwd),$$(realpath $$($(1)_$(2)_DIR)))
      $$(error Error: Maybe you forgotten $$($(1)_$(2)_NAME) in OUTPUTS var)
    endif
    ifeq ($$(filter clean_$$($(1)_$(2)_DIR),$$(RULE_ACCUMULATOR)),)
	  ifneq ($$(CLEAN_LIB),0)
        clean_$(1)_$(2):
			@make -C $$($(1)_$(2)_DIR) clean
        .PHONY += clean_$(1)_$(2)
        CLEAN_FULL += clean_$(1)_$(2)
        RULE_ACCUMULATOR += clean_$$($(1)_$(2)_DIR)
	  endif
    endif
  endif
endef

define cleanoutLib
  ifeq ($$(filter $$($(1)_$(2)_NAME),$$(OUTPUTS)),) 
    ifeq ($$(shell pwd),$$(realpath $$($(1)_$(2)_DIR)))
      $$(error Error: Maybe you forgotten $$($(1)_$(2)_NAME) in OUTPUTS var)
    endif
    ifeq ($$(filter cleanout_$$($(1)_$(2)_DIR),$$(RULE_ACCUMULATOR)),)
	  ifneq ($$(CLEAN_LIB),0)
        cleanout_$(1)_$(2):
			@make -C $$($(1)_$(2)_DIR) cleanout
        .PHONY += cleanout_$(1)_$(2)
        CLEANOUT_FULL += cleanout_$(1)_$(2)
        RULE_ACCUMULATOR += cleanout_$$($(1)_$(2)_DIR)
	  endif
    endif
  endif
endef

################################################################################

define generateRules
  $(1)_SRCS_FULL = $$(addprefix $$($(1)_SRC_DIR)/,$$($(1)_SRCS))

  $(1)_OBJS = $$($(1)_SRCS:.$$($(1)_LANGUAGE)=.o)
  $(1)_OBJS_FULL = $$(addprefix $$($(1)_SRC_DIR)/$$(BUILD_DIR)/,$$($(1)_OBJS))

  $$($(1)_SRC_DIR)/$$(BUILD_DIR)/%.o: $$($(1)_SRC_DIR)/%.$$($(1)_LANGUAGE)
		@mkdir -p $$($(1)_SRC_DIR)/$$(BUILD_DIR)

ifeq ($$($(1)_LANGUAGE),c)
    ifeq ($$(VERBOSE),1)
		$$(CC) $$($(1)_CFLAGS) $$($(1)_INCS) -c $$< -o $$@
    else
		@$$(CC) $$($(1)_CFLAGS) $$($(1)_INCS) -c $$< -o $$@
		@echo "$$(COLOR_COMPILATION)[ $(1) COMPILATION $$(DEBUG_MSG)]$$(COLOR_RESET) - $$(notdir $$<)"
    endif
		@$$(CC) $$($(1)_CFLAGS) $$($(1)_INCS) -MM -MT $$@ $$< >> .depend
endif
ifeq ($$($(1)_LANGUAGE),cpp)
    ifeq ($$(VERBOSE),1)
		$$(CXX) $$($(1)_CXXFLAGS) -c $$< -o $$@
    else
		@$$(CXX) $$($(1)_CXXFLAGS) -c $$< -o $$@
		@echo "$$(COLOR_COMPILATION)[ $(1) COMPILATION $$(DEBUG_MSG)]$$(COLOR_RESET) - $$<"
    endif
		@$$(CXX) $$($(1)_CXXFLAGS) -MM -MT $$@ $$< >> .depend
endif

	@#sort -u .depend > .depend.tmp
	@#mv .depend.tmp .depend


  ifeq ($$(suffix $$($(1)_NAME)),.a)
    ./$$($(1)_LIB_DIR)/$$($(1)_NAME): $$($(1)_OBJS_FULL)
		@mkdir -p $$($(1)_LIB_DIR)
        ifeq ($$(VERBOSE),1)
		  $$(AR) $$(ARFLAGS) ./$$($(1)_LIB_DIR)/$$($(1)_NAME) $$($(1)_OBJS_FULL)
        else
		  @$$(AR) $$(ARFLAGS) ./$$($(1)_LIB_DIR)/$$($(1)_NAME) $$($(1)_OBJS_FULL)
		  @echo "$$(COLOR_CREATION)[CREATE LIBRARY]$$(COLOR_RESET) - $$@"
        endif
  else
    ./$$($(1)_BIN_DIR)/$$($(1)_NAME): $$($(1)_OBJS_FULL) $$($(1)_LIBS_FULL)
		@mkdir -p $$($(1)_BIN_DIR)
ifeq ($$($(1)_LANGUAGE),c)
        ifeq ($$(VERBOSE),1)
		  $$(CC) $$($(1)_OBJS_FULL) $$($(1)_LDFLAGS) $$($(1)_CFLAGS) $$($(1)_INCS) $$($(1)_LDLIBS) -o ./$$($(1)_BIN_DIR)/$$($(1)_NAME)
        else
		  @$$(CC) $$($(1)_OBJS_FULL) $$($(1)_LDFLAGS) $$($(1)_CFLAGS) $$($(1)_INCS) $$($(1)_LDLIBS) -o ./$$($(1)_BIN_DIR)/$$($(1)_NAME)
		  @echo "$$(COLOR_CREATION)[CREATE BINARY]$$(COLOR_RESET) - $$@"
        endif
endif
ifeq ($$($(1)_LANGUAGE),cpp)
    ifeq ($$(VERBOSE),1)
		$$(CXX) $$($(1)_OBJS_FULL) $$($(1)_LDFLAGS) $$($(1)_CXXFLAGS) $$($(1)_INCS) $$($(1)_LDLIBS) -o ./$$($(1)_BIN_DIR)/$$($(1)_NAME)
    else
		@$$(CXX) $$($(1)_OBJS_FULL) $$($(1)_LDFLAGS) $$($(1)_CXXFLAGS) $$($(1)_INCS) $$($(1)_LDLIBS) -o ./$$($(1)_BIN_DIR)/$$($(1)_NAME)
		@echo "$$(COLOR_CREATION)[CREATE BINARY]$$(COLOR_RESET) - $$@"
    endif
endif

    $$(foreach x,$$($(1)_LIBS),$$(eval $$(call makeLib,$(1),$$(x))))
    $$(foreach x,$$($(1)_LIBS),$$(eval $$(call cleanLib,$(1),$$(x))))
    $$(foreach x,$$($(1)_LIBS),$$(eval $$(call cleanoutLib,$(1),$$(x))))
  endif

  clean_$(1):
	@echo "$$(COLOR_CLEAN)[CLEAN OBJECTS]$$(COLOR_RESET) $$($(1)_NAME)"
	@$$(RM) -r $$($(1)_SRC_DIR)/$$(BUILD_DIR)

ifeq ($$(suffix $($(1)_NAME)),.a)
  cleanout_$(1):
	@echo "$$(COLOR_CLEAN)[CLEAN]$$(COLOR_RESET) $$($(1)_NAME)"
	@$$(RM) $$($(1)_LIB_DIR)/$$($(1)_NAME)
	@rmdir ./$$($(1)_LIB_DIR) 2> /dev/null || true
else
  cleanout_$(1):
	@echo "$$(COLOR_CLEAN)[CLEAN]$$(COLOR_RESET) $$($(1)_NAME)"
	@$$(RM) ./$$($(1)_BIN_DIR)/$$($(1)_NAME)
	@$$(RM) -r ./$$($(1)_BIN_DIR)/$$($(1)_NAME).dSYM
	@rmdir $$($(1)_BIN_DIR) 2> /dev/null || true

  ifeq ($(IMAGE_TEST),)
  test_$(1): ./$$($(1)_BIN_DIR)/$$($(1)_NAME)
		@$$(PRE_EXEC) $$($(1)_BIN_DIR)/$$($(1)_NAME) $$($(1)_ARGS)
  else
  test_$(1): fclean init_shared
		$$(V)docker run $(EXPOSED_PORTS) -itv $(SHARED_DIR)/$(USER):$(REMOTE_DIR) dev make test_$(1) DEBUG=$$(DEBUG) $(1)_ARGS=$$($(1)_ARGS)
  endif

  .PHONY += test_$(1)

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
	@$(RM) .depend

fclean: clean cleanout

re: fclean all

docker: fclean init_shared
	@docker run $(EXPOSED_PORTS) -itv $(SHARED_DIR)/$(USER):$(REMOTE_DIR) dev

init_shared:
	@echo Initialize $(SHARED_DIR)/$(USER)
	@$(RM) -r $(SHARED_DIR)/$(USER)
	@cp -R . $(SHARED_DIR)/$(USER)

################################################################################

-include .depend
.PHONY: all re cleanout clean fclean docker init_shared $(.PHONY)


