//requires single argument, target
//script intends to give target a small non-life-threatening injury.
//untreated, the injury should be lethal after about an hour
//usage:
//null = [thingToHurt] execVM "hurtMe.sqf";
//
//also, to hurt all civilians in a trigger:
//{  
//if (side _x == civilian) then {null = [_x] execVM "hurtMe.sqf";}; 
//}forEach allUnits inAreaArray thisTrigger;
//
_partHit = selectRandom ["leg_l", "leg_r", "hand_r", "hand_l", "body", "head"];
_howHit = selectRandom ["stab","vehicleCrash"];
_target = _this select 0;
[_target, 0.33, _partHit, _howHit] call ace_medical_fnc_addDamageToUnit;
[_target] call ace_medical_fnc_handleDamage_advancedSetDamage;