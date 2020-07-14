clear;clc;
delete(instrfindall) % �ر�ǰ��ռ�õĶ˿ڣ�������Ҫ 
%% �Ӵ��ڶ�ȡ����
s = serial('COM2');  % ���ö˿�Ϊ COM2
set(s,'BaudRate',9600); % ���ò�����Ϊ 9600
fopen(s);            % �򿪶˿�
% ��ȡ���ݲ�������Ԫ������ A
for i=1:1:5
fprintf(s,'*IDN?');
out = fscanf(s);
A(i)=cellstr(out);
disp(out)
end
fclose(s);
delete(s)
clear s
%% �������ݣ���Ҫ����ȡԪ��������
str = 'START,A017,3031.07100N,10404.00096E,181213101431,658038464,0295,STOP';
% ������ʽ�ָ�����
strCell = regexp(str,',','split');
Start = strCell{1};
Address = getAddressCode(strCell{2});
[PositionLatStr,~] = getLatitude(strCell{3});
[PositionLonStr,~] = getLongitude(strCell{4});
myTime = datestr(getTime(strCell{5}));
TriggerTime = getTriggerTime(strCell{6});
Power = getPower(strCell(7));
Stop = strCell{8};
if (strcmp(Stop,'STOP') && strcmp(Start,'START'))
    Iffull = '����';
end
add = '';
msg = {Start,Address,PositionLatStr,PositionLonStr,myTime,...
    TriggerTime,Power,Stop,Iffull,add};

ACell = regexp(A,',','split');
DataCellArr = vertcat(ACell{:});
DataTable = cell2table(DataCellArr);
VarName = {'Start','Address','Latitude','Longitude','UTCTime',...
            'TriggerTime','Power','End'};
DataTable.Properties.VariableNames = VarName;
% ��ȡ����ԭʼ����ת��Ϊ���õ���Ϣ
DataTable.Address = cellfun(@getAddressCode,DataTable.Address,...
                            'UniformOutput',false);
[PositionLatStr,PositionLatNum] = cellfun(@getLatitude,DataTable.Latitude,...
                                            'UniformOutput',false);
DataTable.Latitude = PositionLatStr;                                        
[PositionLonStr,PositionLonNum] = cellfun(@getLongitude,DataTable.Longitude,...
                                          'UniformOutput',false);
DataTable.Longitude = PositionLatStr;                                      
DataTable.UTCTime = cellfun(@getTime,DataTable.UTCTime,...
                            'UniformOutput',false);
DataTable.TriggerTime = cellfun(@getTriggerTime,DataTable.TriggerTime,...
                                'UniformOutput',false);
DataTable.Power = cellfun(@getPower,DataTable.Power,...
                          'UniformOutput',false);
% else
%     disp('data is not security');
% end

%% ��ʾ����
% f = uifigure;
% f.Name = '��������';
% t = uitable(f,'Data',[1 2 3; 4 5 6; 7 8 9]);
% t.FontSize = 10;


%% ���㴦��