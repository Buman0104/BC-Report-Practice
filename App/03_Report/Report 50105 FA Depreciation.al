report 50105 FADepreciation
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'App/03_Report/Layout/FADepreciationReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(FixedAsset; "Fixed Asset")
        {
            column(No; "No.")
            {

            }
            column(Description; Description)
            {

            }
            dataitem(FADepreciationBook; "FA Depreciation Book")
            {
                DataItemLinkReference = FixedAsset;
                DataItemLink = "FA No." = field("No.");
                column(BookValue; "Book Value")
                {

                }
                column(No__of_Depreciation_Months; "No. of Depreciation Months")
                {

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
                    /*field(Name; SourceExpression)
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

    var
        myInt: Integer;

    local procedure CalculateBookValue(StartDate: Date; EndDate: Date; Cost: Decimal; BookValue: Decimal; Months: Integer; LastDate: Date): array[12] of Decimal
    var
        DepreciateUnit: Integer;
        DepreciatePerUnit: Decimal;
        DDays: Integer;
        DMonths: Integer;
        DYears: Integer;
        BookValues: array[12] of Decimal;
        i: Integer;
    begin
        if StartDate < LastDate then
            StartDate := LastDate;
        DYears := Date2DMY(EndDate, 3) - Date2DMY(StartDate, 3);
        DMonths := Date2DMY(EndDate, 2) - Date2DMY(StartDate, 2);
        DDays := 360 * DYears + 30 * DMonths + (Date2DMY(EndDate, 1) - Date2DMY(StartDate, 1));
        DepreciateUnit := DDays / 12;
        DepreciatePerUnit := (Cost / (Months * 30)) * DepreciateUnit;
        for i := 1 to 12 do begin
            BookValues[i] := BookValue - DepreciatePerUnit;
            BookValue -= DepreciatePerUnit;
        end;
        exit(BookValues);

    end;
}