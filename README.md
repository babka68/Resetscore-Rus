# ResetScore 1.3
Описание: Обнуление счета Убийств и смертей игроков.

Команды: !rs, !кы, !resetscore, !куыуесщку.

Cvar:
sm_notification_chat "1" // 1 - Включает, 0 - Отключить уведомление о доступных командах от плагина.
Установка:
1) Поместить ResetScore.smx по пути \addons\sourcemod\plugins
2) (Не обязательно) Поместить ResetScore.sp по пути \addons\sourcemod\scripting
3) Поместить ResetScore.phrases по пути \addons\sourcemod\translations
4) Прописать в server.cfg
sm_notification_chat "1" // 1 - Включает, 0 - Отключить уведомление о доступных командах от плагина.
5) Перезапустить сервер и наслаждаться работой плагина

Обновление 1.1
- Новый синтаксис
- Подключение #include <morecolors> и раскраска чата.
- Сделал более современным способом информацию о плагине
- Убрал resetscore_version который отображал версию при написании в консоль
- Убрал Функцию PrintToConsole - Отправляет сообщение на консоль клиента.
- Убран #include <sdktools> и IsPlayerAlive 
Примечание. Эта функция изначально была в SDKTools и была перенесена в ядро.

Обновление 1.2
- Оптимизирован код
- Добавлены фразы перевода RU EN
- Убран ConVar sm_resetscore "1" // 1 - включает,0 - отключает плагин.
- Добавлен ConVar sm_Notification_Chat "1" // 1 - Включает, 0 - Отключить уведомление от плагина.
- Еще куча доработок.

Обновление 1.3
Мини оптимизация:
- Изменены фразы перевода 
reset_success => eset_success_chat
- Изменил объявление переменной
Handle Notification_Chat; => ConVar g_NotificationChat;
- Изменил регистрацию команд
RegConsoleCmd("say", PerformCommand); => AddCommandListener(PerformCommand, "say");
RegConsoleCmd("say_team", PerformCommand); => (PerformCommand, "say_team");
- Изменил названия переменной
Notification_Chat = CreateConVar("sm_Notification_Chat", =>  g_NotificationChat = CreateConVar("sm_notification_chat",
- В некоторых местах добавлена return Plugin_Continue;
- Изменил размер буфера char buffer[128];  => char szBuffer[MAX_NAME_LENGTH];
- Изменил для "красоты" client => iClient
- Изменил для "красоты" buffer => szBuffer
- Изменил для "красоты"TimerNotification(Handle timer, any client) =>  Timer_Notification(Handle hTimer, any iClient)
Обновление 1.4
Исправлен error log "[SM] Exception reported: Client 17 is not in game"
Добавил проверки:
1. IsClientInGame - Возвращает, если в игру вошел определенный игрок.
2. IsFakeClient - Возвращает, если определенный игрок является фальшивым клиентом.
