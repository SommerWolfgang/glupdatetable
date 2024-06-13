tableextension 50048 "T5109PurchaseHeaderArchive" extends "Purchase Header Archive"
{   // LAN001 02.12.09 ACPSS LAN1.00
    //   New Fields
    // 
    // ------------------------------------------------------------------------------------------------------------------------------------
    // Datum      | Autor   | Status     | Beschreibung
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-02-05 | Petsch  | ok         | Update von 3.60
    // ------------------------------------------------------------------------------------------------------------------------------------
    fields
    {
        field(50000; PrintSignature; Boolean)
        {
            Description = 'Petsch';
        }
        field(50001; "Auftragsbestätigung"; Date)
        {
            Description = 'Petsch';
        }
        field(50002; "Externe Rahmennr."; Code[20])
        {
            Description = 'LAN1.00';
        }
        field(50003; Abrufdatum; Date)
        {
            Description = 'LAN1.00';
        }
        field(50004; Valutadatum; Date)
        {
            Description = 'LAN1.00';
        }
        field(50005; "KW verwenden"; Boolean)
        {
            Description = 'LAN1.00';
            InitValue = true;
        }
        field(50006; Bestellstatus; Option)
        {
            Description = 'LAN1.00';
            OptionMembers = " ",Versendet,Eingegangen,Vorgemerkt;
        }
        field(50007; "Bezogen auf Rechnungsnr."; Code[20])
        {
            Description = 'LAN1.00';
            TableRelation = "Purch. Inv. Header" WHERE("Buy-from Vendor No." = FIELD("Buy-from Vendor No."));
        }
        field(50008; Spediteurcode; Code[10])
        {
            Description = 'LAN1.00';
            TableRelation = "Shipping Agent";
        }
        field(50009; Wertgutschrift; Boolean)
        {
            Description = 'LAN1.00';
        }
        field(50010; "Rücklieferung"; Boolean)
        {
            Description = 'LAN1.00';
        }
        field(50011; Abgeschlossen; Boolean)
        {
            Description = 'Petsch';
        }
        field(50012; Gesperrt; Boolean)
        {
            Description = 'Petsch';
        }
        field(50013; GL; Boolean)
        {
            Description = 'Petsch';
        }
    }
}
