tableextension 50103 Box extends Item
{
    fields
    {
        field(12345; Pack; Integer)
        {
            InitValue = 5;
            Description = 'Kg per pack';
            DataClassification = CustomerContent;
        }

        field(12346; Box; Integer)
        {
            InitValue = 20;
            Description = 'Pack per box';
            DataClassification = CustomerContent;
        }
    }

    var
        myInt: Integer;
}