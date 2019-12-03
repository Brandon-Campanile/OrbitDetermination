%% Venus Orbit GNC
clc; clear; close all;

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
        root.Load('C:\Users\HAL - 9000\Dropbox\GT\Fall 2019\AE 4342\Project\VenusOrbit\VenusOrbit.sc')
        scenario = root.CurrentScenario;
    else
        %If a Scenario is open, prompt the user to accept closing it or not
        rtn = questdlg({'Close the current scenario?',' ','(WARNING: If you have not saved your progress will be lost)'});
        if ~strcmp(rtn,'Yes')
            return
        else
            root.CurrentScenario.Unload
            uiapp.visible = 1;
            root.Load('C:\Users\HAL - 9000\Dropbox\GT\Fall 2019\AE 4342\Project\VenusOrbit\VenusOrbit.sc')
            scenario = root.CurrentScenario;
        end
    end

catch
    % STK is not running, launch new instance
    % Launch a new instance of STK11 and grab it
    uiapp = actxserver('STK11.application');
    root = uiapp.Personality2;
    uiapp.visible = 1;
    root.Load('C:\Users\HAL - 9000\Dropbox\GT\Fall 2019\AE 4342\Project\VenusOrbit\VenusOrbit.sc')
    scenario = root.CurrentScenario;
end
toc

%% Orbit decay rate
sat2=scenario.Children.Item('decaySat');
MCS2 = sat2.Propagator.MainSequence;
startAlt = 500; %km
finAlt = 600; %km
tol=5;
time=zeros(length(startAlt:tol:finAlt),1);

for i=0:(finAlt-startAlt)/tol
    MCS2.Item('Initial State').Element.PeriapsisAltitudeSize=i*tol+startAlt;
    
    sat2.Propagator.RunMCS;
    satStart= sat2.Vgt.Events.Item('AvailabilityStartTime');
    satStop= sat2.Vgt.Events.Item('AvailabilityStopTime');
    start_time = datetime(satStart.FindOccurrence.Epoch, 'Format','dd MMM yyyy HH:mm:ss.SSS');
    stop_time = datetime(satStop.FindOccurrence.Epoch, 'Format','dd MMM yyyy HH:mm:ss.SSS');
    time(i+1,1) = days(stop_time-start_time);
    disp(i)
end
    

%% Main: Find min delta-V for maneuvers
sat=scenario.Children.Item('minAltSat');
MCS = sat.Propagator.MainSequence;
MCS.Item('Propagate').StoppingConditions.Item('Epoch').Properties.Trip='07 Apr 2030 00:00:00.000';

minTrigAlt=350;
minalt=415;
maxalt=515;
tol=5; % tolerance

result=zeros(5,length(minalt:tol:maxalt));

for i=0:(maxalt-minalt)/tol
    targetAlt=i*tol+minalt;
    result(1,i+1)=targetAlt;
    sat.Propagator.AutoSequence.Item('TCM').Sequence.Item('Target Sequence').Profiles.Item('Differential Corrector').Results.Item(0).DesiredValue=targetAlt;
    sat.Propagator.AutoSequence.Item('TCM').Sequence.Item('Target Sequence1').Profiles.Item('Differential Corrector').Results.Item(0).DesiredValue=targetAlt;
    MCS.Item('Venus Initial').Element.PeriapsisAltitudeSize=targetAlt;
    triggerAlt=zeros(4,length(minTrigAlt:tol:targetAlt));
    
    for ii=0:length(triggerAlt)
        trigAlt=ii*tol+minTrigAlt;
        triggerAlt(1,ii+1)=trigAlt;
        sat.Propagator.AutoSequence.Item('TCM').Sequence.Item('Target Sequence1').ResetProfiles
        sat.Propagator.AutoSequence.Item('TCM').Sequence.Item('Target Sequence').ResetProfiles
        MCS.Item('Propagate').StoppingConditions.Item('Altitude').Properties.Trip=trigAlt;
        sat.Propagator.RunMCS;
        satStart= sat.Vgt.Events.Item('AvailabilityStartTime');
        satStop= sat.Vgt.Events.Item('AvailabilityStopTime');
        start_time = datetime(satStart.FindOccurrence.Epoch, 'Format','dd MMM yyyy HH:mm:ss.SSS');
        stop_time = datetime(satStop.FindOccurrence.Epoch, 'Format','dd MMM yyyy HH:mm:ss.SSS');
        triggerAlt(2,ii+1) = days(stop_time-start_time);
        x=sat.DataProviders.Item('Maneuver Summary');
        elems={'Delta V';'Fuel Used'};
        data=x.ExecElements(satStart,satStop,elems);
        alt=sat.DataProviders.Item('LLA State').Group.Item('Fixed').ExecElements(satStart,satStop,60,{'Alt'}).DataSets.GetDataSetByName('Alt').GetValues;
        if any([alt{:}]<(minTrigAlt-50))
            triggerAlt(3,ii+1)=NaN;
            triggerAlt(4,ii+1)=NaN;
        else
            if data.DataSets.Count==2
                dV=data.DataSets.GetDataSetByName('Delta V').GetValues;
                dF=data.DataSets.GetDataSetByName('Fuel Used').GetValues;
                triggerAlt(3,ii+1)=sum([dV{:}]);
                triggerAlt(4,ii+1)=sum([dF{:}]);
            elseif any(ismember(data.DataSets.ElementNames,'Delta V'))
                dV=data.DataSets.GetDataSetByName('Delta V').GetValues;
                triggerAlt(3,ii+1)=sum([dV{:}]);
                triggerAlt(4,ii+1)=NaN;
            else
                triggerAlt(3,ii+1)=NaN;
                triggerAlt(4,ii+1)=NaN;
            end
        end
    end
    
    [~, I]=min(triggerAlt(3,:)>0);
    result(2:end,i+1)=triggerAlt(:,I);
    save resFile.mat result
end

%%
uiApplication.Quit;
clear uiApplication root
