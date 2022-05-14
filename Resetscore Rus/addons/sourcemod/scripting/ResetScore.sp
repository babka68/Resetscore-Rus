#include <multicolors>
#include <csgo_colors>
#include <cstrike>

#pragma newdecls required
#pragma semicolon 1

// define Game Version
#define GAME_UNDEFINED 0
#define GAME_CSS_34 1
#define GAME_CSS 2
#define GAME_CSGO 3

// ConVar 
// Статус плагина
bool g_bEnable;

// Уведомление о доступных командах
bool g_bJoin_Info;

// Уведомление о сбросе счета
bool g_bShow_Info_Reset;

// Префикс 
char g_sPrefix[PLATFORM_MAX_PATH];

// Уведомление о доступных командах по таймеру
float g_fTime_Join_Info;

// Статус версии игры
char Engine_Version;

int GetCSGame()
{
	if (GetFeatureStatus(FeatureType_Native, "GetEngineVersion") == FeatureStatus_Available)
	{
		switch (GetEngineVersion())
		{
			case Engine_SourceSDK2006:return GAME_CSS_34;
			case Engine_CSS:return GAME_CSS;
			case Engine_CSGO:return GAME_CSGO;
		}
	}
	return GAME_UNDEFINED;
}

public Plugin myinfo = 
{
	name = "ResetScore", 
	author = "tuty, babka68", 
	description = "Плагин позволяет обнулять <Убийства> <Смерти> <Ассисты> <Звезды побед> <Общий счет>", 
	version = "1.6.1", 
	url = "http://tmb-css.ru, https://hlmod.ru, https://vk.com/zakazserver68"
};

public void OnPluginStart()
{
	Engine_Version = GetCSGame();
	
	if (Engine_Version == GAME_UNDEFINED)
	{
		SetFailState("Game is not supported!");
	}
	
	if (Engine_Version == GAME_CSS_34)
	{
		LoadTranslations("resetscore_cssold.phrases");
	}
	
	if (Engine_Version == GAME_CSS)
	{
		LoadTranslations("resetscore_css.phrases");
	}
	
	if (Engine_Version == GAME_CSGO)
	{
		LoadTranslations("resetscore_csgo.phrases");
	}
	
	AddCommandListener(PerformCommand, "say");
	AddCommandListener(PerformCommand, "say_team");
	
	ConVar cvar;
	cvar = CreateConVar("sm_enable", "1", "1 - Включить, 0 - Отключить плагин. (по умолчанию: 1)", _, true, 0.0, true, 1.0);
	cvar.AddChangeHook(CVarChanged_Enable);
	g_bEnable = cvar.BoolValue;
	
	cvar = CreateConVar("sm_join_info_chat", "1", "Отвечает за вывод сообщения о доступных командах, после успешного подключения на сервер (по умолчанию: 1)", _, true, 0.0, true, 1.0);
	cvar.AddChangeHook(CVarChanged_Join_Info_Chat);
	g_bJoin_Info = cvar.BoolValue;
	
	cvar = CreateConVar("sm_join_info_time", "15", "Отвечает за время вывода сообщения о доступных командах(по умолчанию: 15)", _, true, 0.0, true, 300.0);
	cvar.AddChangeHook(CVarChanged_Time_Join_Info);
	g_fTime_Join_Info = cvar.FloatValue;
	
	cvar = CreateConVar("sm_show_silent_info_reset", "1", "Отвечает за вывод сообщения о сброшенном счёте игрока (по умолчанию: 1)", _, true, 0.0, true, 1.0);
	cvar.AddChangeHook(CVarChanged_Show_Info_Reset);
	g_bShow_Info_Reset = cvar.BoolValue;
	
	cvar = CreateConVar("sm_prefix", "[ResetScore]", "Отвечает за вывод сообщения перед текстовым сообщением (по умолчанию: [ResetScore])");
	cvar.AddChangeHook(CVarChanged_Prefix);
	cvar.GetString(g_sPrefix, sizeof(g_sPrefix));
	
	AutoExecConfig(true, "resetscore");
}

public void CVarChanged_Enable(ConVar cvar, const char[] oldValue, const char[] newValue)
{
	g_bEnable = cvar.BoolValue;
}

public void CVarChanged_Join_Info_Chat(ConVar cvar, const char[] oldValue, const char[] newValue)
{
	g_bJoin_Info = cvar.BoolValue;
}

public void CVarChanged_Time_Join_Info(ConVar cvar, const char[] oldValue, const char[] newValue)
{
	g_fTime_Join_Info = cvar.FloatValue;
}

public void CVarChanged_Show_Info_Reset(ConVar cvar, const char[] oldValue, const char[] newValue)
{
	g_bShow_Info_Reset = cvar.BoolValue;
}

public void CVarChanged_Prefix(ConVar cvar, const char[] oldValue, const char[] newValue)
{
	cvar.GetString(g_sPrefix, sizeof(g_sPrefix));
}

public void OnClientPutInServer(int client)
{
	if (IsFakeClient(client))
		return;
	
	if (g_bJoin_Info)
	{
		CreateTimer(g_fTime_Join_Info, Timer_Notification_Of_Commands, GetClientUserId(client));
	}
}

public Action Timer_Notification_Of_Commands(Handle hTimer, any data)
{
	int client = GetClientOfUserId(data);
	
	if (IsClientInGame(client))
	{
		if (Engine_Version == GAME_CSGO)
		{
			CGOPrintToChat(client, "%t", "timer_notification_of_commands", g_sPrefix);
		}
		else
		{
			CPrintToChat(client, "%t", "timer_notification_of_commands", g_sPrefix);
		}
	}
	return Plugin_Handled;
}

public Action PerformCommand(int client, const char[] szCmd, int iArgs)
{
	if (!client)
	{
		return Plugin_Continue;
	}
	
	if (!g_bEnable)
	{
		if (Engine_Version == GAME_CSGO)
		{
			
			CGOPrintToChat(client, "%t", "plugin_status", g_sPrefix);
		}
		
		else
		{
			CPrintToChat(client, "%t", "plugin_status", g_sPrefix);
		}
		
		return Plugin_Handled;
	}
	
	static char buffer[MAX_NAME_LENGTH];
	// Извлекает всю строку аргумента команды одним куском из текущей консольной или серверной команды.
	GetCmdArgString(buffer, sizeof(buffer));
	// Удаляет пару кавычек из строки, если она существует.
	StripQuotes(buffer);
	// Удаляет пробельные символы из начала и конца строки.
	TrimString(buffer);
	
	// TODO: Сделать квар или файл, для написания желаемых команд.
	// Сравнивает две строки лексиографически.
	if (strcmp(buffer, "!rs") && strcmp(buffer, "!кы") && strcmp(buffer, "!resetscore") && strcmp(buffer, "!куыуесщку"))
	{
		return Plugin_Continue;
	}
	
	if (g_bShow_Info_Reset)
	{
		
		if (IsClientInGame(client) && !IsFakeClient(client) && GetClientFrags(client) == 0 && GetClientDeaths(client) == 0 && CS_GetMVPCount(client) == 0)
		{
			if (Engine_Version == GAME_CSGO && CS_GetClientAssists(client) == 0 && CS_GetClientContributionScore(client) == 0)
			{
				CGOPrintToChat(client, "%t", "points_already_null", g_sPrefix);
			}
			
			else
			{
				CPrintToChat(client, "%t", "points_already_null", g_sPrefix);
			}
			
			return Plugin_Handled;
		}
		
		// Фраги
		SetEntProp(client, Prop_Data, "m_iFrags", 0);
		// Смерти
		SetEntProp(client, Prop_Data, "m_iDeaths", 0);
		// Звезды побед
		CS_SetMVPCount(client, 0);
		
		if (Engine_Version == GAME_CSGO)
		{
			// Помощь
			CS_SetClientAssists(client, 0);
			// Очки
			CS_SetClientContributionScore(client, 0);
			
			CGOPrintToChat(client, "%t", "success_reset_points", g_sPrefix);
		}
		
		else
		{
			CPrintToChat(client, "%t", "success_reset_points", g_sPrefix);
		}
	}
	
	return Plugin_Continue;
}
