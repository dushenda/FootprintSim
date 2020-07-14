function varargout = SerialsCommunicationGUI(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SerialsCommunicationGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @SerialsCommunicationGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

% ��ʱ����ɵĲ�������~~
function SerialsCommunicationGUI_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to simple_g(see VARARGIN)
handles.output = hObject;
warning off all;
javaFram = get(hObject,'JavaFrame');
javaFram.setFigureIcon(javax.swing.ImageIcon('./img/icon.png'));
set(handles.tblShowData,'ColumnWidth',{120});
data = get(handles.tblShowData,'Data');
if ~isempty(data)
data(1:4,:) = [];
set(handles.tblShowData,'Data',data);
end
set(handles.tblShowData,'RearrangeableColumns','on');
% ���ݶ˿ںͲ�������������
str = get(handles.mnChoosePort, 'String');
val = get(handles.mnChoosePort,'Value');
% �ж�ѡ���ĸ��˿�
handles.port_data = getPort(str{val});
str = get(handles.mnChooseBaud, 'String');
val = get(handles.mnChooseBaud,'Value');
% �ж�ѡ���ĸ�������
handles.baud_data = getBaud(str{val});
handles.scom=serial('COM1');    % ���ö˿�
% ��ʾʱ�䣬���ö�ʱ�����ԣ�ÿ�봥������ dispTime����
handles.timer =  timer('Period',1,'TimerFcn',{@dispTime,handles},...
    'BusyMode','queue','ExecutionMode','fixedRate');
start(handles.timer);
handles.hasData = 0;
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = SerialsCommunicationGUI_OutputFcn(hObject, eventdata, handles) 
% ���������������
varargout{1} = handles.output;



function btnOpenClosePort_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of btnOpenClosePort
val = get(hObject,'value');                   
if val==1            % ���ڴ�״̬����ʾ�ر��ַ�
delete(instrfindall)                            % �ر�ǰ��ռ�õĶ˿ڣ�������Ҫ 
handles.scom = serial(handles.port_data);       % �½�����
set(handles.scom,'BaudRate',handles.baud_data); % ���ò�����
set(handles.scom,'BytesAvailableFcnCount',69);
set(handles.scom,'BytesAvailableFcnMode','byte');
set(handles.scom,'BytesAvailableFcn',{@bytes,handles});
try                                             % �쳣��׽
    fopen(handles.scom);
catch
    msgbox('��������ʧ��','����');
    set(hObject,'value',0);
    handles.val=get(hObject,'val');
    return;
end
set(hObject,'BackgroundColor',[1,0,0]);
set(hObject,'string','�رմ���');
set(handles.txtNotify,'string',['�����',handles.port_data,'�˿�,',...
                                '������Ϊ',num2str(handles.baud_data)]);
else
closePort(hObject,handles);
end
guidata(hObject, handles);


% --- Executes on button press in btnSaveFile.
function btnSaveFile_Callback(hObject, eventdata, handles)
[FileName,PathName] = uiputfile({'*.txt';'*.csv'},...
    '��������','��������.txt');
Data = get(handles.tblShowData,'Data');
DataTable = cell2table(Data);
VarName = {'Start','Address','Latitude','Longitude','UTCTime',...
            'TriggerTime','Power','End','DataIntegrity','Addition'};
DataTable.Properties.VariableNames = VarName;
file = strcat(PathName,FileName);
writetable(DataTable,file);
% 2019a�汾��������� writecell
% writecell(Data,file,'Delimiter',',')


% --- Executes on selection change in mnChoosePort.
function mnChoosePort_Callback(hObject, ~, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns mnChoosePort contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mnChoosePort
str = get(hObject, 'String');
val = get(hObject,'Value');
% �ж�ѡ���ĸ��˿�
handles.port_data = getPort(str{val});
% �������ṹ
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function mnChoosePort_CreateFcn(hObject, eventdata, handles)
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in mnChooseBaud.
function mnChooseBaud_Callback(hObject, eventdata, handles)
% hObject    handle to mnChooseBaud (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns mnChooseBaud contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mnChooseBaud
str = get(hObject, 'String');
val = get(hObject,'Value');
% �ж�ѡ���ĸ�������
handles.baud_data = getBaud(str{val});
% �������ṹ
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function mnChooseBaud_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mnChooseBaud (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function figSerialComm_CreateFcn(hObject, eventdata, handles)

function dispTime(hObject, evendata, handles)
set(handles.txtTime,'String',datestr(now));


% --- Executes when user attempts to close figSerialComm.
function figSerialComm_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figSerialComm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
% delete(handles.timer);
t = timerfind;
if ~isempty(t)
    stop(t);
    delete(t);
end
delete(hObject);






