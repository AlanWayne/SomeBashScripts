#!/bin/bash

# Проверяем, что аргумент был передан
if [ $# -eq 0 ]; then
    echo "Usage: lower [filename]"
    exit 1
fi

# Получаем имя файла из аргументов
file=$1

# Проверяем, существует ли файл
if [ ! -f "$file" ]; then
    echo "There is no such file: $file"
    exit 1
fi

# Заменяем все символы верхнего регистра на нижний регистр
tr '[:upper:]' '[:lower:]' < "$file" > "${file}_lower"

# Перезаписываем исходный файл
mv "${file}_lower" "$file"

echo "Done."

