page 50122 GradeCard
{
    PageType = Card;
    SourceTable = Grades;
    Caption = 'Grade Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(TestID; rec.TestID)
                {
                    ApplicationArea = All;
                }
                field("Student No"; rec."Student No")
                {
                    ApplicationArea = All;

                }
                field("Student Name"; rec."Student Name")
                {
                    ApplicationArea = All;

                }
                field("Subject No"; rec."Subject No")
                {
                    ApplicationArea = All;

                }
                field("Subject Name"; rec."Subject Name")
                {
                    ApplicationArea = All;

                }
                field("Exam Date"; rec."Exam Date")
                {
                    ApplicationArea = All;

                }
                field(Result; rec.Result)
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