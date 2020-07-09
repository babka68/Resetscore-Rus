#include <sourcemod>
#include <morecolors>

#pragma newdecls required
#pragma semicolon 1

Handle Notification_Chat;

public Plugin myinfo = 
{
	name = "ResetScore", 
	author = "tuty,babka68", 
	description = "Обнуление счета Убийств и смертей игроков", 
	version = "1.2", 
	url = "http://tmb-css.ru https://hlmod.ru"
};
public void OnPluginStart()
{
	LoadTranslations("ResetScore.phrases");
	
	RegConsoleCmd("say", PerformCommand);
	RegConsoleCmd("say_team", PerformCommand);
	Notification_Chat = CreateConVar("sm_Notification_Chat", "1", "// 1 - Включает, 0 - Отключить уведомление от плагина.");
}

public void OnClientPutInServer(int client)
{
	if (GetConVarInt(Notification_Chat) == 1)
	{
		CreateTimer(15.0, TimerNotification, client);
	}
}

public Action TimerNotification(Handle timer, any client)
{
	if (IsClientInGame(client))
	{
		CPrintToChat(client, "%t", "Notification_chat");
	}
}

public Action PerformCommand(int client, int args)
{
	char buffer[128];
	GetCmdArgString(buffer, sizeof(buffer));
	StripQuotes(buffer);
	TrimString(buffer);
	
	if (strcmp(buffer, "!rs") && strcmp(buffer, "!кы") && strcmp(buffer, "!resetscore") && strcmp(buffer, "!куыуесщку"))
		return Plugin_Continue;
	
	if (GetClientDeaths(client) == 0 && GetClientFrags(client) == 0)
	{
		CPrintToChat(client, "%t", "reset_already_chat");
		return Plugin_Continue;
	}
	
	SetEntProp(client, Prop_Data, "m_iFrags", 0);
	SetEntProp(client, Prop_Data, "m_iDeaths", 0);
	
	CPrintToChat(client, "%t", "reset_success");
	
	GetClientName(client, buffer, sizeof(buffer));
	for (int i = 1; i <= MaxClients; i++)if (i != client && IsClientInGame(i) && !IsFakeClient(i))
		
	CPrintToChat(client, "%t", "reset_success", buffer);
	return Plugin_Continue;
}
