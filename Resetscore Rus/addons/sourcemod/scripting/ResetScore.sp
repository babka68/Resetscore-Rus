#include <morecolors>

#pragma newdecls required
#pragma semicolon 1

ConVar g_NotificationChat;

public Plugin myinfo = 
{
	name = "ResetScore", 
	author = "tuty, babka68", 
	description = "Обнуление счета Убийств и смертей игроков", 
	version = "1.5", 
	url = "http://tmb-css.ru https://hlmod.ru"
};
public void OnPluginStart()
{
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
		CPrintToChat(iClient, "%t", "Notification_chat");
	
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
			CPrintToChat(iClient, "%t", "reset_already_chat");
			return Plugin_Continue;
		}
		
		SetEntProp(iClient, Prop_Data, "m_iFrags", 0);
		SetEntProp(iClient, Prop_Data, "m_iDeaths", 0);
		CPrintToChat(iClient, "%t", "reset_success_chat");
	}
	return Plugin_Continue;
}
