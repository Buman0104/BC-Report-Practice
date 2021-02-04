page 50121 SchoolCard
{
    PageType = Card;
    SourceTable = School;
    Caption = 'School Card';
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                field(No; rec.No)
                {
                    ApplicationArea = All;
                    
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                    
                }
                field(Address; rec.Address)
                {
                    ApplicationArea = All;
                    
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;
                
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
    
    var
        myInt: Integer;
}