// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkLibrary.sqf"

if (isDedicated || !hasInterface) exitWith {};

_Zen_stack_Trace = ["Zen_InvokeActionClient", _this] call Zen_StackAdd;
private ["_nameString", "_objs", "_text", "_addActionArgs", "_idsArray", "_id", "_actionDataLocal", "_objsLocal", "_indexesToRemove", "_objsToAdd"];

if !([_this, [["STRING"], ["ARRAY"], ["STRING"], ["ARRAY"]], [], 4] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_nameString = _this select 0;
_objs = _this select 1;
_text = _this select 2;
_addActionArgs = _this select 3;

_actionDataLocal = [_nameString] call Zen_GetActionDataLocal;

if (count _actionDataLocal > 0) then {
    _objsLocal = _actionDataLocal select 1;
    _idsArray = _actionDataLocal select 2;
    _indexesToRemove = [];
    {
        if (isNull _x) then {
            _indexesToRemove pushBack _forEachIndex;
        };
    } forEach _objsLocal;

    ZEN_FMW_Array_RemoveIndexes(_objsLocal, _indexesToRemove)
    ZEN_FMW_Array_RemoveIndexes(_idsArray, _indexesToRemove)
};

_idsArray = [];
_objsToAdd = [];
{
    if ((count _actionDataLocal == 0) || {!(_x in (_actionDataLocal select 1))}) then {
        _id = _x addAction ([_text, Zen_GetActionArguments, _nameString] + _addActionArgs);
        _idsArray pushBack _id;
        _objsToAdd pushBack _x;
    };
} forEach _objs;

if (count _actionDataLocal == 0) then {
    Zen_Action_Array_Local pushBack [_nameString, _objsToAdd, _idsArray];
} else {
    (_actionDataLocal select 1) append _objsToAdd;
    (_actionDataLocal select 2) append _idsArray;
};

call Zen_StackRemove;
if (true) exitWith {};
