# Resetscore-Rus
Обнуление  счета убийств/смертей игроков.
Автор плагина tuty,но тут я не нашел его.

Переменные: sm_resetscore "1" // 1 - включает,0 - отключает плагин.

Команды:	
!rs
!кы
!resetscore
!куыуесщку

Установка:	
1) Поместить Resetscore.smx по пути \addons\sourcemod\plugins
2) (Не обязательно) Поместить Resetscore.sp по пути \addons\sourcemod\scripting
3) Прописать в server.cfg
sm_resetscore "1" // 1 - включает,0 - отключает плагин.
4) Перезапустить сервер и наслаждаться работой плагина

Обновление: 1.1
- Новый синтаксис
- Подключение #include <morecolors> и раскраска чата.
- Сделал более современным способом информацию о плагине
- Убрал resetscore_version который отображал версию при написании в консоль
- Убрал Функцию PrintToConsole - Отправляет сообщение на консоль клиента.
- Убран #include <sdktools> и IsPlayerAlive 
Примечание. Эта функция изначально была в SDKTools и была перенесена в ядро.
