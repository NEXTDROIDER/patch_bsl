#!/bin/bash

# --- НАСТРОЙКИ ---
APK_NAME="client.apk"
OUTPUT_APK="client_patched.apk"
TEMP_DIR="temp_apk"
CONFIG_PATH="$TEMP_DIR/lib/arm64-v8a/libBSL.c.so"
OLD_IP="127.0.0.1"
# Укажите путь к java. Если она в PATH, оставьте просто "java"
JAVA_EXEC="java" 
# -----------------

rm -f "$OUTPUT_APK"

echo "[1/4] Поиск локального IP-адреса ПК..."
PC_IP=""

# Определение IP для Linux (отбрасываем loopback)
if command -v ip &> /dev/null; then
    PC_IP=$(ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v '127.0.0.1' | head -n 1)
# Определение IP для macOS
elif command -v ifconfig &> /dev/null; then
    PC_IP=$(ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -n 1)
fi

if [ -z "$PC_IP" ]; then
    echo "[ОШИБКА] Не удалось автоматически определить IP-адрес ПК."
    read -p "Нажмите Enter для выхода..."
    exit 1
fi

echo "Ваш IP-адрес: $PC_IP"

if [ ! -f "$APK_NAME" ]; then
    echo "[ОШИБКА] Файл $APK_NAME не найден в текущей папке."
    read -p "Нажмите Enter для выхода..."
    exit 1
fi

if [ ! -f "apktool.jar" ]; then
    echo "[ОШИБКА] Утилита apktool.jar не найдена в текущей папке."
    read -p "Нажмите Enter для выхода..."
    exit 1
fi

echo "[2/4] Декомпиляция APK через Apktool (это может занять время)..."
if [ -d "$TEMP_DIR" ]; then
    rm -rf "$TEMP_DIR"
fi

"$JAVA_EXEC" -jar apktool.jar d "$APK_NAME" -o "$TEMP_DIR" --no-src

if [ ! -f "$CONFIG_PATH" ]; then
    echo "[ОШИБКА] Файл конфигурации не найден по пути: $CONFIG_PATH"
    rm -rf "$TEMP_DIR"
    read -p "Нажмите Enter для выхода..."
    exit 1
fi

echo "[3/4] Модификация IP-адреса на $PC_IP..."
# Используем sed для безопасной замены строки в файле
sed -i "s/$OLD_IP/$PC_IP/g" "$CONFIG_PATH"

echo "[4/4] Сборка модифицированного APK обратно..."
rm -f "$OUTPUT_APK"

"$JAVA_EXEC" -jar apktool.jar b "$TEMP_DIR" -o "$OUTPUT_APK"

echo "Очистка временных папок..."
rm -rf "$TEMP_DIR"

echo "==================================================="
echo "[УСПЕХ] Новый файл $OUTPUT_APK успешно создан!"
echo "IP изменен на $PC_IP"
echo "==================================================="

read -p "Нажмите Enter для завершения..."
