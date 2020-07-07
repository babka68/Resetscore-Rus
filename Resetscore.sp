#include <sourcemod>
#include <morecolors>

#pragma semicolon 1

Handle gPluginEnabled = INVALID_HANDLE;

public Plugin myinfo = 
{
	name = "ResetScore", 
	author = "tuty,babka68", 
	description = "Обнуление  счета (Убийств и смертей) игроков", 
	version = "1.1", 
	url = "http://tmb-css.ru/, https://hlmod.ru/"
};
public OnPluginStart()
{
	RegConsoleCmd("say", CommandSay);
	RegConsoleCmd("say_team", CommandSay);
	
	gPluginEnabled = CreateConVar("sm_resetscore", "1", "1 - включает,0 - отключает плагин.");
}
public Action CommandSay(id, args)
{
	char Said[128];
	GetCmdArgString(Said, sizeof(Said) - 1);
	StripQuotes(Said);
	TrimString(Said);
	
	if (StrEqual(Said, "!rs") || StrEqual(Said, "!кы") || StrEqual(Said, "!resetscore") || StrEqual(Said, "!куыуесщку"))
	{
		if (GetConVarInt(gPluginEnabled) == 0)
		{
			CPrintToChat(id, "{lime}[ResetScore] {fullred} Плагин отключен!", FCVAR_NOTIFY | FCVAR_REPLICATED);
			
			return Plugin_Continue;
		}
		
		if (GetClientDeaths(id) == 0 && GetClientFrags(id) == 0)
		{
			CPrintToChat(id, "{lime}[ResetScore] {fullred} Ваш {white} счет равен 0!");
			
			return Plugin_Continue;
		}
		
		SetClientFrags(id, 0);
		SetClientDeaths(id, 0);
		
		char Name[32];
		GetClientName(id, Name, sizeof(Name) - 1);
		
		CPrintToChat(id, "{lime}[ResetScore] {fullred} Вы {white} успешно сбросили счет!");
	}
	
	return Plugin_Continue;
}
stock SetClientFrags(index, frags)
{
	SetEntProp(index, Prop_Data, "m_iFrags", frags);
	return 1;
}
stock SetClientDeaths(index, deaths)
{
	SetEntProp(index, Prop_Data, "m_iDeaths", deaths);
	return 1;
}
