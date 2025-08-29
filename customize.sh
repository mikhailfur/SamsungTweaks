#!/system/bin/sh
# shellcheck disable=SC2143

# Путь к системному файлу
ORIG_FILE=/system/etc/floating_feature.xml
# Путь к файлу в модуле
MOD_FILE=$MODPATH/system/etc/floating_feature.xml
# Путь для бэкапа
BACKUP_DIR=$MODPATH/backup
BACKUP_FILE=$BACKUP_DIR/floating_feature.xml.bak

# Устанавливаем права доступа
set_permissions() {
  set_perm_recursive "$MODPATH" 0 0 0755 0644
}

ui_print "*******************************"
ui_print "      SamsungTweaks Module"
ui_print "        by mikhailfur"
ui_print "*******************************"

# Проверка наличия оригинального файла
if [ ! -f "$ORIG_FILE" ]; then
  ui_print "- $ORIG_FILE не найден!"
  abort "! Установка прервана."
fi

ui_print "- Создание копии $ORIG_FILE в модуль..."
# Копируем оригинальный файл в директорию модуля для последующей модификации
cp -f "$ORIG_FILE" "$MOD_FILE"

# --- ОБЯЗАТЕЛЬНЫЕ СТРОКИ ---
ui_print "- Проверка наличия обязательных строк..."

# Проверка 1
if ! grep -q '<SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_BRIGHTNESS_ANIMATION>' "$MOD_FILE"; then
  abort "! Строка AOD_BRIGHTNESS_ANIMATION не найдена. Установка отменена."
fi
# Проверка 2
if ! grep -q '<SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_FULLSCREEN>' "$MOD_FILE"; then
  abort "! Строка AOD_FULLSCREEN не найдена. Установка отменена."
fi
# Проверка 3
if ! grep -q '<SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_REFRESH_RATE>' "$MOD_FILE"; then
  abort "! Строка AOD_REFRESH_RATE не найдена. Установка отменена."
fi

ui_print "  Все обязательные строки найдены."

# Создание бэкапа перед модификацией
ui_print "- Создание бэкапа оригинального файла..."
mkdir -p "$BACKUP_DIR"
cp -f "$ORIG_FILE" "$BACKUP_FILE"

# --- МОДИФИКАЦИЯ ФАЙЛА ---
ui_print "- Применение твиков..."

# Обязательные изменения
ui_print "  Применяем AOD твики..."
sed -i 's|<SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_BRIGHTNESS_ANIMATION>0</SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_BRIGHTNESS_ANIMATION>|<SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_BRIGHTNESS_ANIMATION>1</SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_BRIGHTNESS_ANIMATION>|' "$MOD_FILE"
sed -i 's|<SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_FULLSCREEN>0</SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_FULLSCREEN>|<SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_FULLSCREEN>1</SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_FULLSCREEN>|' "$MOD_FILE"
sed -i 's|<SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_REFRESH_RATE>0</SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_REFRESH_RATE>|<SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_REFRESH_RATE>59</SEC_FLOATING_FEATURE_LCD_CONFIG_AOD_REFRESH_RATE>|' "$MOD_FILE"

# Опциональные изменения
ui_print "  Применяем опциональные твики..."
sed -i 's|<SEC_FLOATING_FEATURE_COMMON_DISABLE_NATIVE_AI>TRUE</SEC_FLOATING_FEATURE_COMMON_DISABLE_NATIVE_AI>|<SEC_FLOATING_FEATURE_COMMON_DISABLE_NATIVE_AI>FALSE</SEC_FLOATING_FEATURE_COMMON_DISABLE_NATIVE_AI>|' "$MOD_FILE"
sed -i 's|<SEC_FLOATING_FEATURE_GENAI_SUPPORT_TIME_WEATHER_WALLPAPER>None</SEC_FLOATING_FEATURE_GENAI_SUPPORT_TIME_WEATHER_WALLPAPER>|<SEC_FLOATING_FEATURE_GENAI_SUPPORT_TIME_WEATHER_WALLPAPER>TRUE</SEC_FLOATING_FEATURE_GENAI_SUPPORT_TIME_WEATHER_WALLPAPER>|' "$MOD_FILE"
sed -i 's|<SEC_FLOATING_FEATURE_AUDIO_CONFIG_INTERPRETER>0</SEC_FLOATING_FEATURE_AUDIO_CONFIG_INTERPRETER>|<SEC_FLOATING_FEATURE_AUDIO_CONFIG_INTERPRETER>1</SEC_FLOATING_FEATURE_AUDIO_CONFIG_INTERPRETER>|' "$MOD_FILE"

ui_print "- Установка успешно завершена!"