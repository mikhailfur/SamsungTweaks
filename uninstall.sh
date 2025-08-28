#!/system/bin/sh
#
# shellcheck disable=SC2148
#

# Пути к оригинальным файлам, которые были заменены
ORIG_FLOATING_FILE=/system/etc/floating_feature.xml
ORIG_CAMERA_FILE=/system/cameradata/camera-feature.xml

# Пути к резервным копиям внутри модуля
MOD_FLOATING_BACKUP=$MODDIR/system/etc/floating_feature.xml.bak
MOD_CAMERA_BACKUP=$MODDIR/system/cameradata/camera-feature.xml.bak

# Восстанавливаем floating_feature.xml
if [ -f "$MOD_FLOATING_BACKUP" ]; then
  ui_print "- Восстановление оригинального floating_feature.xml..."
  cp -a "$MOD_FLOATING_BACKUP" "$ORIG_FLOATING_FILE"
  ui_print "- floating_feature.xml восстановлен!"
else
  ui_print "- Резервная копия floating_feature.xml не найдена."
fi

# Восстанавливаем camera-feature.xml
if [ -f "$MOD_CAMERA_BACKUP" ]; then
  ui_print "- Восстановление оригинального camera-feature.xml..."
  cp -a "$MOD_CAMERA_BACKUP" "$ORIG_CAMERA_FILE"
  ui_print "- camera-feature.xml восстановлен!"
else
  ui_print "- Резервная копия camera-feature.xml не найдена."
fi

ui_print "- Модуль успешно удален!"