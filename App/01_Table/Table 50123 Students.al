table 50123 Students
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(2; Name; Text[100])
        {
            DataClassification = CustomerContent;

        }
        field(3; gender; Enum Gender)
        {
            DataClassification = CustomerContent;

        }
        field(4; Address; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(5; "School Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = School;
        }
        field(6; "Parent No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }
        field(7; "Enrollment date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Total_result"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum(Grades.Result where("Student No" = field("No"),
                                                  "Exam Date" = field("Date_filter")));
        }
        field(9; "Date_filter"; Date)
        {
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}