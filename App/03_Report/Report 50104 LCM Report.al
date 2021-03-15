report 50104 LCMReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'App/03_Report/Layout/LCMReport.rdl';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(ValueEntry; "Value Entry")
        {
            RequestFilterFields = "Item No.";
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
            column(DocumentType; "Document Type")
            {

            }
            column(LastYear; gLastYear)
            {

            }
            column(LastMonth; gLastMonth)
            {

            }
            dataitem(Item; Item)
            {
                DataItemLinkReference = ValueEntry;
                DataItemLink = "No." = field("Item No.");
                DataItemTableView = sorting("No.");  // Set DataItemTableView to hide this dataitem in request
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
                    Clear(grecValueEntry);
                    gLastMonth := 0;
                    gLastYear := 0;
                    grecValueEntry.SetRange("Item No.", "No.");  //SetRange(ItemLedger.field, item.field)
                    grecValueEntry.SetFilter("Document Type", '= Sales Invoice');
                    if gCutDate <> 0D then
                        grecValueEntry.SetFilter("Posting Date", '<= %1', gCutDate);
                    grecValueEntry.SetCurrentKey("Posting Date");      // Set current key first so you can run the SetAscending function
                    grecValueEntry.SetAscending("Posting Date", true); // Sort value entry by posting date
                    if grecValueEntry.FindLast() then begin            // Find the latest sales record each item to get the last month
                        gLastYear := DATE2DMY(grecValueEntry."Posting Date", 3);
                        gLastMonth := Date2DMY(grecValueEntry."Posting Date", 2);
                    end;
                end;
            }
            trigger OnPreDataItem()
            begin
                if gCutDate <> 0D then
                    ValueEntry.SetFilter("Posting Date", '<= %1', gCutDate);  // Filter the whole data item before it start
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
        grecValueEntry: Record "Value Entry";
        gLastMonth: Integer;
        gLastYear: Integer;

}