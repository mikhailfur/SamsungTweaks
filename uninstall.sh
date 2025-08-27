#!/system/bin/sh
#
# shellcheck disable=SC2148
#

# Путь к оригинальному файлу, который был заменен
ORIG_FILE=/system/etc/floating_feature.xml

# Путь к резервной копии внутри модуля.
# Переменная $MODDIR указывает на директорию модуля в /data/adb/modules/
MOD_BACKUP=$MODDIR/system/etc/floating_feature.xml.bak

# Проверяем, существует ли наша резервная копия
if [ -f "$MOD_BACKUP" ]; then
  # Восстанавливаем оригинальный файл из бэкапа (БЕЗ флага -Z)
  cp -a "$MOD_BACKUP" "$ORIG_FILE"
fi