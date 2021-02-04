report 50101 FairyReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'App/03_Report/Layout/FairyReport.rdl';
    DefaultLayout = RDLC;
    Caption = 'Sales Report';

    dataset
    {
        dataitem(SalesLine; "Sales Line")
        {
            column(Document; "Document No.")
            {

            }
            column(ItemNo; "No.")
            {

            }
            column(QtyToShip; "Qty. to Ship")
            {

            }
            column(UOM; "Unit of Measure Code") { }
            dataitem(Item; Item)
            {
                DataItemLinkReference = SalesLine;
                DataItemLink = "No." = field("No.");
                column(Pack; Pack)
                {

                }
                column(Box; Box)
                {

                }
                column(packs; Packs)
                {

                }
                column(Boxes; Boxes) { }
                column(Result; Result) { }

                trigger OnAfterGetRecord()
                begin
                    Weight := SalesLine."Qty. to Ship";
                    KgPerPack := Item.Pack;
                    PackPerBox := Item.Box;
                    Unit := SalesLine."Unit of Measure Code";

                    if (KgPerPack = 0) OR (PackPerBox = 0)
                    then begin
                        Result := Format(Weight) + Unit;
                        exit;
                    end;

                    Packs := Round(Weight / KgPerPack, 1, '>');
                    Boxes := Round(Packs / PackPerBox, 1, '<');
                    Packs := Round(Packs MOD PackPerBox, 1, '=');
                    if (Packs > 0) then begin
                        Result := Format(Boxes) + ' Boxes, ' + Format(Packs) + ' Packs';
                    end else begin
                        Result := Format(Boxes) + ' Boxes';
                    end;
                end;

            }
            trigger OnAfterGetRecord()
            begin
                //vItem.Get(SalesLine."No.");
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
        KgPerPack: Integer;
        PackPerBox: Integer;
        Packs: Integer;
        Boxes: Integer;
        Weight: Integer;
        Result: Text[25];
        Unit: Text[10];
        vItem: Record Item;

}