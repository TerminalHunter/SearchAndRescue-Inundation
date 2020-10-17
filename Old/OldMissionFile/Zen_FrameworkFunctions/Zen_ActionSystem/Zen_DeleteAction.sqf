// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkLibrary.sqf"

if !(isServer) exitWith {
    ZEN_FMW_MP_REServerOnly("Zen_DeleteAction", _this, call)
};

_Zen_stack_Trace = ["Zen_DeleteAction", _this] call Zen_StackAdd;
private ["_nameString", "_actionData", "_unitsToRemove", "_allUnits", "_actionArray", "_args"];

if !([_this, [["STRING"], ["VOID"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_nameString = _this select 0;

_actionData = [_nameString] call Zen_GetActionDataGlobal;
_globalObjs = [(_actionData select 5), false] call Zen_ArrayRemoveDead;

if (count _this > 1) then {
    _unitsToRemove = [(_this select 1)] call Zen_ConvertToObjectArray;
    _allUnits = [_globalObjs - _unitsToRemove] call Zen_ArrayRemoveDuplicates;
} else {
    _unitsToRemove = [_globalObjs] call Zen_ArrayRemoveDuplicates;
    _allUnits = [];
};

{
    if (toUpper (_x select 0) isEqualTo toUpper _nameString) exitWith {
        _actionArray = _x;
    };
} forEach Zen_Action_Array_Server;

_actionArray set [5, _allUnits];
_args = [_nameString, _unitsToRemove];
ZEN_FMW_MP_REAll("Zen_DeleteActionClient", _args, call)

call Zen_StackRemove;
if (true) exitWith {};
