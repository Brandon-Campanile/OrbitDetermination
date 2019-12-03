%% Venus Orbit GNC
clc; clear; close all;
variables = struct('e',[0 .99 .1],'i',[65 90 5],'AoP',[0 360 36],'RAAN',[0 360 36]); % {'variable',[min max stepsize],...}
%% Launch STK
tic
try
    % Grab an existing instance of STK
    uiapp = actxGetRunningServer('STK11.application');
    %Attach to the STK Object Model
    root = uiapp.Personality2;
    checkempty = root.Children.Count;
    if checkempty == 0
        %If a Scenario is not open, create a new scenario
        uiapp.visible = 1;
        root.NewScenario('VenusOrbit');
        scenario = root.CurrentScenario;
    else
        %If a Scenario is open, prompt the user to accept closing it or not
        rtn = questdlg({'Close the current scenario?',' ','(WARNING: If you have not saved your progress will be lost)'});
        if ~strcmp(rtn,'Yes')
            return
        else
            root.CurrentScenario.Unload
            uiapp.visible = 1;
            root.NewScenario('VenusOrbit');
            scenario = root.CurrentScenario;
        end
    end

catch
    % STK is not running, launch new instance
    % Launch a new instance of STK11 and grab it
    uiapp = actxserver('STK11.application');
    root = uiapp.Personality2;
    uiapp.visible = 1;
    root.NewScenario('VenusOrbit');
    scenario = root.CurrentScenario;
end
toc
%%  Initialize Scenario
Start = '16 Apr 2027 00:00:00.000';
Stop = '16 Apr 2030 00:00:00.000';
scenario.SetTimePeriod(Start,Stop);
scenario.Start = Start;
scenario.Stop = Stop;
root.Rewind();
Red = '0000ff';
Green = '00ff00';
Blue = 'ff0000';
Cyan = 'ffff00';
Yellow = '00ffff';
Magenta = 'ff00ff';
Black = '000000';
White = 'ffffff';
Earth = scenario.Children.New('ePlanet','Earth');
Venus = scenario.Children.New('ePlanet','Venus');
Sun = scenario.Children.New('ePlanet','Sun');
%% Create DSN facilities
facility1 = scenario.Children.New('ePlace','Goldstone');
facility1.Position.AssignGeodetic(35.426667, -116.89,0);
facility2 = scenario.Children.New('ePlace','Madrid');
facility2.Position.AssignGeodetic(40.429167, -4.249167,0);
facility3 = scenario.Children.New('ePlace','Canberra');
facility3.Position.AssignGeodetic(-35.401389, 148.981667,0);
%% Group DSN facilities
DSN = scenario.Children.New('eConstellation','DSN');
DSN.Objects.AddObject(facility1);
DSN.Objects.AddObject(facility2);
DSN.Objects.AddObject(facility3);
%% Create Satellite
sat = scenario.Children.New('eSatellite','VenusSAT');
sat.SetPropagatorType('ePropagatorAstrogator')
ASTG = sat.Propagator;
MCS = ASTG.MainSequence;
MCS.RemoveAll;
%% Creates Sensor(antenna) for VenusSat
antenna = sat.Children.New('eSensor','Antenna');
antenna.Pattern.ConeAngle = 1.25; % deg
antenna.SetPointingType('eSnPtTargeted')
antenna.Pointing.BoresightData.TrackMode='eTrackModeTransmit';
antenna.Graphics.Color=uint32(hex2dec(Magenta));
antenna.VO.PercentTranslucency=50;
antenna.Pointing.Targets.Add('Constellation/DSN')
%% Add a Chain of when VenusSat can communicate with the DSN
Comms = scenario.Children.New('eChain','Comms');
Comms.Objects.AddObject(antenna)
Comms.Objects.AddObject(DSN)
%% MCS Initial State
MCS.Insert('eVASegmentTypeInitialState','Venus Initial','-'); % Add initial state to MCS

initstate = MCS.Item('Venus Initial');
initstate.CoordSystemName='CentralBody/Venus Inertial';
initstate.OrbitEpoch = scenario.StartTime;
initstate.SetElementType('eVAElementTypeKeplerian');
initstate.Element.PeriapsisAltitudeSize = 1000;
initstate.Element.Eccentricity = .9;
initstate.Element.Inclination = 90;
initstate.Element.RAAN = 0;
initstate.Element.ArgOfPeriapsis = 0;

%% Create Venus Propagator
%Get the Propagators Folder
compBrowser = scenario.ComponentDirectory.GetComponents('eComponentAstrogator').GetFolder('Propagators');
%Grab the Earth HPOP propagator
Earth = compBrowser.Item('Earth HPOP Default v10');
%Make a copy of the propagator to Edit it
Earth.CloneObject;

%Grab a handle of the new Venus propagator and edit properties
venusProp = compBrowser.Item('Earth HPOP Default v101');
venusProp.CentralBodyName='Venus';
venusProp.Name = 'Venus HPOP Default v10';
venusProp.PropagatorFunctions.Remove('Moon')
venusProp.PropagatorFunctions.Add('Atmospheric Models/Exponential - Venus')

%% MCS Propagate to Apoapsis
propagate = MCS.Insert('eVASegmentTypePropagate','toApoapsis','-'); % Add propagate to MCS

propagate.Properties.Color = uint32(hex2dec(Green));
propagate.PropagatorName = 'Venus HPOP Default v10';
propagate.StoppingConditions.Add('Apoapsis');
propagate.StoppingConditions.Item('Apoapsis').Properties.CentralBodyName='Venus';
propagate.StoppingConditions.Remove('Duration');

%% Target Sequence to Enter Atmosphere
% Set up target sequence:
ts = MCS.Insert('eVASegmentTypeTargetSequence','Lower Periapsis','-');
dv1 = ts.Segments.Insert('eVASegmentTypeManeuver','Burn 1','-');
dv1.Properties.Color = uint32(hex2dec(White));
dv1.SetManeuverType('eVAManeuverTypeImpulsive');
impulsive = dv1.Maneuver;
impulsive.SetAttitudeControlType('eVAAttitudeControlAntiVelocityVector');

% Enable target sequence variable:
dv1.EnableControlParameter('eVAControlManeuverImpulsiveSphericalMag');
% Segment Results, which can be used as targeter goals, are also stored in a collection
dv1.Results.Add('Keplerian Elems/Altitude_of_Periapsis');
dv1.Results.Item('Altitude_Of_Periapsis').CentralBodyName='Venus';

%Setup differential corrector:
dc = ts.Profiles.Item('Differential Corrector');
dvControl = dc.ControlParameters.GetControlByPaths('Burn 1', 'ImpulsiveMnvr.Spherical.Magnitude');
dvControl.Enable = true;
dvControl.MaxStep = 2;
aopResult = dc.Results.GetResultByPaths('Burn 1', 'Altitude_Of_Periapsis');
aopResult.Enable = true;
aopResult.DesiredValue = 400;
aopResult.Tolerance = 0.1;

% Set final DC and targeter properties and run modes
dc.MaxIterations = 100;
dc.EnableDisplayStatus = true;
dc.Mode = 'eVAProfileModeIterate';
ts.Action = 'eVATargetSeqActionRunActiveProfiles';

%% Aerobrake: Propagate to Lower Orbit 

propagate2 = MCS.Insert('eVASegmentTypePropagate','Aerobrake','-');
propagate2.Properties.Color = uint32(hex2dec(Cyan));
propagate2.PropagatorName = 'Venus HPOP Default v10';
propagate2.StoppingConditions.Add('Apoapsis');
propagate2.StoppingConditions.Item('Apoapsis').Properties.CentralBodyName='Venus';
propagate2.StoppingConditions.Remove('Duration');


const = propagate2.StoppingConditions.Item('Apoapsis').Properties.Constraints.Add('UserDefined');
const.CalcObjectName='Eccentricity';
const.CalcObject.CentralBodyName='Venus';
const.Criteria='eVACriteriaLessThan';
const.Value=0.1;
const.Tolerance=0.01;

%%
ts2 = MCS.Insert('eVASegmentTypeTargetSequence','Raise Periapsis','-');
dv2 = ts2.Segments.Insert('eVASegmentTypeManeuver','Burn 2','-');
dv2.Properties.Color = uint32(hex2dec(White));
dv2.SetManeuverType('eVAManeuverTypeImpulsive');
impulsive2 = dv2.Maneuver;
impulsive2.SetAttitudeControlType('eVAAttitudeControlVelocityVector');

% Enable target sequence variable:
dv2.EnableControlParameter('eVAControlManeuverImpulsiveSphericalMag');
% Segment Results, which can be used as targeter goals, are also stored in a collection
dv2.Results.Add('Keplerian Elems/Altitude_of_Periapsis');
dv2.Results.Item('Altitude_Of_Periapsis').CentralBodyName='Venus';

%Setup differential corrector:
dc2 = ts2.Profiles.Item('Differential Corrector');
dvControl2 = dc2.ControlParameters.GetControlByPaths('Burn 2', 'ImpulsiveMnvr.Spherical.Magnitude');
dvControl2.Enable = true;
dvControl2.MaxStep = 2;
aopResult2 = dc2.Results.GetResultByPaths('Burn 2', 'Altitude_Of_Periapsis');
aopResult2.Enable = true;
aopResult2.DesiredValue = 500;
aopResult2.Tolerance = 0.1;

% Set final DC and targeter properties and run modes
dc2.MaxIterations = 100;
dc2.EnableDisplayStatus = true;
dc2.Mode = 'eVAProfileModeIterate';
ts2.Action = 'eVATargetSeqActionRunActiveProfiles';

%%
propagate3 = MCS.Insert('eVASegmentTypePropagate','Venus Orbit','-');
propagate3.Properties.Color = uint32(hex2dec(Red));
propagate3.PropagatorName = 'Venus HPOP Default v10';
propagate3.StoppingConditions.Item('Duration').Properties.Trip=5*365*24*3600;

%%



ASTG.RunMCS;

if exist('variables', 'var') && round(length(variables)/2)~=length(variables)/2
    error('Input argument needs propertyName/propertyValue pairs')
end
defvariables = struct('e',[0 .99 .1],'i',[65 90 5],'AoP',[0 360 36],'RAAN',[0 360 36]); % {'variable',[min max stepsize],...}
if exist('variables', 'var')
    for pair = reshape(variables,2,[])
        inpName = lower(pair{1});
        if any(strcmp(inpName,fieldnames(defvariables)))
            defvariables.(inpName) = pair{2};
        else
            error('%s is not a recognized parameter name',inpName)
        end
    end
end

X = fieldnames(variables);
Range_e=variables.(X{1})(1):variables.(X{1})(3):variables.(X{1})(2);
Range_i=variables.(X{2})(1):variables.(X{2})(3):variables.(X{2})(2);
Range_AoP=variables.(X{3})(1):variables.(X{3})(3):variables.(X{3})(2);
Range_RAAN=variables.(X{4})(1):variables.(X{4})(3):variables.(X{4})(2);
NumberOfIterations_e = length(Range_e);
NumberOfIterations_i = length(Range_i);
NumberOfIterations_AoP = length(Range_AoP);
NumberOfIterations_RAAN = length(Range_RAAN);
TotalNumberOfIterations = NumberOfIterations_e*NumberOfIterations_i*NumberOfIterations_AoP*NumberOfIterations_RAAN;
TotalDuration = 0;
for e_index = 1:NumberOfIterations_e
    for AoP_index = 1:NumberOfIterations_AoP
        for RAAN_index = 1:NumberOfIterations_RAAN
            initstate.Element.Eccentricity = Range_e(e_index);
            initstate.Element.Inclination = Range_i(i_index);
            initstate.Element.ArgOfPeriapsis = Range_AoP(AoP_index);
            initstate.Element.RAAN = Range_RAAN(RAAN_index);
            
            accessDP = Comms.DataProviders.Item('Complete Access').Exec(scenario.StartTime,scenario.StopTime);
            try
                accessDuration = accessDP.DataSets.GetDataSetByName('Duration').GetValues;
            catch
                accessDuration = {0};
            end
            prevDuration = TotalDuration;
            TotalDuration = sum(cell2mat(accessDuration)); % seconds?
            if TotalDuration > prevDuration
                W=[Range_e(e_index), Range_i(i_index), Range_AoP(AoP_index), Range_RAAN(RAAN_index), TotalDuration];
            end
        end
    end
end
disp(['Iterations: ' num2str(TotalNumberOfIterations)]);
