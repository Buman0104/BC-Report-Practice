table 50125 Subject
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(2; Name; Text[100])
        {
            DataClassification = CustomerContent;

        }
        field(3; "Book No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Item;
        }
        field(4; "Book Name"; Text[100])
        {
            DataClassification = CustomerContent;

        }
    }

    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}