function bytes(obj,~,handles)
str = fgetl(obj);
oldData = get(handles.tblShowData,'Data');
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
if (strcmp(Stop(1:4),'STOP') && strcmp(Start,'START'))
    Iffull = '����';
    Stop = 'STOP';
else
    Iffull = '������';
end
add = '';
% ����������ݽ����
newRow = {Start,Address,PositionLatStr,PositionLonStr,myTime,...
    TriggerTime,Power,Stop,Iffull,add};
newData = [oldData; newRow];
% �������ݽ�������
newData = sortrows(newData,2,'descend');
set(handles.tblShowData,'Data',newData);
end

