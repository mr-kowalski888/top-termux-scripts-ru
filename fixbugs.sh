#!/data/data/com.termux/files/usr/bin/bash

echo "🔄 Удаление lock-файлов..."
rm -f /data/data/com.termux/files/usr/var/lib/dpkg/lock
rm -f /data/data/com.termux/files/usr/var/lib/dpkg/lock-frontend

echo "🧹 Очистка..."
yes | pkg autoclean
yes | pkg clean

echo "🛠 Восстановление..."
dpkg --configure -a
pkg install -y termux-tools proot bash zsh coreutils util-linux busybox
pkg update -y && pkg upgrade -y

echo "✅ Готово!"
