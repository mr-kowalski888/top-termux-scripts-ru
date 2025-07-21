#!/data/data/com.termux/files/usr/bin/bash

# === ЦВЕТА ДЛЯ ВЫВОДА ===
GREEN="\033[1;32m"
RED="\033[1;31m"
BLUE="\033[1;34m"
YELLOW="\033[1;33m"
RESET="\033[0m"

# === ФУНКЦИЯ: Оформление рамкой ===
frame() {
  echo -e "${BLUE}╔════════════════════════════════════════════╗${RESET}"
  echo -e "${BLUE}║ ${YELLOW}$1${RESET}"
  echo -e "${BLUE}╚════════════════════════════════════════════╝${RESET}"
}

# === ФУНКЦИЯ: Сообщение об ошибке ===
error() {
  echo -e "${RED}╔════════════════════════════════════════════╗"
  echo -e "║ ❌ ОШИБКА: $1"
  echo -e "╚════════════════════════════════════════════╝${RESET}"
}

# === НАЧАЛО РАБОТЫ ===
clear
frame "🧹 Запуск полной очистки Termux"

# === 1. Очистка кэша APT ===
frame "🧼 Очистка кэша пакетов APT..."
if ! apt clean; then
  error "Не удалось очистить apt-кэш"
fi

# === 2. Удаление неиспользуемых пакетов ===
frame "🗑️ Удаление неиспользуемых пакетов..."
if ! apt autoremove -y; then
  error "Не удалось выполнить autoremove"
fi

# === 3. Удаление содержимого ~/.cache ===
frame "📂 Очистка папки ~/.cache..."
[[ -d ~/.cache ]] && rm -rf ~/.cache/*

# === 4. Очистка внутреннего кэша Termux ===
frame "📂 Очистка внутреннего кэша Termux..."
[[ -d /data/data/com.termux/cache ]] && rm -rf /data/data/com.termux/cache/*

# === 5. Удаление мусора на SD-карте ===
frame "🗑️ Удаление /sdcard/.Trash..."
rm -rf /sdcard/.Trash/* 2>/dev/null

# === 6. Очистка истории команд Bash и Zsh ===
frame "📜 Очистка истории команд..."
rm -f ~/.bash_history ~/.zsh_history

# === 7. Удаление lock- и log-файлов APT ===
frame "🔐 Удаление файлов блокировок и логов..."
rm -f /data/data/com.termux/files/usr/var/lib/apt/lists/lock
rm -f /data/data/com.termux/files/usr/var/cache/apt/archives/lock
rm -f /data/data/com.termux/files/usr/var/lib/dpkg/lock

# === 8. Проверка занятого места ===
frame "📊 Использование памяти:"
df -h | grep -E '^(/|/data|/dev|/sdcard)'

# === ЗАВЕРШЕНИЕ ===
frame "✅ Очистка Termux завершена!"