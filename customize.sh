#!/system/bin/sh

# Путь к целевому файлу
TARGET_XML="/system/etc/floating_feature.xml"
# Путь для бэкапа внутри модуля
MOD_DIR_BACKUP="$MODPATH/backup"
BACKUP_FILE="$MOD_DIR_BACKUP/floating_feature.xml.bak"
# Путь, куда будет скопирован измененный файл
MOD_FILE_PATH="$MODPATH/system/etc/floating_feature.xml"

ui_print "*******************************"
ui_print "        SamsungTweaks v1.3.0    "
ui_print "          by mikhailfur         "
ui_print "*******************************"

# Проверяем, существует ли целевой файл
if [ ! -f "$TARGET_XML" ]; then
  ui_print "- Файл $TARGET_XML не найден!"
  abort "Установка прервана."
fi

ui_print "- Целевой файл найден: $TARGET_XML"

# Создаем директорию для измененного файла
mkdir -p "$(dirname "$MOD_FILE_PATH")"
# Копируем оригинальный файл для модификации
cp -f "$TARGET_XML" "$MOD_FILE_PATH"

# --- Проверка обязательных строк ---
ui_print "- Проверка обязательных настроек..."

# Переменные для проверки
AOD_BRIGHTNESS_ANIMATION_EXISTS=$(grep -c "<SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_BRIGHTNESS_ANIMATION>0</SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_BRIGHTNESS_ANIMATION>" "$MOD_FILE_PATH")
AOD_FULLSCREEN_EXISTS=$(grep -c "<SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_FULLSCREEN>0</SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_FULLSCREEN>" "$MOD_FILE_PATH")
AOD_REFRESH_RATE_EXISTS=$(grep -c "<SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_REFRESH_RATE>0</SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_REFRESH_RATE>" "$MOD_FILE_PATH")

# Проверяем наличие всех трех строк
if [ "$AOD_BRIGHTNESS_ANIMATION_EXISTS" -eq 0 ] || [ "$AOD_FULLSCREEN_EXISTS" -eq 0 ] || [ "$AOD_REFRESH_RATE_EXISTS" -eq 0 ]; then
  ui_print "!"
  if [ "$AOD_BRIGHTNESS_ANIMATION_EXISTS" -eq 0 ]; then
    ui_print "! Обязательная строка AOD_BRIGHTNESS_ANIMATION не найдена."
  fi
  if [ "$AOD_FULLSCREEN_EXISTS" -eq 0 ]; then
    ui_print "! Обязательная строка AOD_FULLSCREEN не найдена."
  fi
  if [ "$AOD_REFRESH_RATE_EXISTS" -eq 0 ]; then
    ui_print "! Обязательная строка AOD_REFRESH_RATE не найдена."
  fi
  abort "! Ошибка: одна или несколько обязательных строк отсутствуют. Установка прервана."
else
  ui_print "- Все обязательные строки найдены."
fi

# --- Создание бэкапа ---
ui_print "- Создание бэкапа..."
mkdir -p "$MOD_DIR_BACKUP"
if cp -f "$TARGET_XML" "$BACKUP_FILE"; then
  ui_print "- Бэкап успешно создан в $BACKUP_FILE"
else
  ui_print "! Не удалось создать бэкап. Продолжаем без него."
fi

# --- Применение обязательных изменений ---
ui_print "- Применение обязательных твиков AOD..."
sed -i 's|<SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_BRIGHTNESS_ANIMATION>0</SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_BRIGHTNESS_ANIMATION>|<SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_BRIGHTNESS_ANIMATION>1</SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_BRIGHTNESS_ANIMATION>|g' "$MOD_FILE_PATH"
sed -i 's|<SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_FULLSCREEN>0</SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_FULLSCREEN>|<SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_FULLSCREEN>1</SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_FULLSCREEN>|g' "$MOD_FILE_PATH"
sed -i 's|<SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_REFRESH_RATE>0</SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_REFRESH_RATE>|<SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_REFRESH_RATE>59</SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_REFRESH_RATE>|g' "$MOD_FILE_PATH"
ui_print "- Твики AOD применены."

# --- Применение необязательных изменений ---
ui_print "- Применение дополнительных твиков..."
sed -i 's|<SEC_FLOATING_FEATURE_COMMON_DISABLE_NATIVE_AI>TRUE</SEC_FLOATING_FEATURE_COMMON_DISABLE_NATIVE_AI>|<SEC_FLOATING_FEATURE_COMMON_DISABLE_NATIVE_AI>FALSE</SEC_FLOATING_FEATURE_COMMON_DISABLE_NATIVE_AI>|g' "$MOD_FILE_PATH"
sed -i 's|<SEC_FLOATING_FEATURE_GENAI_SUPPORT_TIME_WEATHER_WALLPAPER>None</SEC_FLOATING_FEATURE_GENAI_SUPPORT_TIME_WEATHER_WALLPAPER>|<SEC_FLOATING_FEATURE_GENAI_SUPPORT_TIME_WEATHER_WALLPAPER>TRUE</SEC_FLOATING_FEATURE_GENAI_SUPPORT_TIME_WEATHER_WALLPAPER>|g' "$MOD_FILE_PATH"
sed -i 's|<SEC_FLOATING_FEATURE_AUDIO_CONFIG_INTERPRETER>0</SEC_FLOATING_FEATURE_AUDIO_CONFIG_INTERPRETER>|<SEC_FLOATING_FEATURE_AUDIO_CONFIG_INTERPRETER>1</SEC_FLOATING_FEATURE_AUDIO_CONFIG_INTERPRETER>|g' "$MOD_FILE_PATH"
ui_print "- Дополнительные твики применены."

# Установка прав доступа
set_perm_recursive "$MODPATH" 0 0 0755 0644

ui_print "- Установка успешно завершена!"
ui_print "- Перезагрузите устройство для применения изменений."