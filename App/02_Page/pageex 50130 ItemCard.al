pageextension 50130 ItemCardEx extends "Item Card"
{
    layout
    {
        addafter("Item Category Code")
        {
            field(Pack; rec.Pack)
            {
                ApplicationArea = All;
            }
            field(Box; rec.Box)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {

    }

    var
        myInt: Integer;
}