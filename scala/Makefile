################################################################################
##  SCALA Makefile                                                            ##
################################################################################

NAME = alpha_test

SOURCE_DIR = 	source
SOURCE_FILES =	HelloWorld.scala

BUILD_DIR =	build
CLASS_FILES = 	$(addprefix $(BUILD_DIR)/, $(SOURCE_FILES:.scala=.class))

################################################################################
SCALA_HOME =	/usr/local/opt/scala
################################################################################

$(BUILD_DIR)/%.class: $(SOURCE_DIR)/%.scala
	@mkdir $(BUILD_DIR)
	scalac -sourcepath $(SOURCE_DIR) -d $(BUILD_DIR) $<

all: $(CLASS_FILES)
	@echo "> Compiling sources and creating jar archive : $(NAME).jar"
	@cd $(BUILD_DIR) && jar -cfm ../$(NAME).jar ../MANIFEST.MF *.* && cd .. && echo "Archive OK"

clean:
	@echo "Removing $(BUILD_DIR) folder"
	@rm -rf $(BUILD_DIR)

fclean: clean
	@echo "Removing $(NAME).jar"
	@rm -rf $(NAME).jar

re: fclean all

run:
	@echo "> java -jar $(NAME).jar"
	@java -jar $(NAME).jar

test: re run

.SILENT:
