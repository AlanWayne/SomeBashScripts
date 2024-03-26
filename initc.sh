#!/bin/bash

# Проверяем, что аргумент передан
if [ -z "$1" ]; then
    echo "Usage: $0 <project_title>"
    exit 1
fi

# Преобразуем название проекта в нижний регистр
project_name=$(echo "$1" | tr '[:upper:]' '[:lower:]')

# Создаем директорию с названием проекта
mkdir -p "$1"

# Создаем файл main.c внутри директории проекта
touch "$1/main.c"

# Создаем файл .h с названием проекта в нижнем регистре
touch "$1/${project_name}.h"

# Создаем файл .clang-format внутри директории проекта
touch "$1/.clang-format"

# Добавляем текст в файл .clang-format
echo "---
BasedOnStyle: Google
UseTab: Always
IndentWidth: 4
TabWidth: 4
" > "$1/.clang-format"

# Создаем файл Makefile

touch "$1/Makefile"

# Добавляем текст в Makefile

echo "
CC = gcc
FLAGS = -Wall -Wextra -Werror
LIBS = -lm -lncurses
FILES = main.c
TITLE = $1

all: clang_format \$(TITLE)

\$(TITLE): \$(FILES)
	@\$(CC) \$(FILES) \$(LIBS) -o \$(TITLE)

with_flags: \$(FILES)
	@\$(CC) \$(FLAGS) \$(FILES) \$(LIBS) -o \$(TITLE)

clang_format:
	@clang-format -i --style=file:.clang-format \$(FILES)

leaks: rebuild
	@valgrind --leak-check=full --show-leak-kinds=all ./\$(TITLE) \$(FILES)

clean:
	@rm -rf \$(TITLE)

rebuild: clean all
" > "$1/Makefile"

echo "Project '$1' created."

