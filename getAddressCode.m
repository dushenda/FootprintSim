function AddressCode = getAddressCode(AddressCodeBefore)
Head = AddressCodeBefore(1);
Head = strcat(Head,'��');
Num = AddressCodeBefore(2:end);
Num = strcat(Num,'��');
AddressCode = strcat(Head,Num);
end