table 50124 Grades
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Student No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Students;

        }
        field(2; "Subject No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Subject;
        }
        field(3; "Student Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Students.Name where(No = field("Student No")));
            Editable = false;
        }
        field(4; "Subject Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Subject.Name where(No = field("Subject No")));
            Editable = false;
        }
        field(5; "Exam Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(6; Result; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0;
        }
        field(7; TestID; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Student No", TestID)
        {
            Clustered = true;
        }

        Key(SK; "Subject No")
        {

        }
    }

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