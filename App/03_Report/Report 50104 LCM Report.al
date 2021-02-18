report 50104 LCMReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'App/03_Report/Layout/LCMReport.rdl';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            column(ItemNo; "Item No.")
            {

            }
            column(PostingDate; "Posting Date")
            {

            }
            column(InvoicedQuantity; "Invoiced Quantity")
            {

            }
            column(CostAmountActual; "Cost Amount (Actual)")
            {

            }
            column(SalesAmountActual; "Sales Amount (Actual)")
            {

            }
            column(EntryType; "Entry Type")
            {

            }
            column(LastYear; gLastYear)
            {

            }
            column(LastMonth; gLastMonth)
            {

            }
            column(AverageSales; gAvSales)
            {

            }
            column(Quantity; Quantity)
            {

            }
            column(CostAmount; gCost)
            {

            }
            dataitem(Item; Item)
            {
                DataItemLinkReference = ItemLedgerEntry;
                DataItemLink = "No." = field("Item No.");

                column(Description; Description)
                {

                }
                column(CostingMethod; "Costing Method")
                {

                }
                column(StandardCost; "Standard Cost")
                {

                }
                trigger OnAfterGetRecord()
                var
                    MonthSales: Decimal;
                    MonthInvoice: Decimal;
                begin
                    Clear(grecItemLedger);
                    gLastMonth := 0;
                    gLastYear := 0;
                    grecItemLedger.SetRange("Item No.", "No.");  //SetRange(ItemLedger.field, item.field)
                    grecItemLedger.SetFilter("Entry Type", '= Sale');
                    if gCutDate <> 0D then
                        grecItemLedger.SetFilter("Posting Date", '<= %1', gCutDate);
                    grecItemLedger.SetCurrentKey("Posting Date");
                    grecItemLedger.SetAscending("Posting Date", true); //Sort item ledger entry by posting date
                    if grecItemLedger.FindLast() then begin // Find the latest record each item to get the last month
                        gLastYear := DATE2DMY(grecItemLedger."Posting Date", 3);
                        gLastMonth := Date2DMY(grecItemLedger."Posting Date", 2);
                    end;
                end;
            }
            trigger OnPreDataItem()
            begin
                if gCutDate <> 0D then
                    ItemLedgerEntry.SetFilter("Posting Date", '<= %1', gCutDate);
            end;

            trigger OnAfterGetRecord()
            begin
                gCost := 0;
                grecValue.SetRange("Item Ledger Entry No.", "Entry No.");
                if grecValue.FindSet() then begin
                    repeat
                        gCost += grecValue."Cost Amount (Actual)" + grecValue."Cost Amount (Expected)"; //Cost amount should be actual + expect
                    until grecValue.Next() = 0;
                end;
            end;

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Date Range")
                {
                    field("Cut Off Date"; gCutDate)
                    {
                        ApplicationArea = All;
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

    var
        gCutDate: Date;
        grecItemLedger: Record "Item Ledger Entry";
        gLastMonth: Integer;
        gLastYear: Integer;
        gItemIQuantity: Decimal;
        gItemSales: Decimal;
        gAvSales: Decimal;
        grecValue: Record "Value Entry";
        gCost: Decimal;
}