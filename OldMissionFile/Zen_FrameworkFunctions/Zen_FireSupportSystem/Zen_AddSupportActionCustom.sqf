// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkLibrary.sqf"

if !(isServer) exitWith {
    ZEN_FMW_MP_REServerOnly("Zen_AddSupportActionCustom", _this, call)
};

_Zen_stack_Trace = ["Zen_AddSupportActionCustom", _this] call Zen_StackAdd;
private ["_units", "_customFunction", "_titleString", "_maxCalls", "_customArgs", "_templateArray", "_args", "_descr"];

if !([_this, [["VOID"], ["FUNCTION"], ["STRING"], ["SCALAR"], ["STRING"], ["VOID"]], [], 4] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    ("")
};

_units = [(_this select 0)] call Zen_ConvertToObjectArray;
_customFunction = _this select 1;
_titleString = _this select 2;
_maxCalls = _this select 3;

ZEN_STD_Parse_GetArgumentDefault(_descr, 4, "")
ZEN_STD_Parse_GetArgumentDefault(_customArgs, 5, "")

if ((count Zen_Fire_Support_Action_Array_Global) == 0) then {
    Zen_Fire_Support_Action_Array_Global pushBack ["Zen_fire_support_action_global_null_init_flag", [], "", "", objNull, "", 0, 0];
    _dialogID = [] call Zen_CreateDialog;

    _controlMap = ["Map", ["Position", [-20, 0]], ["Size", [40,40]], ["MapZoom", 1]] call Zen_CreateControl;
    _controlList = ["List", ["List", []], ["ListData", []], ["Position", [20, 0]], ["Size", [35,11.5]], ["SelectionFunction", "Zen_AddFireSupportAction_DialogListSel_MP"]] call Zen_CreateControl;
    _controlOK = ["Button", ["Text", "Call"], ["Position", [55, 0]], ["Size", [5,2]], ["ActivationFunction", "Zen_AddFireSupportAction_DialogOK_MP"], ["LinksTo", [_controlList]]] call Zen_CreateControl;
    _controlCancel = ["Button", ["Text", "Cancel"], ["Position", [55, 2]], ["Size", [5,2]], ["ActivationFunction", "Zen_AddFireSupportAction_DialogCancel_MP"], ["LinksTo", [_controlList]]] call Zen_CreateControl;
    _controlRefresh = ["Button", ["Text", "Refresh"], ["Position", [55, 4]], ["Size", [5,2]], ["ActivationFunction", "Zen_AddFireSupportAction_DialogRefresh_MP"]] call Zen_CreateControl;
    _controlClose = ["Button", ["Text", "Close"], ["Position", [55, 6]], ["Size", [5,2]], ["ActivationFunction", "Zen_CloseDialog"]] call Zen_CreateControl;
    _controlDesc = ["Text", ["Position", [20, 12]], ["Size", [55,2]], ["Text", ""]] call Zen_CreateControl;

    {
        0 = [_dialogID, _x] call Zen_LinkControl;
    } forEach [_controlOK, _controlCancel, _controlList, _controlDesc, _controlClose, _controlRefresh, _controlMap];

    Zen_Fire_Support_Action_Dialog_Data = [_dialogID, _controlList, _controlDesc, _controlMap];
    publicVariable "Zen_Fire_Support_Action_Dialog_Data";

    if (Zen_AddFireSupportAction_Action_ID == "") then {
        Zen_AddFireSupportAction_Action_ID = ["<t color='#990000'>Fire Support</t>", "Zen_AddFireSupportAction_ShowDialog_MP", [], [1, false, true, "", "((player == _this) && {(({player in (_x select 1)} count Zen_Fire_Support_Action_Array_Global) > 0)})"]] call Zen_CreateAction;
        0 = [Zen_AddFireSupportAction_Action_ID, allUnits] call Zen_InvokeAction;
    };
};

_nameString = format ["Zen_support_custom_action_global_%1",([10] call Zen_StringGenerateRandom)];
Zen_Fire_Support_Action_Array_Global pushBack [_nameString, _units, _titleString, _customFunction, objNull, "", _maxCalls, 0, _descr, true, _customArgs];
publicVariable "Zen_Fire_Support_Action_Array_Global";

_args = [_nameString];
ZEN_FMW_MP_REAll("Zen_AddFireSupportAction_AddLocal_MP", _args, call)

call Zen_StackRemove;
(_nameString)
