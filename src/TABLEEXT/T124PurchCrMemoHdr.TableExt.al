tableextension 50040 T124PurchCrMemoHdr extends "Purch. Cr. Memo Hdr."
{ // LAN001 25.11.09 ACPSS LAN1.00
    //   New Fields: ID 50502, 50506, 50507
    // 
    // 
    fields
    {
        field(50502; Valutadatum; Date)
        {
            Description = 'LAN1.00';
        }
        field(50506; Spediteurcode; Code[10])
        {
            Description = 'LAN1.00';
            TableRelation = "Shipping Agent";
        }
        field(50507; Wertgutschrift; Boolean)
        {
            Description = 'LAN1.00';
        }
        field(50508; StornoMitBelegNr; Code[20])
        {
            Description = 'MFU';
        }
    }
}
