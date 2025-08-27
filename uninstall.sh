#!/system/bin/sh
#
# shellcheck disable=SC2148
#

# Путь к оригинальному файлу, который был заменен
ORIG_FILE=/system/etc/floating_feature.xml

# Путь к резервной копии внутри модуля.
# Magisk сохраняет данные модуля в /data/adb/modules/ID_МОДУЛЯ
# Переменная $MODDIR указывает на эту директорию
MOD_BACKUP=$MODDIR/system/etc/floating_feature.xml.bak

# Проверяем, существует ли наша резервная копия
if [ -f "$MOD_BACKUP" ]; then
  # Восстанавливаем оригинальный файл из бэкапа
  # Флаг -Z нужен для восстановления контекста SELinux
  cp -aZ "$MOD_BACKUP" "$ORIG_FILE"
fi