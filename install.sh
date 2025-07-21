#!/data/data/com.termux/files/usr/bin/bash

# === ЦВЕТА ДЛЯ ВЫВОДА ===
GREEN="\033[1;32m"   # Зелёный
RED="\033[1;31m"     # Красный
BLUE="\033[1;34m"    # Синий
YELLOW="\033[1;33m"  # Жёлтый
RESET="\033[0m"      # Сброс цвета

# === ФУНКЦИЯ РАМКИ ===
print_frame() {
  echo -e "${BLUE}╔════════════════════════════════════════════╗${RESET}"
  echo -e "${BLUE}║ ${YELLOW}$1${RESET}"
  echo -e "${BLUE}╚════════════════════════════════════════════╝${RESET}"
}

# === ФУНКЦИЯ ОШИБКИ ===
print_error() {
  echo -e "${RED}╔════════════════════════════════════════════╗"
  echo -e "║ ❌ ОШИБКА: $1"
  echo -e "╚════════════════════════════════════════════╝${RESET}"
}

# === ОПИСАНИЕ УТИЛИТ ===
utility_descriptions=(
  "curl       - загрузка с URL"
  "wget       - альтернатива curl"
  "git        - система контроля версий"
  "nano       - простой текстовый редактор"
  "vim        - продвинутый текстовый редактор"
  "unzip      - распаковка zip-архивов"
  "tar        - работа с архивами .tar"
  "zip        - упаковка файлов"
  "tree       - древовидное отображение каталогов"
  "coreutils  - базовые UNIX-команды"
  "htop       - мониторинг процессов"
  "neofetch   - красивая информация о системе"
  "proot      - изоляция окружения"
  "termux-api - доступ к функциям Android"
  "openssh    - SSH клиент и сервер"
  "dnsutils   - DNS-инструменты (nslookup и др)"
  "busybox    - набор UNIX-инструментов"
  "inxi       - подробная информация о системе"
  "perl       - требуется для inxi"
  "nmap       - сканер портов"
  "netcat     - диагностика сети"
  "whois      - информация о доменах"
  "traceroute - маршрут до хоста"
  "python     - язык программирования"
  "python-pip - менеджер пакетов Python"
  "nodejs     - среда выполнения JavaScript"
  "php        - язык PHP"
  "clang      - компилятор C/C++"
  "ruby       - язык Ruby"
  "golang     - язык Go"
  "rust       - язык Rust"
  "figlet     - ASCII-баннеры"
  "toilet     - стильные баннеры"
  "lolcat     - цветной вывод"
)

# === СПИСОК ПАКЕТОВ ДЛЯ УСТАНОВКИ ===
packages=(
  curl wget git nano vim unzip tar zip tree coreutils
  htop neofetch proot termux-api openssh dnsutils busybox inxi perl
  nmap netcat whois traceroute
  python python-pip nodejs php clang ruby golang rust
  figlet toilet lolcat
)

# === ВЫВОД СПИСКА ПЕРЕД УСТАНОВКОЙ ===
clear
print_frame "🧰 Следующие утилиты будут установлены:"

for item in "${utility_descriptions[@]}"; do
  echo -e "${GREEN}  $item${RESET}"
done

echo
read -p "❓ Продолжить установку? (y/n): " confirm
if [[ $confirm != "y" && $confirm != "Y" ]]; then
  print_frame "⛔ Установка отменена пользователем"
  exit 0
fi

# === ОБНОВЛЕНИЕ СИСТЕМЫ ===
print_frame "🔄 Обновление списка пакетов..."
yes | pkg update > /dev/null 2>&1
yes | pkg upgrade > /dev/null 2>&1

# === УСТАНОВКА УТИЛИТ ===
print_frame "🚀 Начинается установка утилит..."

for package in "${packages[@]}"; do
  print_frame "📥 Установка: $package"
  if pkg install -y "$package" > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Установлено: $package${RESET}"
  else
    print_error "Не удалось установить: $package"
  fi
done

# === ФИНАЛЬНОЕ СООБЩЕНИЕ ===
print_frame "✅ Все утилиты успешно установлены!"