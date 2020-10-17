// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_FindLinePosition", _this] call Zen_StackAdd;
private ["_xRange", "_func1", "_pos", "_func2", "_randX", "_randY1", "_randY2"];

if !([_this, [["VOID"], ["ARRAY"], ["FUNCTION"], ["FUNCTION"]], [[], ["SCALAR"]], 3] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    ([])
};

_center = [(_this select 0)] call Zen_ConvertToPosition;
_xRange = _this select 1;
_func1 = _this select 2;

_pos = [];
if (count _this > 3) then {
    _func2 = _this select 3;

    _randX = _xRange call Zen_FindInRange;
    _randY1 = _randX call (missionNamespace getVariable _func1);
    _randY2 = _randX call (missionNamespace getVariable _func2);

    _pos = _center vectorAdd [_randX, [_randY1, _randY2] call Zen_FindInRange, 0.];
} else {
    _randX = _xRange call Zen_FindInRange;
    _randY1 = _randX call (missionNamespace getVariable _func1);

    _pos = _center vectorAdd [_randX, _randY1, 0.];
};

call Zen_StackRemove;
(_pos)
