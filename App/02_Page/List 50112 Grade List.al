page 50112 GradeList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Grades;
    Caption = 'Grade List';
    CardPageId = GradeCard;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
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
                field("Exm date"; rec."Exam Date")
                {
                    ApplicationArea = All;

                }
                field(Result; rec.Result)
                {
                    ApplicationArea = All;

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}