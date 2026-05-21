-- FlyTravelTimes Localization System
-- Supports: English, German, French, Spanish, Russian, Simplified Chinese, Traditional Chinese, Greek

FlyTravelTimes = FlyTravelTimes or {}
local FTT = FlyTravelTimes

-- Get client locale
local locale = GetLocale()

-- Default strings (English)
FTT.L = {
    -- Addon name
    ["ADDON_NAME"] = "FlyTravelTimes",
    
    -- Messages
    ["LOADED"] = "loaded! Use /ftt for options.",
    ["ENABLED"] = "Enabled",
    ["DISABLED"] = "Disabled",
    ["ESTIMATE_ON"] = "Estimate messages enabled",
    ["ESTIMATE_OFF"] = "Estimate messages disabled",
    ["POSITION_RESET"] = "Position reset",
    ["TESTING"] = "Testing 2 minute flight",
    ["FLIGHT_TIME"] = "Estimated flight time: %s",
    ["REMAINING"] = "%s remaining (%d%%)",
    
    -- Commands help
    ["CMD_HEADER"] = "commands:",
    ["CMD_TOGGLE"] = "/ftt toggle - Enable/disable addon",
    ["CMD_ESTIMATE"] = "/ftt estimate - Toggle estimate messages",
    ["CMD_TEST"] = "/ftt test - Test the timer bar",
    ["CMD_RESET"] = "/ftt reset - Reset bar position",
    ["CMD_LOCK"] = "/ftt lock - Lock/unlock the bar position",
    ["CMD_FONTSIZE"] = "/ftt fontsize <6-32> - Set font size",
    ["CMD_HELP"] = "Drag the bar to move it",
    
    -- Lock / font size
    ["BAR_LOCKED"] = "Bar locked (cannot be moved)",
    ["BAR_UNLOCKED"] = "Bar unlocked (drag to move)",
    ["FONT_SIZE_SET"] = "Font size set to %d",
    ["FONT_SIZE_RANGE"] = "Font size must be between 6 and 32",
    ["FONT_SIZE_CURRENT"] = "Current font size: %d. Usage: /ftt fontsize <6-32>",
}

-- German (Deutsch)
if locale == "deDE" then
    FTT.L["LOADED"] = "geladen! Nutze /ftt für Optionen."
    FTT.L["ENABLED"] = "Aktiviert"
    FTT.L["DISABLED"] = "Deaktiviert"
    FTT.L["ESTIMATE_ON"] = "Zeitschätzungen aktiviert"
    FTT.L["ESTIMATE_OFF"] = "Zeitschätzungen deaktiviert"
    FTT.L["POSITION_RESET"] = "Position zurückgesetzt"
    FTT.L["TESTING"] = "Teste 2-Minuten-Flug"
    FTT.L["FLIGHT_TIME"] = "Geschätzte Flugzeit: %s"
    FTT.L["REMAINING"] = "%s verbleibend (%d%%)"
    FTT.L["CMD_HEADER"] = "Befehle:"
    FTT.L["CMD_TOGGLE"] = "/ftt toggle - Addon aktivieren/deaktivieren"
    FTT.L["CMD_ESTIMATE"] = "/ftt estimate - Zeitschätzungen umschalten"
    FTT.L["CMD_TEST"] = "/ftt test - Timer-Leiste testen"
    FTT.L["CMD_RESET"] = "/ftt reset - Position zurücksetzen"
    FTT.L["CMD_HELP"] = "Ziehe die Leiste, um sie zu verschieben"

-- French (Français)
elseif locale == "frFR" then
    FTT.L["LOADED"] = "chargé ! Utilisez /ftt pour les options."
    FTT.L["ENABLED"] = "Activé"
    FTT.L["DISABLED"] = "Désactivé"
    FTT.L["ESTIMATE_ON"] = "Messages d'estimation activés"
    FTT.L["ESTIMATE_OFF"] = "Messages d'estimation désactivés"
    FTT.L["POSITION_RESET"] = "Position réinitialisée"
    FTT.L["TESTING"] = "Test d'un vol de 2 minutes"
    FTT.L["FLIGHT_TIME"] = "Temps de vol estimé : %s"
    FTT.L["REMAINING"] = "%s restant (%d%%)"
    FTT.L["CMD_HEADER"] = "commandes :"
    FTT.L["CMD_TOGGLE"] = "/ftt toggle - Activer/désactiver l'addon"
    FTT.L["CMD_ESTIMATE"] = "/ftt estimate - Basculer les messages d'estimation"
    FTT.L["CMD_TEST"] = "/ftt test - Tester la barre de temps"
    FTT.L["CMD_RESET"] = "/ftt reset - Réinitialiser la position"
    FTT.L["CMD_HELP"] = "Faites glisser la barre pour la déplacer"

-- Spanish (Español)
elseif locale == "esES" or locale == "esMX" then
    FTT.L["LOADED"] = "¡cargado! Usa /ftt para opciones."
    FTT.L["ENABLED"] = "Activado"
    FTT.L["DISABLED"] = "Desactivado"
    FTT.L["ESTIMATE_ON"] = "Mensajes de estimación activados"
    FTT.L["ESTIMATE_OFF"] = "Mensajes de estimación desactivados"
    FTT.L["POSITION_RESET"] = "Posición restablecida"
    FTT.L["TESTING"] = "Probando vuelo de 2 minutos"
    FTT.L["FLIGHT_TIME"] = "Tiempo de vuelo estimado: %s"
    FTT.L["REMAINING"] = "%s restante (%d%%)"
    FTT.L["CMD_HEADER"] = "comandos:"
    FTT.L["CMD_TOGGLE"] = "/ftt toggle - Activar/desactivar addon"
    FTT.L["CMD_ESTIMATE"] = "/ftt estimate - Alternar mensajes de estimación"
    FTT.L["CMD_TEST"] = "/ftt test - Probar la barra de tiempo"
    FTT.L["CMD_RESET"] = "/ftt reset - Restablecer posición"
    FTT.L["CMD_HELP"] = "Arrastra la barra para moverla"

-- Russian (Русский)
elseif locale == "ruRU" then
    FTT.L["LOADED"] = "загружен! Используйте /ftt для настроек."
    FTT.L["ENABLED"] = "Включено"
    FTT.L["DISABLED"] = "Выключено"
    FTT.L["ESTIMATE_ON"] = "Сообщения о времени включены"
    FTT.L["ESTIMATE_OFF"] = "Сообщения о времени выключены"
    FTT.L["POSITION_RESET"] = "Позиция сброшена"
    FTT.L["TESTING"] = "Тестирование 2-минутного полёта"
    FTT.L["FLIGHT_TIME"] = "Ориентировочное время полёта: %s"
    FTT.L["REMAINING"] = "%s осталось (%d%%)"
    FTT.L["CMD_HEADER"] = "команды:"
    FTT.L["CMD_TOGGLE"] = "/ftt toggle - Включить/выключить аддон"
    FTT.L["CMD_ESTIMATE"] = "/ftt estimate - Переключить сообщения о времени"
    FTT.L["CMD_TEST"] = "/ftt test - Проверить панель таймера"
    FTT.L["CMD_RESET"] = "/ftt reset - Сбросить позицию"
    FTT.L["CMD_HELP"] = "Перетащите панель, чтобы переместить её"

-- Simplified Chinese (简体中文)
elseif locale == "zhCN" then
    FTT.L["LOADED"] = "已加载！使用 /ftt 打开设置。"
    FTT.L["ENABLED"] = "已启用"
    FTT.L["DISABLED"] = "已禁用"
    FTT.L["ESTIMATE_ON"] = "估计信息已启用"
    FTT.L["ESTIMATE_OFF"] = "估计信息已禁用"
    FTT.L["POSITION_RESET"] = "位置已重置"
    FTT.L["TESTING"] = "测试2分钟飞行"
    FTT.L["FLIGHT_TIME"] = "预计飞行时间：%s"
    FTT.L["REMAINING"] = "剩余 %s (%d%%)"
    FTT.L["CMD_HEADER"] = "命令："
    FTT.L["CMD_TOGGLE"] = "/ftt toggle - 启用/禁用插件"
    FTT.L["CMD_ESTIMATE"] = "/ftt estimate - 切换估计信息"
    FTT.L["CMD_TEST"] = "/ftt test - 测试时间条"
    FTT.L["CMD_RESET"] = "/ftt reset - 重置位置"
    FTT.L["CMD_HELP"] = "拖动条以移动位置"

-- Traditional Chinese (繁體中文)
elseif locale == "zhTW" then
    FTT.L["LOADED"] = "已載入！請使用 /ftt 開啟選項。"
    FTT.L["ENABLED"] = "已啟用"
    FTT.L["DISABLED"] = "已停用"
    FTT.L["ESTIMATE_ON"] = "預估訊息已啟用"
    FTT.L["ESTIMATE_OFF"] = "預估訊息已停用"
    FTT.L["POSITION_RESET"] = "位置已重置"
    FTT.L["TESTING"] = "測試2分鐘飛行"
    FTT.L["FLIGHT_TIME"] = "預估飛行時間：%s"
    FTT.L["REMAINING"] = "剩餘 %s (%d%%)"
    FTT.L["CMD_HEADER"] = "指令："
    FTT.L["CMD_TOGGLE"] = "/ftt toggle - 啟用/停用插件"
    FTT.L["CMD_ESTIMATE"] = "/ftt estimate - 切換預估訊息"
    FTT.L["CMD_TEST"] = "/ftt test - 測試時間條"
    FTT.L["CMD_RESET"] = "/ftt reset - 重置位置"
    FTT.L["CMD_HELP"] = "拖曳時間條以移動位置"

-- Greek (Ελληνικά)
elseif locale == "elGR" then
    FTT.L["LOADED"] = "φορτώθηκε! Χρησιμοποίησε /ftt για επιλογές."
    FTT.L["ENABLED"] = "Ενεργοποιημένο"
    FTT.L["DISABLED"] = "Απενεργοποιημένο"
    FTT.L["ESTIMATE_ON"] = "Μηνύματα εκτίμησης ενεργοποιημένα"
    FTT.L["ESTIMATE_OFF"] = "Μηνύματα εκτίμησης απενεργοποιημένα"
    FTT.L["POSITION_RESET"] = "Επαναφορά θέσης"
    FTT.L["TESTING"] = "Δοκιμή πτήσης 2 λεπτών"
    FTT.L["FLIGHT_TIME"] = "Εκτιμώμενος χρόνος πτήσης: %s"
    FTT.L["REMAINING"] = "%s απομένουν (%d%%)"
    FTT.L["CMD_HEADER"] = "εντολές:"
    FTT.L["CMD_TOGGLE"] = "/ftt toggle - Ενεργοποίηση/απενεργοποίηση addon"
    FTT.L["CMD_ESTIMATE"] = "/ftt estimate - Εναλλαγή μηνυμάτων εκτίμησης"
    FTT.L["CMD_TEST"] = "/ftt test - Δοκιμή της μπάρας χρόνου"
    FTT.L["CMD_RESET"] = "/ftt reset - Επαναφορά θέσης μπάρας"
    FTT.L["CMD_HELP"] = "Σύρε τη μπάρα για να τη μετακινήσεις"
end
