page 50123 SubjectCard
{
    PageType = Card;
    SourceTable = Subject;
    Caption = 'Subject Card';

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

                field(BookNo; rec."Book No")
                {
                    ApplicationArea = All;
                }
                field(BookName; rec."Book Name")
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