function closePort(hObject,handles)
try
    scom = instrfind;
    fclose(scom);
    delete(scom); 
catch
    msgbox('�رմ���ʧ��','����');
end

set(hObject,'BackgroundColor',[0.392,0.831,0.075]);
set(hObject,'string','�򿪴���');
set(handles.txtNotify,'string','��ǰδ���κδ���');
end