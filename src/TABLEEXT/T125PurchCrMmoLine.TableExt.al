tableextension 50056 T125PurchCrMmoLine extends "Purch. Cr. Memo Line"
{
    fields
    {
        field(50000; "Preisfaktor"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'LAN1.00';
        }
        field(50001; "PackmittelVersion"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Petsch';
        }
        field(50005; "HerstellerNr"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "IF (Type=CONST(Item)) Artikel-HerstellerArtikel.HerstellerNr WHERE (ArtikelNameZusatz=FIELD(No.), LieferantNr=FIELD(Buy-from Vendor No.))";
            Description = 'MFU';
        }
        field(50010; "Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = CONST(Item)) "Lot No. Information"."Lot No." WHERE("Item No." = FIELD("No."), "Variant Code" = FIELD("Variant Code"));
            Caption = 'Lot No.';
            Description = 'LAN1.00';
        }
        field(50506; "Artikelgruppe"; Code[10])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "IF (Type=CONST(Item)) Table50502.Field2 WHERE (Field1=CONST(0))";
            Description = 'LAN1.00';
            Editable = false;
        }
        field(50507; "Statistikcode I"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Statistikcode2 WHERE(Ebene = CONST(1));
            Description = 'LAN1.00';
            Editable = false;
        }
        field(50508; "Statistikcode II"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Statistikcode2 WHERE(Ebene = CONST(2));
            Description = 'LAN1.00';
            Editable = false;
        }
        field(50509; "Statistikcode III"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Statistikcode2 WHERE(Ebene = CONST(3));
            Description = 'LAN1.00';
            Editable = false;
        }
        field(50510; "Country/Region Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
            Caption = 'Country/Region Code';
            Description = 'LAN1.00';
        }
        field(50514; "Suchtgift/Psychotrop"; Text[1])
        {
            DataClassification = ToBeClassified;
            Description = 'LAN1.00';
        }
        field(50515; "Direct Unit Cost PE"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Direct Unit Cost PE';
            Description = 'LAN1.00';
            AutoFormatType = 2;
        }
        field(50526; "Lieferantenchargennr."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'LAN1.00';
        }
        field(50528; "Verkaufschargennr."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'LAN1.00';
        }
        field(50529; "Urspr. Menge"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'LAN1.00';
        }
        field(50530; "Expiration Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Expiration Date';
            Description = 'LAN1.00';
        }
        field(50550; "Gebindeanzahl"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'LAN1.00';
        }
        field(50551; "Gebindeartencode"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'LAN1.00';
        }
        field(50582; "Buchungsdatum"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'LAN1.00';
        }
        field(50583; "Zuordnung zu Artikelposten"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'LAN1.00';
        }
        field(50584; "Zuordnung zu Artikelnr."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item";
            Description = 'LAN1.00';
        }
    }
}
