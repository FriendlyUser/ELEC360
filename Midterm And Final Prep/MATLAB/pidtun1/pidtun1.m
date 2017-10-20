clc
clear all
close all
disp(' Ziegler - Nichols ');
disp('The PID Controller Tuning Method v0.1');
disp('Programmer: S.R.Ahmadzadeh');
disp(' (C) - 2011');
disp('MATLAB 7.10 (R2010a)');
disp('Select a Method First ...');
choice = questdlg('Please choose PID Controller Tuning Method:', ...
    'Ziegler - Nichols PID Controller Tuning Method', ...
    'Method 1 (T,L)','Method 2 (K,P)','Exit','Exit');
% Handle response
switch choice
    case 'Method 1 (T,L)'
        disp('Method 1 Selected.');
        disp([choice ' Enter Parameters :'])
        dessert = 1;
        %break
    case 'Method 2 (K,P)'
        disp('Method 2 Selected.');
        disp([choice ' Enter Parameters :'])
        dessert = 2;
        %break
    case 'Exit'
        disp('Program ended by user.')
        dessert = 0;
end
if dessert==1
    prompt={'Enter the Delay Time (L):',...
        'Enter the Time Constant (T):'};
    name='Inputs for Method 1 (T,L)';
    numlines=1;
    defaultanswer={'1','5'};
    answer=inputdlg(prompt,name,numlines,defaultanswer);
    L=str2double(answer{1,1});
    T=str2double(answer{2,1});
    Con1=[T/L inf 0;0.9*T/L L/.3 0;1.2*T/L 2*L 0.5*L];
    disp(['The Delay Time = ', answer{1,1}]);
    disp(['The Time Constant= ', answer{2,1}]);
elseif dessert==2
    prompt={'Enter the Critical Gain (Kcr):',...
        'Enter the Corresponding Period (Pcr):'};
    name='Inputs for Method 2 (K,P)';
    numlines=1;
    defaultanswer={'10','3'};
    answer=inputdlg(prompt,name,numlines,defaultanswer);
    Kcr=str2double(answer{1,1});
    Pcr=str2double(answer{2,1});
    Con1=[0.5*Kcr inf 0;0.45*Kcr Pcr/1.2 0;0.6*Kcr 0.5*Pcr 0.125*Pcr];
    disp(['The Critical Gain = ', answer{1,1}]);
    disp(['The Corresponding Period= ', answer{2,1}]);
else
    break
end
    disp('calculation Done. Results :');
    disp('///////////////////////////////////////////////////////////');
    disp('The Controller formulation : Gc(S)=Kp*(1+ 1/(Ti*s) + (Td*s))');
    disp('----------------------------------------------------------');
    disp(' Controller Type  |    Kp    |    Ti    |    Td    |');
    disp('----------------------------------------------------------');
    fprintf('%s %d \t %d \t %d \n', '     P            |', Con1(1,1),Con1(1,2),Con1(1,3));
    fprintf('%s %d \t %d \t %d \n', '     PI           |', Con1(2,1),Con1(2,2),Con1(2,3));
    fprintf('%s %d \t %d \t %d \n', '     PID          |', Con1(3,1),Con1(3,2),Con1(3,3));
    disp('----------------------------------------------------------');
    disp('///////////////////////////////////////////////////////////');
    disp('The Controller formulation : Gc(S)=Kp+ Ki/s + Kd*s)');
    disp('----------------------------------------------------------');
    disp(' Controller Type  |    Kp    |    Ki    |    Kd    |');
    disp('----------------------------------------------------------');
    fprintf('%s %d \t %d \t %d \n', '     P            |', Con1(1,1),0,0);
    fprintf('%s %d \t %d \t %d \n', '     PI           |', Con1(2,1),Con1(2,1)/Con1(2,2),0);
    fprintf('%s %d \t %d \t %d \n', '     PID          |', Con1(3,1),Con1(3,1)/Con1(3,2),Con1(3,1)*Con1(3,3));
    disp('----------------------------------------------------------');
    disp('Thank you for using this program.')
