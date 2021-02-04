page 50111 SchoolList
{
    ApplicationArea = All;
    Caption = 'School List';
    PageType = List;
    SourceTable = School;
    UsageCategory = Lists;
    CardPageId = SchoolCard;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
