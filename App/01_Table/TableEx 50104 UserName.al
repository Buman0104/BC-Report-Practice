tableextension 50104 SalesHeaderEx extends "Sales Header"
{
    fields
    {
        field(50110; "Create User ID"; Code[50])
        {
            CaptionML = CHT = '建立帳號', ENU = 'Create User ID';
            DataClassification = CustomerContent;
        }
        field(50111; "Modify User ID"; Code[50])
        {
            CaptionML = CHT = '修改人員', ENU = 'Modify User ID';
            DataClassification = CustomerContent;
        }
    }

    trigger OnInsert()
    begin
        "Create User ID" := UserId;
    end;

    trigger OnModify()
    begin
        "Modify User ID" := UserId;
    end;
}
