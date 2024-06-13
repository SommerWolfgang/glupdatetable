tableextension 50020 T111SalesShipmentLine extends "Sales Shipment Line"
{// version NAVW114.45,NAVDACH14.45,TODOPBA

    // LAN001 12.11.09 ACPSS LAN1.00
    //   New Fields: ID 50000, 50005, 50006, 50010, 50506 - 50513, 50515 - 50517, 50519, 50520, 50601
    // LAN002 22.11.09 ACPSS LAN1.00
    //   Kennzeichen Hervorheben setzen
    // LAN003 18.01.10 ACPSS LAN1.00
    //   Automatische Chargenanlagen durch Validate auf Menge unterdrücken.
    // 
    // GL002 Für Sammelrechnungen: Im Rechnungsformular werden dann aus dem Verkaufslieferkopf die Felder "Ihre referenz" und
    //                             Lieferung an Name ausgelesen.
    // GL003: Sammelrechnungen sollen keine erneute Naturalrabattfindung auslösen und dabei abstürzen...
    // 
    // Datum      | Autor   | Status     | Beschreibung
    // --------------------------------------------------------------------------------------------------------
    // 2010-04-12 | Petsch  | ok         | Update von 3.60
    // ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // 2015-08-18 | Petsch  | ok         | Funktion Packungsgröße
    // --------------------------------------------------------------------------------------------------------
    // 2016-12-05 | MFU     | ok         | AusFuhrBewilligungsNr Spalte eingebaut
    // --------------------------------------------------------------------------------------------------------
    fields
    {
        field(50000; Teilmenge; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'LAN1.00';
        }
        field(50001; "Packing Information"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50002; Nachlieferungstext; Text[30])
        {
        }
        field(50005; "Abzug %"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'LAN1.00';
        }
        field(50006; Abzugsbetrag; Decimal)
        {
            Description = 'LAN1.00';
        }
        field(50010; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            Description = 'LAN1.00';
            TableRelation = IF (Type = CONST(Item)) "Lot No. Information"."Lot No." WHERE("Item No." = FIELD("No."),
                                                                                         "Variant Code" = FIELD("Variant Code"));
        }
        field(50506; Artikelgruppe; Code[10])
        {
            Description = 'LAN1.00';
            Editable = false;
        }
        field(50507; "Statistikcode I"; Code[10])
        {
            Description = 'LAN1.00';
            Editable = false;
            TableRelation = Statistikcode2 WHERE(Ebene = CONST(1));
        }
        field(50508; "Statistikcode II"; Code[10])
        {
            Description = 'LAN1.00';
            Editable = false;
            TableRelation = Statistikcode2 WHERE(Ebene = CONST(2));
        }
        field(50509; "Statistikcode III"; Code[10])
        {
            Description = 'LAN1.00';
            Editable = false;
            TableRelation = Statistikcode2 WHERE(Ebene = CONST(3));
        }
        field(50510; "Zuordnung zu Artikelnr."; Code[20])
        {
            Description = 'LAN1.00';
            TableRelation = Item;
        }
        field(50511; "Wertkorrektur zu Artikelposten"; Integer)
        {
            Description = 'LAN1.00';
        }
        field(50512; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            Description = 'LAN1.00';
            TableRelation = "Country/Region";
        }
        field(50513; Naturalrabattmenge; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'LAN1.00';
        }
        field(50515; Verkaufsstatistikcode; Code[10])
        {
            Description = 'LAN1.00';
        }
        field(50516; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            Description = 'LAN1.00';
        }
        field(50517; "Suchtgift/Psychotrop"; Text[1])
        {
            Description = 'LAN1.00';
        }
        field(50519; "Verkaufschargennr."; Code[20])
        {
            Description = 'LAN1.00';
        }
        field(50520; "Naturalrabatt fakturiert"; Decimal)
        {
            Description = 'LAN1.00';
        }
        field(50521; AusFuhrBewilligungsNr; Text[100])
        {
        }
        field(50601; "Order Date"; Date)
        {
            Caption = 'Order Date';
            Description = 'LAN1.00';
        }
    }
    procedure Packungsgroesse() cPackungsgroesse: Code[10]
    var
        recItem: Record 27;
    begin
        //-GL035
        cPackungsgroesse := '';
        IF Type = Type::Item THEN
            IF recItem.GET("No.") THEN
                cPackungsgroesse := recItem."Packungsgröße";

        IF ((Type = Type::"G/L Account") OR (Type = Type::"Charge (Item)")) THEN
            IF recItem.GET("Zuordnung zu Artikelnr.") THEN
                cPackungsgroesse := recItem."Packungsgröße";
        //+GL035
    end;
}
