
//MFU -> Tabelle Frei!!!

table 50010 "Lot/Serial No. Information"
{
    Caption = 'Lot Serial No. Information';
    // version QM13.00,RA7.10.01,PM13.00,CCU



    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;
        }

    }



}
