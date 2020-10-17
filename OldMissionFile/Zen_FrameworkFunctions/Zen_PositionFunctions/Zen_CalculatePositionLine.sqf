// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_CalculatePositionLine", _this] call Zen_StackAdd;
private ["_area", "_min", "_max", "_water", "_pos", "_i", "_minAngle", "_maxAngle", "_road", "_roadDist", "_exit", "_nearestRoad", "_furthestRoad", "_roads", "_dist", "_iterationCount", "_failures", "_bestPos", "_leastFailures", "_maxFailures", "_center", "_roadPos", "_checkY1", "_checkY2", "_roadX", "_roadY"];

_area = _this select 0;
_min = _this select 1;
_max = _this select 2;
_water = _this select 6;
_road = _this select 7;
_roadDist = _this select 8;
_minAngle = _this select 9;
_maxAngle = _this select 10;
_maxFailures = _this select 28;

_center =+ _area select 0;
0 = [_area, 1, [_min, _max]] call Zen_ArrayInsert;

_max = (abs _max) max (abs _min);
_min = 0;

_leastFailures = 20;
_bestPos = _center;
_pos = [0,0,0];
_exit = false;

if (_road == 2) then {
    _roads = _center nearRoads _max;
    _furthestRoad = [_roads, _center] call Zen_FindMaxDistance;

    if (count _roads > 0) then {
        // _dist = [_furthestRoad, _center] call Zen_Find2dDistance;
        // if (_dist < _min) then {
            // 0 = ["Zen_FindGroundPosition", "No valid position possible, no roads within area", _this] call Zen_PrintError;
            // call Zen_StackPrint;
            // _exit = true;
        // };
    } else {
        0 = ["Zen_FindGroundPosition", "No valid position possible, no roads within area", _this] call Zen_PrintError;
        call Zen_StackPrint;
        _exit = true;
    };
};

if (_exit) exitWith {
    call Zen_StackRemove;
    (_center)
};

if (_water > 0) then {
    if (_water == 1) then {
        _exit = !([_center, _max, "land"] call Zen_IsNearTerrain);
    } else {
        _exit = !([_center, _max, "water"] call Zen_IsNearTerrain);
    };

    if (_exit) then {
        0 = ["Zen_FindGroundPosition", "No valid position possible, water preference impossible", _this] call Zen_PrintError;
        call Zen_StackPrint;
    };
};

if (_exit) exitWith {
    call Zen_StackRemove;
    (_center)
};

_iterationCount = ((((round (((_max^2) - (_min^2)) * (abs (_maxAngle - _minAngle)))) / 225)) max 20) min 1000;
for "_i" from 1 to _iterationCount step 1 do {
    // _pos = [_center,_min,_max,_minAngle,_maxAngle] call Zen_PositionObject;
    _pos = _area call Zen_FindLinePosition;

    if (_road in [1, 2]) then {
        _roads = _pos nearRoads _roadDist;

        {
            if (count _area == 3) then {
                _roadPos = getPosATL _x;
                _roadX = _roadPos select 0;
                _roadY = _roadPos select 1;

                _checkX1 = ((_area select 1) select 0) + (_center select 0);
                _checkX2 = ((_area select 1) select 1) + (_center select 0);
                if !((_roadX >= (_checkX1 min _checkX2)) && {(_roadX <= (_checkX1 max _checkX2))}) then {
                    _roads set [_forEachIndex, 0];
                } else {
                    _checkY1 = ((_roadX - (_center select 0)) call (missionNamespace getVariable (_area select 2))) + (_center select 1);
                    if !(abs (_checkY1 - _roadY) <= 24) then {
                        _roads set [_forEachIndex, 0];
                    };
                };
            } else {
                _roadPos = getPosATL _x;

                _checkX1 = ((_area select 1) select 0) + (_center select 0);
                _checkX2 = ((_area select 1) select 1) + (_center select 0);
                if !((_roadX >= (_checkX1 min _checkX2)) && {(_roadX <= (_checkX1 max _checkX2))}) then {
                    _roads set [_forEachIndex, 0];
                } else {
                    _checkY1 = ((_roadX - (_center select 0)) call (missionNamespace getVariable (_area select 2))) + (_center select 1);
                    _checkY2 = ((_roadX - (_center select 0)) call (missionNamespace getVariable (_area select 3))) + (_center select 1);
                    if !((_roadY <= (_checkY1 max _checkY2) + 12) && {(_roadY >= (_checkY1 min _checkY2) - 12)}) then {
                        _roads set [_forEachIndex, 0];
                    };
                };
            };
        } forEach _roads;

        0 = [_roads, 0] call Zen_ArrayRemoveValue;

        _roadRepeat = _roadDist / 5 * 2;
        for "_i" from 1 to _roadRepeat step 1 do {
            if (count _roads == 0) exitWith {};
            _nearestRoad = [_roads, compile format ["-1 * (_this distanceSqr %1)", _pos]] call Zen_ArrayFindExtremum;
            0 = [_roads, _nearestRoad] call Zen_ArrayRemoveValue;
            // if (([_nearestRoad, _center, [_max, _max], 0, "ellipse"] call Zen_IsPointInPoly)/* && {!([_nearestRoad, _center, [_min, _min], 0, "ellipse"] call Zen_IsPointInPoly)}*/) exitWith {
                _pos = [_nearestRoad] call Zen_ConvertToPosition;
            // };
        };
    };

    _dist = [_center, _pos] call Zen_Find2dDistance;
    if ((_dist <= _max) && (_dist >= _min)) then {
        _this set [0, _center];
        _this set [29, _pos];
        _failures = _this call Zen_CheckPosition;

        if (_failures < _leastFailures) then {
            _bestPos = _pos;
            _leastFailures = _failures;
        };
    };

    if (_leastFailures <= _maxFailures) exitWith {};
    if (_i == _iterationCount) exitWith {
        0 = ["Zen_FindGroundPosition", "No valid position found", _this] call Zen_PrintError;
        call Zen_StackPrint;
    };
};

call Zen_StackRemove;
(_bestPos)
