#!/system/bin/sh
#
# shellcheck disable=SC2148
#

# Путь к оригинальному файлу
ORIG_FILE=/system/etc/floating_feature.xml

# Путь для сохранения бэкапа внутри модуля
# Magisk/KernelSU автоматически сохранит его в нужном месте
MOD_BACKUP=$MODPATH/system/etc/floating_feature.xml.bak

ui_print "**********************************************"
ui_print "          Samsung A55 Tweaks (OneUI)          "
ui_print "              by mikhailfur                   "
ui_print "**********************************************"

# Проверяем, существует ли оригинальный файл
if [ -f "$ORIG_FILE" ]; then
  ui_print "- Найдена оригинальная конфигурация..."
  ui_print "- Создание резервной копии..."

  # Создаем директорию для бэкапа, если ее нет
  mkdir -p "$(dirname "$MOD_BACKUP")"

  # Копируем оригинальный файл в бэкап (БЕЗ флага -Z)
  cp -a "$ORIG_FILE" "$MOD_BACKUP"

  if [ -f "$MOD_BACKUP" ]; then
    ui_print "- Резервная копия успешно создана!"
  else
    ui_print "- ОШИБКА: Не удалось создать резервную коию."
    ui_print "- Установка прервана."
    abort "Не удалось создать бэкап файла."
  fi
else
  ui_print "- Оригинальный файл floating_feature.xml не найден."
  ui_print "- Установка продолжится без создания бэкапа."
fi

ui_print "- Установка нового файла floating_feature.xml..."

# Установка прав доступа для нового файла
# 644 (-rw-r--r--) владелец: root (0), группа: root (0)
set_perm "$MODPATH/system/etc/floating_feature.xml" 0 0 0644

ui_print "- Установка завершена!"