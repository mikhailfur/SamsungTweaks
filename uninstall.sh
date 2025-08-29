#!/system/bin/sh

# Путь к бэкапу внутри модуля
MOD_DIR_BACKUP="$MODPATH/backup"
BACKUP_FILE="$MOD_DIR_BACKUP/floating_feature.xml.bak"

if [ -f "$BACKUP_FILE" ]; then
  rm -f "$BACKUP_FILE"
fi

if [ -d "$MOD_DIR_BACKUP" ]; then
  rmdir "$MOD_DIR_BACKUP"
fi