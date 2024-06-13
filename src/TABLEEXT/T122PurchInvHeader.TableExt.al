tableextension 50039 T122PurchInvHeader extends "Purch. Inv. Header"
{// LAN001 25.11.09 ACPSS LAN1.00
    //   New Fields: ID 50000 - 50003, 50005, 50006, 51075
    // 
    // 
    // Datum      | Autor   | Status     | Beschreibung
    // --------------------------------------------------------------------------------------------------------
    // 2017-08-25 | MFU     | ok         | "Transportversicherung" angelegt
    // --------------------------------------------------------------------------------------------------------
    // 2017-09-07 | MFU     | ok         | "StornoMitBelegNr" angelegt
    // --------------------------------------------------------------------------------------------------------
    fields
    {
        //MFU 29.03.2024 -> Entfernen der Felder, da Fehler beim Buchen dadurch
        /*
        field(50000; "Externe Rahmennr."; Code[20])
        {
            Description = 'LAN1.00';
        }
        field(50001; Abrufdatum; Date)
        {
            Description = 'LAN1.00';
        }
        field(50002; Valutadatum; Date)
        {
            Description = 'LAN1.00';
        }
        field(50003; "KW verwenden"; Boolean)
        {
            Description = 'LAN1.00';
        }
        field(50005; "Bezogen auf Rechnungsnr."; Code[20])
        {
            Description = 'LAN1.00';
            TableRelation = "Purch. Inv. Header" WHERE("Buy-from Vendor No." = FIELD("Buy-from Vendor No."));
        }
        field(50006; Spediteurcode; Code[10])
        {
            Description = 'LAN1.00';
            TableRelation = "Shipping Agent";
        }
        field(50008; StornoMitBelegNr; Code[20])
        {
            Description = 'MFU';
        }
        field(50011; Transportversicherung; Boolean)
        {
            Description = 'MFU';
        }
        field(51075; "Rücklieferung"; Boolean)
        {
            Description = 'LAN1.00';
        }
        */
    }
}
