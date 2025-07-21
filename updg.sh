#!/data/data/com.termux/files/usr/bin/bash

# === ЦВЕТА ===
GREEN="\033[1;32m"
RED="\033[1;31m"
BLUE="\033[1;34m"
YELLOW="\033[1;33m"
RESET="\033[0m"

# === ФУНКЦИЯ РАМКИ ===
print_box() {
  echo -e "${BLUE}╔══════════════════════════════════════╗${RESET}"
  echo -e "${BLUE}║ ${YELLOW}$1${RESET}"
  echo -e "${BLUE}╚══════════════════════════════════════╝${RESET}"
}

# === ФУНКЦИЯ ОШИБКИ ===
print_error() {
  echo -e "${RED}╔══════════════════════════════════════╗"
  echo -e "║ ❌ ОШИБКА: $1"
  echo -e "╚══════════════════════════════════════╝${RESET}"
}

# === СТАРТ ===
clear
print_box "🚀 Запуск супер обновления Termux"

print_box "🔄 Обновление списка пакетов..."
if ! pkg update -y; then
  print_error "Не удалось обновить список пакетов"
  exit 1
fi

print_box "⬆️ Обновление установленных пакетов..."
if ! pkg upgrade -y; then
  print_error "Не удалось обновить пакеты"
  exit 1
fi

print_box "🧹 Удаление неиспользуемых пакетов..."
if ! apt autoremove -y; then
  print_error "Не удалось удалить неиспользуемые пакеты"
fi

print_box "🧼 Очистка кэша пакетов..."
if ! apt clean; then
  print_error "Ошибка при очистке кэша"
fi

print_box "🗑️ Удаление временных файлов и мусора..."
rm -rf ~/.cache/*
rm -rf /data/data/com.termux/cache/*
rm -rf /sdcard/.Trash/* 2>/dev/null

print_box "📊 Проверка использования памяти..."
df -h | grep -E '^(/|/data|/dev|/sdcard)' || print_error "Не удалось получить информацию о памяти"

print_box "🌐 Проверка подключения к интернету..."
ping -c 1 google.com > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo -e "${GREEN}✅ Интернет работает${RESET}"
else
  print_error "Нет подключения к интернету"
fi

print_box "📥 Совет: Обновляйте Termux вручную через F-Droid"
print_box "✅ Супер обновление завершено успешно!"

