page 50120 StudentCard
{
    PageType = Card;
    SourceTable = Students;
    Caption = 'Student Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(No; rec.No)
                {
                    ApplicationArea = All;

                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;

                }
                field(Address; rec.Address)
                {
                    ApplicationArea = All;

                }
                field(Gender; rec.gender)
                {
                    ApplicationArea = All;

                }
                field(School; rec."School Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}