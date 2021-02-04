pageextension 50131 RunReport extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast("&Print")
        {
            action("Run Report")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Report;
                //RunObject = report SalesReport;
                trigger OnAction()
                var
                    SalesReport: report OrderNotice;
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("Document Type", rec."Document Type");
                    SalesHeader.SetRange("No.", rec."No.");
                    SalesReport.SetTableView(SalesHeader);
                    SalesReport.RunModal();
                end;
            }
        }
    }
    var
        myInt: Integer;
}