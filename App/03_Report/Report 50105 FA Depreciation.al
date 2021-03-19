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
            column(gGroupTotalsInd; gGroupTotalsInd)
            {

            }
            column(FAClassCode; "FA Class Code")
            {

            }
            column(FASubclassCode; "FA Subclass Code")
            {

            }
            column(FALocationCode; "FA Location Code")
            {

            }
            column(MainAssetComponent; "Main Asset/Component")
            {

            }
            column(ComponentofMainAsset; "Component of Main Asset")
            {

            }
            column(FAPostingGroup; "FA Posting Group")
            {

            }
            column(FAGlobalDimension1Code; "Global Dimension 1 Code")
            {

            }
            column(GlobalDimension2Code; "Global Dimension 2 Code")
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
                column(AcquisitionCost; "Acquisition Cost")
                {

                }
                column(BookValue1; gBookValues[1])
                {

                }
                column(BookValue2; gBookValues[2])
                {

                }
                column(BookValue3; gBookValues[3])
                {

                }
                column(BookValue4; gBookValues[4])
                {

                }
                column(BookValue5; gBookValues[5])
                {

                }
                column(BookValue6; gBookValues[6])
                {

                }
                column(BookValue7; gBookValues[7])
                {

                }
                column(BookValue8; gBookValues[8])
                {

                }
                column(BookValue9; gBookValues[9])
                {

                }
                column(BookValue10; gBookValues[10])
                {

                }
                column(BookValue11; gBookValues[11])
                {

                }
                column(BookValue12; gBookValues[12])
                {

                }
                column(Date1; gDeprDates[1])
                {

                }
                column(Date2; gDeprDates[2])
                {

                }
                column(Date3; gDeprDates[3])
                {

                }
                column(Date4; gDeprDates[4])
                {

                }
                column(Date5; gDeprDates[5])
                {

                }
                column(Date6; gDeprDates[6])
                {

                }
                column(Date7; gDeprDates[7])
                {

                }
                column(Date8; gDeprDates[8])
                {

                }
                column(Date9; gDeprDates[9])
                {

                }
                column(Date10; gDeprDates[10])
                {

                }
                column(Date11; gDeprDates[11])
                {

                }
                column(Date12; gDeprDates[12])
                {

                }
                column(gDeprAmount1; gDeprAmount[1])
                {

                }
                column(gDeprAmount2; gDeprAmount[2])
                {

                }
                column(gDeprAmount3; gDeprAmount[3])
                {

                }
                column(gDeprAmount4; gDeprAmount[4])
                {

                }
                column(gDeprAmount5; gDeprAmount[5])
                {

                }
                column(gDeprAmount6; gDeprAmount[6])
                {

                }
                column(gDeprAmount7; gDeprAmount[7])
                {

                }
                column(gDeprAmount8; gDeprAmount[8])
                {

                }
                column(gDeprAmount9; gDeprAmount[9])
                {

                }
                column(gDeprAmount10; gDeprAmount[10])
                {

                }
                column(gDeprAmount11; gDeprAmount[11])
                {

                }
                column(gDeprAmount12; gDeprAmount[12])
                {

                }
                column(gAccuAmount; gAccuAmount)
                {

                }
                trigger OnAfterGetRecord()
                var
                    FALedgerEntry: Record "FA Ledger Entry";
                    LastDeprDate: Date;
                begin
                    LastDeprDate := GetLastDeprDate(FADepreciationBook."FA No.");
                    Clear(gBookValues);
                    Clear(gDeprAmount);
                    Clear(gAccuAmount);
                    if FADepreciationBook."Acquisition Cost" > 0 then
                        CalcDeprAmountAndDates(gStartDate, FADepreciationBook."Book Value", FADepreciationBook."No. of Depreciation Months",
                         FADepreciationBook."Depreciation Starting Date", FADepreciationBook."Depreciation Ending Date", LastDeprDate, FADepreciationBook."Acquisition Cost");
                end;
            }
            trigger OnPreDataItem()
            begin
                gGroupTotalsInd := gGroupTotals;
            end;
        }
    }


    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group("Filter")
                {
                    field(StartDate; gStartDate)
                    {
                        ApplicationArea = All;

                    }
                    field(GroupTotals; gGroupTotals)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Group Totals';
                        OptionCaption = ' ,FA Class,FA Subclass,FA Location,Main Asset,Global Dimension 1,Global Dimension 2,FA Posting Group';
                        ToolTip = 'Specifies if you want the report to group fixed assets and print totals using the category defined in this field. For example, maintenance expenses for fixed assets can be shown for each fixed asset class.';
                    }
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
    trigger OnPreReport()
    begin
        //CalcDates(gStartDate);
    end;

    var
        gBookValues: array[12] of Decimal;
        gDeprAmount: array[12] of Decimal;
        gDeprDates: array[12] of Date;
        gStartDate: Date;
        gGroupTotals: Option " ","FA Class","FA Subclass","FA Location","Main Asset","Global Dimension 1","Global Dimension 2","FA Posting Group";
        gGroupTotalsInd: Integer;
        gAccuAmount: Decimal;

    local procedure CalcDeprDates(StartDate: Date; LastDate: Date)
    var
        i: Integer;
    begin
        if StartDate > LastDate then begin
            if StartDate <> CalcDate('CM', StartDate) then begin
                gDeprDates[1] := StartDate;
                gDeprDates[2] := CalcDate('CM', StartDate);
                for i := 3 to 12 do begin
                    StartDate := CalcDate('CM+1M', StartDate);
                    gDeprDates[i] := CalcDate('CM', StartDate);
                end;
            end
            else begin
                for i := 1 to 12 do begin
                    gDeprDates[i] := CalcDate('CM', StartDate);
                    StartDate := CalcDate('CM+1M', StartDate);
                end;
            end;
        end
        else begin
            if StartDate = LastDate then begin
                StartDate := CalcDate('CM+1M', StartDate);
                gDeprDates[1] := StartDate;
                StartDate := CalcDate('CM+1M', StartDate);
            end
            else begin
                gDeprDates[1] := CalcDate('CM', StartDate);
                StartDate := CalcDate('CM+1M', StartDate);
            end;
            for i := 2 to 12 do begin
                gDeprDates[i] := CalcDate('CM', StartDate);
                StartDate := CalcDate('CM+1M', StartDate);
            end;
        end;
    end;

    local procedure GetLastDeprDate(FANo: Code[20]): Date
    var
        FALedgerEntry: Record "FA Ledger Entry";
        LastDeprDate: Date;
    begin
        Clear(FALedgerEntry);
        Clear(LastDeprDate);
        FALedgerEntry.SetRange("FA No.", FANo);
        FALedgerEntry.SetFilter("FA Posting Type", '=Depreciation');
        FALedgerEntry.SetCurrentKey("Posting Date");
        FALedgerEntry.SetAscending("Posting Date", true);
        if FALedgerEntry.FindLast() then
            LastDeprDate := FALedgerEntry."Posting Date"
        else
            LastDeprDate := 0D;
        exit(LastDeprDate);
    end;

    local procedure CalcDeprAmountAndDates(StartDate: Date; BookValue: Decimal; Months: Integer; DeprStartDate: Date; DeprEndDate: Date; LastDeprDate: Date; Cost: Decimal)
    var
        i: Integer;
        DeprPerUnit: Decimal;
        RemainDays: Integer;
        DepredDays: Integer;
        BeforeStartDate: Date;
        myBookvalue: Decimal;
    begin
        if StartDate > DeprEndDate then begin
            DepredDays := 30 * Months;
            RemainDays := 0;
        end
        else begin
            DepredDays := CalcDepredDays(StartDate, LastDeprDate, DeprStartDate);
            RemainDays := CalcRemainDays(StartDate, LastDeprDate, DeprEndDate);
        end;
        if RemainDays = 0 then
            DeprPerUnit := Round(Cost / (30 * Months), 0.001)
        else
            DeprPerUnit := Round((BookValue / RemainDays), 0.001, '=');
        myBookvalue := Round(BookValue - Round((DepredDays * DeprPerUnit), 0.001), 1);
        RemainDays -= DepredDays;
        Message('%1, %2', myBookvalue, RemainDays);
        for i := 1 to 12 do begin
            gDeprDates[i] := CalcDate('CM', StartDate);
            StartDate := CalcDate('CM+1M', StartDate);
            if (gDeprDates[i] > LastDeprDate) and (RemainDays > 0) then begin
                if RemainDays > 30 then
                    gDeprAmount[i] := Round(30 * DeprPerUnit, 1)
                else
                    gDeprAmount[i] := myBookvalue;
                RemainDays -= 30;
            end
            else begin
                gDeprAmount[i] := 0;
            end;
            gAccuAmount += gDeprAmount[i];
            myBookValue -= gDeprAmount[i];
            if myBookvalue < 0 then
                myBookvalue := 0;
            gBookValues[i] := myBookValue;
        end;
    end;

    local procedure DiffMonth(StartDate: Date; EndDate: Date) ReturnMonth: Integer;
    var
        MyDate: Record Date;
    begin
        MyDate.reset;
        MyDate.Setrange("Period Type", MyDate."Period Type"::Month);
        MyDate.SetRange("Period Start", StartDate, EndDate);
        if MyDate.FindSet() then begin
            ReturnMonth := MyDate.Count();
        end;
    end;

    local procedure CalcDepredDays(StartDate: Date; LastDeprDate: Date; DeprStartDate: Date): Integer
    var
        BeforeStartDate: Date;
        DepredDays: Integer;
    begin
        BeforeStartDate := CalcDate('-CM-1D', StartDate);
        if LastDeprDate <> 0D then
            DepredDays := 30 * DiffMonth(LastDeprDate, BeforeStartDate)
        else
            DepredDays := 30 * DiffMonth(DeprStartDate, BeforeStartDate);
        if DepredDays < 0 then
            DepredDays := 0;
        exit(DepredDays);
    end;

    local procedure CalcRemainDays(StartDate: Date; LastDeprDate: Date; DeprEndDate: Date): Integer
    var
        BeforeStartDate: Date;
        RemainDays: Integer;
    begin
        BeforeStartDate := CalcDate('-CM-1D', StartDate);
        RemainDays := 30 * DiffMonth(LastDeprDate, CalcDate('-CM-1D', DeprEndDate));
        if DeprEndDate <> CalcDate('CM', DeprEndDate) then
            RemainDays += Date2DMY(DeprEndDate, 1)
        else
            RemainDays += 30;
        if RemainDays < 0 then
            RemainDays := 0;

        exit(RemainDays);
    end;
}