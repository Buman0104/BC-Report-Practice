page 50110 StudentList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Students;
    Caption = 'Student List';
    CardPageId = StudentCard;
    PromotedActionCategories = 'Testing';

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field(Name; rec.Name)
                {
                    ApplicationArea = All;

                }
                field(No; rec.No)
                {
                    ApplicationArea = All;

                }
                field(Gender; rec.gender)
                {
                    ApplicationArea = All;

                }
                field(Address; rec.Address)
                {
                    ApplicationArea = All;

                }
                field("School Code"; rec."School Code")
                {
                    ApplicationArea = All;

                }
                field("Parent No"; rec."Parent No")
                {
                    ApplicationArea = All;

                }
                field("Enrollment date"; rec."Enrollment date")
                {
                    ApplicationArea = All;

                }
                /*field("Total result"; rec.Total_result)
                {
                    ApplicationArea = All;

                }
                field("Date filter"; rec."Date_filter")
                {
                    ApplicationArea = All;

                }*/
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Navigation)
        {
            action(GradeList)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page GradeList;
                trigger OnAction();
                begin

                end;
            }
            action(RunReport)
            {
                Promoted = true;
                PromotedCategory = Process;
                RunObject = report StuReport;
            }
        }
    }
}