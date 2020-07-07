#include <sourcemod>
#include <sdktools>

#define PLUGIN_AUTHOR	"tuty"
#define PLUGIN_VERSION	"1.1"
#pragma semicolon 1

new Handle:gPluginEnabled = INVALID_HANDLE;

public Plugin:myinfo =
{
	name = "Resetscore",
	author = PLUGIN_AUTHOR,
	description = "Type !rs in chat to reset your score.",
	version = PLUGIN_VERSION,
	url = "www.ligs.us"
};
public OnPluginStart()
{
	RegConsoleCmd( "say", CommandSay );
	RegConsoleCmd( "say_team", CommandSay );
	
	gPluginEnabled = CreateConVar( "sm_resetscore", "1" );
	CreateConVar( "resetscore_version", PLUGIN_VERSION, "Reset Score", FCVAR_PLUGIN | FCVAR_SPONLY | FCVAR_REPLICATED | FCVAR_NOTIFY );
}
public Action:CommandSay( id, args )
{
	decl String:Said[ 128 ];
	GetCmdArgString( Said, sizeof( Said ) - 1 );
	StripQuotes( Said );
	TrimString( Said );
	
	if( StrEqual( Said, "!rs" ) || StrEqual( Said, "!restartscore" ) )
	{
		if( GetConVarInt( gPluginEnabled ) == 0 )
		{
			PrintToChat( id, "\x03[SM Resetscore] Плагин отключен!" );
			PrintToConsole( id, "[SM Resetscore] Вы не можете использовать эту команду т.к. плагин отключен!" );
		
			return Plugin_Continue;
		}
	
		if( !IsPlayerAlive( id ) )
		{
			PrintToChat( id, "\x03[SM Resetscore] Вы не можете использовать данную команду т.к. вы мертвы!" );
			PrintToConsole( id, "[SM Resetscore] Только живые могут использовать данную команду!" );
		
			return Plugin_Continue;
		}

		if( GetClientDeaths( id ) == 0 && GetClientFrags( id ) == 0 )
		{
			PrintToChat( id, "\x03[SM Resetscore] Ваш счет и так равен 0!" );
			PrintToConsole( id, "[SM Resetscore] Вы не можете сейчас обнулить счет" );
			
			return Plugin_Continue;
		}
				
		SetClientFrags( id, 0 );
		SetClientDeaths( id, 0 );
	
		decl String:Name[ 32 ];
		GetClientName( id, Name, sizeof( Name ) - 1 );
	
		PrintToChat( id, "\x03[SM Resetscore] Ваш счет сброшен!" );
		PrintToChatAll( "\x03[SM Resetscore] \x04%s\x03 обнулил свой счет.", Name );
		PrintToConsole( id, "[SM Resetscore] Ваш счет сброшен." );
	}
	
	return Plugin_Continue;
}	 
stock SetClientFrags( index, frags )
{
	SetEntProp( index, Prop_Data, "m_iFrags", frags );
	return 1;
}
stock SetClientDeaths( index, deaths )
{
	SetEntProp( index, Prop_Data, "m_iDeaths", deaths );
	return 1;
}
