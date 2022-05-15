# ResetScore 1.6.1
Поддерживаемые игры	CS: Source (OrangeBox)CS: GO

Описание: 
- CSS: Обнуление самый ценный игрок(звезды) => убийств => смертей
- CS GO: Обнуление счета убийств => помощь => смертей => самый ценный игрок(звезды) => общий счет

Команды: 
- !rs, !кы, !resetscore, !куыуесщку.

Cvar:
- sm_enable 					"1" 					// 1 - Включить, 0 - Отключить плагин. (по умолчанию: 1)
- sm_join_info_chat 			"1" 					// Отвечает за вывод сообщения о доступных командах, после успешного подключения на сервер (по умолчанию: 1)
- sm_join_info_time				"15"					// Отвечает за время вывода сообщения о доступных командах(по умолчанию: 15)
- sm_show_silent_info_reset 	"1"						// Отвечает за вывод сообщения о сброшенном счёте игрока (по умолчанию: 1)
- sm_prefix						"[ResetScore]"  		// Отвечает за вывод сообщения перед текстовым сообщением (по умолчанию: [ResetScore])

- Установка:
1) Поместить ResetScore.smx по пути /addons/sourcemod/plugins
2) (Не обязательно) Поместить ResetScore.sp по пути /addons/sourcemod/scripting
3) Поместить resetscore_ваша версия игры.phrases по пути /addons/sourcemod/translations
4) Перезапустить сервер
4) Настроить файла конфигурации cfg/sourcemod/resetscore.cfg
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
- Исправлен error log "[SM] Exception reported: Client 17 is not in game"
- Добавил проверки:
- IsClientInGame - Возвращает, если в игру вошел определенный игрок.
- IsFakeClient - Возвращает, если определенный игрок является фальшивым клиентом.

Обновление 1.5
- Убран лишний код,который обсуждали.
	GetClientName(iClient, szBuffer, sizeof(szBuffer));
    for (int i = 1; i <= MaxClients; i++)
        
    if (i != iClient && IsClientInGame(i) && !IsFakeClient(i))
    {
        CPrintToChat(iClient, "%t", "reset_success_chat");
        return Plugin_Continue;
    }

Обновление 1.6.1
- Оптимизирован код
- Для игры CS GO(Наконец то) добавлены обнуление Assists(помощь) и Points(общий счет)
- Только заметил, что не обнуляются Stars(Звезды) исправил.
- Исправлены ошибки по таймеру
- Добавлены новые квары:
- sm_enable 					"1" 					// 1 - Включить, 0 - Отключить плагин. (по умолчанию: 1)
- sm_join_info_chat 			"1" 					// Отвечает за вывод сообщения о доступных командах, после успешного подключения на сервер (по умолчанию: 1)
- sm_join_info_time				"15"					// Отвечает за время вывода сообщения о доступных командах(по умолчанию: 15)
- sm_show_silent_info_reset 	"1"						// Отвечает за вывод сообщения о сброшенном счёте игрока (по умолчанию: 1)
- sm_prefix						"[ResetScore]"  		// Отвечает за вывод сообщения перед текстовым сообщением (по умолчанию: [ResetScore])
- Добавлено автоматическое создание файла конфигурации cfg/sourcemod/resetscore.cfg
- Были изменены названия фраз в файлах перевода, на более логичные
- Сделал пометку: // TODO: Сделать квар или файл, для написания желаемых команд.

Обновление 1.6.2
- Исправлена работа плагина на css v34, а именно:
- В CSS V34 нет CS_GetMVPCount и CS_SetMVPCount, поэтому выбивало ошибку Exception reported: SetMVPCount is not supported on this game

- Контакты для связи при возникновении проблемы/предложений: 
1. Discord babka68#4072
2. Telegram https://t.me/babka68
3. Вконтакте https://vk.com/id142504197
4. WhatsApp: +7 (953) 124-71-33

