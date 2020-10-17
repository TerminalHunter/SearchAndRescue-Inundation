#include "Zen_FrameworkFunctions\Zen_InitHeader.sqf"

//Fuck Grass.
setTerrainGrid 50;

//Set the viewdistance
[6000,2500] call Zen_SetViewDistance;

//Forced Decrewing Script - Because Opioid Abuse is bad.
_decrewAction = ["ForceDecrew","Force Crew Out of Vehicle","",{[90, _target, {{_dude = _x select 0;doGetOut _dude;}forEach fullCrew (_this select 0);},{}, "Fighting Crew"] call ace_common_fnc_progressBar;},{true}] call ace_interact_menu_fnc_createAction;
["LandVehicle", 0, ["ACE_MainActions"], _decrewAction, true] call ace_interact_menu_fnc_addActionToClass;

// This will fade in from black, to hide jarring actions at mission start, this is optional and you can change the value. I don't know why I included this here, it was part of Zenophon's Framework.
titleText ["Mission Initializing - Hold on for a second, you drunk fucks.", "BLACK FADED", 0.5];
// Some functions may not continue running properly after loading a saved game, do not delete this line
enableSaving [false, false];
// All clients stop executing here, do not delete this line
if (!isServer) exitWith {};
// Execution stops until the mission begins (past briefing), do not delete this line
sleep 1;

//Mission scripts

//UN Vehicle Spawns
//putbus patrol is little more hardcoded since that one road is tiny
_FirstPosition = ["UNobj01", [0,500]] call Zen_FindGroundPosition;
_RepTruck = [_FirstPosition,"CUP_I_Ural_Repair_UN",0,180] call Zen_SpawnVehicle;
_RepTruck setFuel 0;

_SecondPosition = ["UNobj02", [0,50]] call Zen_FindGroundPosition;
_RepAPC = [_SecondPosition,"CUP_I_BMP2_AMB_UN",0,180] call Zen_SpawnVehicle;
_RepAPC setFuel 0;

//list of UN vics to choose from
_UNvics = ["CUP_I_Ural_Repair_UN","CUP_I_BMP2_AMB_UN","CUP_I_Ural_UN","rhsgref_un_zil131_flatbed","rhsgref_un_uaz"];

//actually, I'm just lazy. hardcoding for everyone, I only have to do 20 of these max
//Kamitz patrol of 3
_Kamitz = ["UNobj06","UNobj04","UNobj03"];
_KamitzPos01 = [selectRandom _Kamitz, [0,500]] call Zen_FindGroundPosition;
_KamitzCar01 = [_KamitzPos01,selectRandom _UNvics,0,180] call Zen_SpawnVehicle;
_KamitzCar01 setFuel 0;
_KamitzPos02 = [selectRandom _Kamitz, [0,500]] call Zen_FindGroundPosition;
_KamitzCar02 = [_KamitzPos02,selectRandom _UNvics,0,180] call Zen_SpawnVehicle;
_KamitzCar02 setFuel 0;
//this one always spawns since it's close to the road to evac zone B
_KamitzPos03 = ["UNobj05", [0,250]] call Zen_FindGroundPosition;
_KamitzCar03 = [_KamitzPos03,selectRandom _UNvics,0,180] call Zen_SpawnVehicle;
_KamitzCar03 setFuel 0;

//seebad patrol of 1
_seebad = ["UNobj20","UNobj21"];
_seebadPos01 = [selectRandom _seebad, [0,500]] call Zen_FindGroundPosition;
_seebadCar01 = [_seebadPos01,selectRandom _UNvics,0,180] call Zen_SpawnVehicle;
_seebadCar01 setFuel 0;

//Bergen patrol of 3
_bergen = ["UNobj07","UNobj08","UNobj09","UNobj10","UNobj11"];
_bergenPos01 = [selectRandom _bergen, [0,500]] call Zen_FindGroundPosition;
_bergenPos02 = [selectRandom _bergen, [0,500]] call Zen_FindGroundPosition;
_bergenPos03 = [selectRandom _bergen, [0,500]] call Zen_FindGroundPosition;
_bergenCar01 = [_bergenPos01,selectRandom _UNvics,0,180] call Zen_SpawnVehicle;
_bergenCar02 = [_bergenPos02,selectRandom _UNvics,0,180] call Zen_SpawnVehicle;
_bergenCar03 = [_bergenPos03,selectRandom _UNvics,0,180] call Zen_SpawnVehicle;
_bergenCar01 setFuel 0;
_bergenCar02 setFuel 0;
_bergenCar03 setFuel 0;

//sagard patrol of 2
_sagard = ["UNobj12","UNobj13","UNobj14","UNobj15"];
_sagardPos01 = [selectRandom _sagard, [0,250]] call Zen_FindGroundPosition;
_sagardPos02 = [selectRandom _sagard, [0,250]] call Zen_FindGroundPosition;
_sagardCar01 = [_sagardPos01,selectRandom _UNvics,0,180] call Zen_SpawnVehicle;
_sagardCar02 = [_sagardPos02,selectRandom _UNvics,0,180] call Zen_SpawnVehicle;
_sagardCar01 setFuel 0;
_sagardCar02 setFuel 0;

//neuenkirchen patrol of 1
_nuenkirchen = ["UNobj18", "UNobj19"];
_nuenkirchenPos = [selectRandom _nuenkirchen, [0,500]] call Zen_FindGroundPosition;
_nuenkirchenCar = [_nuenkirchenPos,selectRandom _UNvics,0,180] call Zen_SpawnVehicle;
_nuenkirchenCar setFuel 0;

//dranske patrol of 1
_dranskePos = ["UNobj16", [0,500]] call Zen_FindGroundPosition;
_dranskeCar = [_dranskePos,selectRandom _UNvics,0,180] call Zen_SpawnVehicle;
_dranskeCar setFuel 0.05;

//Kloster patrol of 1

_klosterPos = ["UNobj17", [0,250]] call Zen_FindGroundPosition;
_klosterCar = [_klosterPos,selectRandom _UNvics,0,180] call Zen_SpawnVehicle;
_klosterCar setFuel 0;

//brand patrol of 1

_brandPos = ["UNobj22", [0,500]] call Zen_FindGroundPosition;
_brandCar = [_brandPos,selectRandom _UNvics,0,180] call Zen_SpawnVehicle;
_brandCar setFuel 0;