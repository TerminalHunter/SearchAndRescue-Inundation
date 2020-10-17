class CfgPatches
{
	class Altis_Tide
	{
		name="Altis TideSystem";
		units[] = {
			"Altis"
		};
		weapons[]={};
		requiredVersion=1.68;
		requiredAddons[]= {
			"D41_Ruegen_Scorched"
		};
		author="nocnico + TerminalHunter";
		url="https://berrytube.tv";
		version="1.0";
		versionStr="1.0";
		versionAr[]={1,0};
	};
};

class CfgWorlds
{
	class CAWorld;
	class d41_ruegen_scorched : CAWorld
	{
		class Sea
		{
			MinTide = 45; // Minimum: How much above Main Sea level?
			MaxTide = 45; // Maximum: How much under Main Sea level?
		};
	};
};
