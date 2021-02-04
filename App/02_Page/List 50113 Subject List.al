page 50113 SubjectList
{
    Caption = 'Subject List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Subject;
    CardPageId = SubjectCard;

    layout
    {
        area(Content)
        {
            repeater(General)
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