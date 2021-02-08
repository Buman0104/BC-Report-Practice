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
            DataItemTableView = WHERE("Entry Type" = const(Sale));

            column(iNo; "Item No.")
            {

            }
            column(pDate; "Posting Date")
            {

            }
            column(IQuantity; "Invoiced Quantity")
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
            column(AvSales; gAvSales)
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
                    grecItemLedger.SetRange("Item No.", "No.");
                    grecItemLedger.SetFilter("Entry Type", '= Sale');
                    if gCutDate <> 0D then
                        grecItemLedger.SetFilter("Posting Date", '<= %1', gCutDate);
                    grecItemLedger.SetCurrentKey("Posting Date");
                    grecItemLedger.SetAscending("Posting Date", true);
                    if grecItemLedger.FindLast() then begin
                        gLastYear := DATE2DMY(grecItemLedger."Posting Date", 3);
                        gLastMonth := Date2DMY(grecItemLedger."Posting Date", 2);
                    end;

                    /*Clear(grecItemLedger);
                    MonthInvoice := 0;
                    MonthSales := 0;
                    grecItemLedger.SetRange("Item No.", "No.");
                    grecItemLedger.SetRange("Posting Date", DMY2Date(1, gLastMonth, gLastYear), DMY2Date(31, gLastMonth, gLastYear));
                    grecItemLedger.SetFilter("Entry Type", '= Sale');
                    if grecItemLedger.FindSet() then begin
                        repeat
                            MonthSales := grecItemLedger."Sales Amount (Actual)" + MonthSales;
                            MonthInvoice := grecItemLedger."Invoiced Quantity" + MonthInvoice;
                        until grecItemLedger.Next() = 0
                    end;
                    if MonthInvoice <> 0 then
                        gAvSales := MonthSales;*/
                end;
            }
            trigger OnPreDataItem()
            begin
                if gCutDate <> 0D then
                    ItemLedgerEntry.SetFilter("Posting Date", '<= %1', gCutDate);
                ItemLedgerEntry.SetFilter("Invoiced Quantity", '< 0');
            end;

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
                    field("Cut Date"; gCutDate)
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
}