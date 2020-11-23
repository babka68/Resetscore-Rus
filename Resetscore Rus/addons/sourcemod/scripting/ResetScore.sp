#include <multicolors>
#include <csgo_colors>

#pragma newdecls required
#pragma semicolon 1

ConVar g_NotificationChat;

char	Engine_Version;

#define GAME_UNDEFINED 0
#define GAME_CSS_34 1
#define GAME_CSS 2
#define GAME_CSGO 3

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
	description = "Обнуление счета Убийств и смертей игроков", 
	version = "1.6", 
	url = "http://tmb-css.ru https://hlmod.ru"
};
public void OnPluginStart()
{
	Engine_Version = GetCSGame();
	if (Engine_Version == GAME_UNDEFINED)SetFailState("Game is not supported!");
	if (Engine_Version == GAME_CSS_34)LoadTranslations("resetscore_cssold.phrases");
	if (Engine_Version == GAME_CSS)LoadTranslations("resetscore_css.phrases");
	if (Engine_Version == GAME_CSGO)LoadTranslations("resetscore_csgo.phrases");
	
	LoadTranslations("ResetScore.phrases");
	
	AddCommandListener(PerformCommand, "say");
	AddCommandListener(PerformCommand, "say_team");
	g_NotificationChat = CreateConVar("sm_notification_chat", "1", "// 1 - Включает, 0 - Отключить уведомление от плагина в чат.", _, true, 0.0, true, 1.0);
}

public void OnClientPutInServer(int iClient)
{
	if (g_NotificationChat.BoolValue)
		CreateTimer(15.0, Timer_Notification, iClient);
}

public Action Timer_Notification(Handle hTimer, any iClient)
{
	if (IsClientInGame(iClient))
		if(Engine_Version == GAME_CSGO)CGOPrintToChat(iClient, "%t", "Notification_chat");
		else CPrintToChat(iClient, "%t", "Notification_chat");
	
	return Plugin_Continue;
}

public Action PerformCommand(int iClient, const char[] szCmd, int iArgs)
{
	char szBuffer[MAX_NAME_LENGTH];
	GetCmdArgString(szBuffer, sizeof(szBuffer));
	StripQuotes(szBuffer);
	TrimString(szBuffer);
	
	if (strcmp(szBuffer, "!rs") && strcmp(szBuffer, "!кы") && strcmp(szBuffer, "!resetscore") && strcmp(szBuffer, "!куыуесщку"))
		return Plugin_Continue;
	{
		if (GetClientDeaths(iClient) == 0 && IsClientInGame(iClient) && !IsFakeClient(iClient) && GetClientFrags(iClient) == 0)
		{
			if(Engine_Version == GAME_CSGO)CGOPrintToChat(iClient, "%t", "reset_already_chat");
			else CPrintToChat(iClient, "%t", "reset_already_chat");
			return Plugin_Continue;
		}
		
		SetEntProp(iClient, Prop_Data, "m_iFrags", 0);
		SetEntProp(iClient, Prop_Data, "m_iDeaths", 0);
		if(Engine_Version == GAME_CSGO)CGOPrintToChat(iClient, "%t", "reset_success_chat");
		else CPrintToChat(iClient, "%t", "reset_success_chat");
	}
	return Plugin_Continue;
}
