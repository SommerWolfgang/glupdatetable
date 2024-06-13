tableextension 50031 T313InventorySetup extends "Inventory Setup"
{// LAN001 25.11.09 ACPSS LAN1.00
    //   New Fields: ID 50500 - 50504
    // 
    // Felder: Etikettenanzahl, EK-kein Art.lief.preis-Warnung,
    //         Konsignationslagerortcode, -fach, Etikettendrucker
    //         "Kommschein": welcher Bericht soll gedruckt werden
    //         "LS Kopie bei Kommiss."
    //                   Falls eine zusätzliche Kopie des Lieferscheins aus Kommissionierung gewünscht ist, kann hier
    //                   der Bericht angegeben werden.
    //         "Bereitstellungslagerortcode":
    //                    Wird hier ein Lager eingetragen, holt die Bereitstellung nur von dort Chargen
    //         Lagerbestand vor Ort Filter
    //         Etikettendrucker: Option Thermotransferdrucker eingefügt
    // 
    // 
    // ------------------------------------------------------------------------------------------------------------------------------------
    // Datum      | Autor   | Status     | Beschreibung
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-02-05 | Petsch  | ok         | Update von 3.60
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2020-01-14 | MFU     | ok         | Bereitstellungslagerort ohne Table Relation
    // ------------------------------------------------------------------------------------------------------------------------------------
    fields
    {
        field(50000; "Sortierung Kommissionierung"; Option)
        {
            OptionCaption = 'Lagerzone-Artikelnr.,Artikelnr.,Lagerzone-Artikelname,Artikelname';
            OptionMembers = "Lagerzone-Artikelnr.","Artikelnr.","Lagerzone-Artikelname",Artikelname;
        }
        field(50001; Etikettendruck; Option)
        {
            Caption = 'Label Printing';
            Description = 'Petsch';
            OptionCaption = 'at shipment,at picking-list';
            OptionMembers = "bei Lieferschein","bei Kommissionierschein";
        }
        field(50002; Etikettenstil; Option)
        {
            Description = 'Petsch';
            OptionCaption = 'with company-header,without company header';
            OptionMembers = "mit Firmenkopf","ohne Firmenkopf";
        }
        field(50003; Etikettenanzahl; Integer)
        {
            Description = 'Petsch';
        }
        field(50004; "EK-Warnung kein Art.lief.preis"; Boolean)
        {
            Description = 'Petsch';
        }
        field(50005; Etikettendrucker; Option)
        {
            Description = 'Petsch';
            OptionMembers = Matrixdrucker,Laserdrucker,Thermotransferdrucker;
        }
        field(50006; "Packing List Nos."; Code[10])
        {
            Description = 'Petsch';
            TableRelation = "No. Series";
        }
        field(50500; Suchtgiftlagerortcode; Code[10])
        {
            Description = 'LAN1.00';
            TableRelation = Location;
        }
        field(50501; Verkaufslagerortcode; Code[10])
        {
            Description = 'LAN1.00';
            TableRelation = Location;
        }
        field(50502; Rohstoffchargennummern; Code[10])
        {
            Description = 'LAN1.00';
            TableRelation = "No. Series";
        }
        field(50503; Konsignationslagerortcode; Code[10])
        {
            Description = 'LAN1.00';
            TableRelation = Location;
        }
        field(50504; Konsignationslagerfachcode; Code[10])
        {
            Description = 'LAN1.00';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD(Konsignationslagerortcode));
        }
        field(50505; "Lagerbestand vor Ort Filter"; Code[20])
        {
            Description = 'Petsch';
        }
        field(50506; "LS Kopie bei Kommiss."; Integer)
        {
            Description = 'Petsch';
            InitValue = 0;
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Report));
        }
        field(50507; Bereitstellungslagerortcode; Code[10])
        {
            Description = 'Petsch';
        }
        field(50508; Kommschein; Integer)
        {
            Caption = 'KommscheinObjekt';
            Description = 'Petsch';
            InitValue = 0;
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST("Report"));
        }
    }
}
