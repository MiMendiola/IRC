CPP			= c++
CPPFLAGS	= -Wall -Wextra -Werror -std=c++98 -Iincludes
NAME		= IRC
SRC			= ./src/
OBJS_DIR	= ./objs/
FILES		= \
				$(SRC)Channel.cpp \
				$(SRC)Client.cpp \
				$(SRC)Parser.cpp \
				$(SRC)Server.cpp \
				$(SRC)Utils.cpp \
				$(SRC)Irc.cpp


OBJS = $(FILES:$(SRC)%.cpp=$(OBJS_DIR)%.o)

$(OBJS_DIR)%.o: $(SRC)%.cpp
	@echo "🔧Compiling $< 🔨"
	@$(CPP) $(CPPFLAGS) -c $< -o $@

all: mkdir_objs $(NAME)

mkdir_objs:
	@mkdir -p $(OBJS_DIR)

$(NAME): $(OBJS)
	@$(CPP) $(CPPFLAGS) $(OBJS) -o $(NAME)
	@echo "$(GREEN)Created $(NAME) ✓$(RESET)"

clean:
	@rm -rf $(OBJS)
	@echo "$(RED)Objects IRC Removed ✓$(RESET)"

fclean: clean 
	@rm -rf $(OBJS_DIR)
	@rm -f $(NAME)
	@echo "$(RED)$(NAME) Removed ✓$(RESET)"

re: fclean all


GREEN = \033[0;32m
YELLOW = \033[1;33m
RED = \033[0;31m
BLUE = \033[0;34m
RESET = \033[0m

.PHONY: all clean fclean re mkdir_objs
