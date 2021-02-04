pageextension 50111 Pageex extends "Order Processor Role Center"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addbefore("Sales Orders")
        {
            action(Student)
            {
                Caption = 'Students';
                RunObject = page StudentList;
            }

        }
        addafter(Student)
        {
            action(Grade)
            {
                Caption = 'Grade';
                RunObject = page GradeList;
            }

        }
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}