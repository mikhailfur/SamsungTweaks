#!/system/bin/sh
#
# shellcheck disable=SC2148
#

# Пути к оригинальным файлам
ORIG_FLOATING_FILE=/system/etc/floating_feature.xml
ORIG_CAMERA_FILE=/system/cameradata/camera-feature.xml

# Пути для сохранения бэкапов внутри модуля
MOD_FLOATING_BACKUP=$MODPATH/system/etc/floating_feature.xml.bak
MOD_CAMERA_BACKUP=$MODPATH/system/cameradata/camera-feature.xml.bak

ui_print "**********************************************"
ui_print "          Samsung A55 Tweaks (OneUI)          "
ui_print "              by mikhailfur                   "
ui_print "**********************************************"

# Проверяем и создаем бэкап для floating_feature.xml
if [ -f "$ORIG_FLOATING_FILE" ]; then
  ui_print "- Найдена оригинальная конфигурация floating_feature.xml..."
  ui_print "- Создание резервной копии..."

  mkdir -p "$(dirname "$MOD_FLOATING_BACKUP")"
  cp -a "$ORIG_FLOATING_FILE" "$MOD_FLOATING_BACKUP"

  if [ -f "$MOD_FLOATING_BACKUP" ]; then
    ui_print "- Резервная копия floating_feature.xml успешно создана!"
  else
    ui_print "- ОШИБКА: Не удалось создать резервную копию floating_feature.xml."
    ui_print "- Установка прервана."
    abort "Не удалось создать бэкап файла floating_feature.xml."
  fi
else
  ui_print "- Оригинальный файл floating_feature.xml не найден."
  ui_print "- Установка продолжится без создания бэкапа."
fi

# Проверяем и создаем бэкап для camera-feature.xml
if [ -f "$ORIG_CAMERA_FILE" ]; then
  ui_print "- Найдена оригинальная конфигурация camera-feature.xml..."
  ui_print "- Создание резервной копии..."

  mkdir -p "$(dirname "$MOD_CAMERA_BACKUP")"
  cp -a "$ORIG_CAMERA_FILE" "$MOD_CAMERA_BACKUP"

  if [ -f "$MOD_CAMERA_BACKUP" ]; then
    ui_print "- Резервная копия camera-feature.xml успешно создана!"
  else
    ui_print "- ОШИБКА: Не удалось создать резервную копию camera-feature.xml."
    ui_print "- Установка прервана."
    abort "Не удалось создать бэкап файла camera-feature.xml."
  fi
else
  ui_print "- Оригинальный файл camera-feature.xml не найден."
  ui_print "- Установка продолжится без создания бэкапа."
fi

ui_print "- Установка новых файлов конфигурации..."

# Установка прав доступа для floating_feature.xml
set_perm "$MODPATH/system/etc/floating_feature.xml" 0 0 0644

# Установка прав доступа для camera-feature.xml
set_perm "$MODPATH/system/cameradata/camera-feature.xml" 0 0 0644

ui_print "- Установка завершена!"