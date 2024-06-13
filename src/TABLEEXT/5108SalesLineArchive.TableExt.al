tableextension 50047 "T5108SalesLineArchive" extends "Sales Line Archive"
{
    fields
    {
        field(50000; Teilmenge; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'LAN1.00';
        }
        field(50003; "Teilmenge geliefert"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'LAN1.00';
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
        field(50514; "Naturalrabattmenge geliefert"; Decimal)
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
        field(50600; Hervorheben; Boolean)
        {
            Description = 'LAN1.00';
        }
        field(50601; "Order Date"; Date)
        {
            Caption = 'Order Date';
            Description = 'LAN1.00';
        }
    }
}
