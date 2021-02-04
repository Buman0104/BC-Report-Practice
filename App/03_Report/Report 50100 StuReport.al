report 50100 StuReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'App/03_Report/Layout/StuReport.rdl';
    PreviewMode = Normal;

    dataset
    {
        dataitem(Students; Students)
        {
            PrintOnlyIfDetail = true;
            CalcFields = Total_result;
            column(Name; Name)
            {
                IncludeCaption = true;
            }

            column(Gender; Gender)
            {
                IncludeCaption = true;
            }
            column(Total_result; Total_result)
            {

            }
            column(test; address)
            {

            }
            dataitem(Grades; Grades)
            {
                DataItemLinkReference = Students;
                DataItemLink = "Student No" = field(No);

                column(TestID; TestID)
                {

                }
                column(Subject; "Subject Name")
                {
                    IncludeCaption = true;
                }
                column(Result; Result)
                {
                    IncludeCaption = true;
                }

            }
        }

    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    /*field(Name; Name)
                    {
                        ApplicationArea = All;
                        
                    }*/
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

}