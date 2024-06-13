tableextension 50023 T121PurchaseReceiptLine extends "Purch. Rcpt. Line"
{// version NAVW114.45,TODOPBA

    // LAN001 25.11.09 ACPSS LAN1.00
    //   New Fields: ID 50000, 50010, 50506 - 50510, 50514, 50515, 50526, 50528 - 50530, 50550, 50551
    // LAN002 25.11.09 ACPSS LAN1.00
    //   Urspr. Menge zurücksetzen
    // 
    // Datum      | Autor   | Status     | Beschreibung
    // --------------------------------------------------------------------------------------------------------
    // 2011-01-24 | Petsch  | ok         | Neuer Key: Pay-to Vendor No., Location Code, Qty. Rcd. Not Invoiced
    //                                     damit Wareneingangszeilen holen schneller
    // --------------------------------------------------------------------------------------------------------
    // 2012-09-25 | MFU     | ok         | Neuer Key: Pay-to Vendor No., Location Code, Line No., Qty. Rcd. Not Invoiced
    //                                     für Sortierungs Verbesserung in Wareneingangszeilen holen
    // --------------------------------------------------------------------------------------------------------
    // 2014-05-02 | MFU     | ok         | Neuer Key bei UPDATE2013: Pay-to Vendor No.,Buy-from Vendor No.,Qty. Rcd. Not Invoiced
    //                                     für Sortierungs Verbesserung in Wareneingangszeilen holen
    // --------------------------------------------------------------------------------------------------------
    // 2016-05-23 | MFU     | ok         | Feld "BeschreibungLang" eingebaut
    // --------------------------------------------------------------------------------------------------------
    // 2017-01-23 | MFU     | ok         | SMVerwendungszweck Spalte eingebaut
    // --------------------------------------------------------------------------------------------------------
    // 2017-08-28 | MFU     | ok         | GL001 - Bei "Wareneingangszeilen holen" das Transportversicherungshakerl und den Lieferbedingungscode mitnehmen
    // --------------------------------------------------------------------------------------------------------
    // 2017-12-20 | MFU     | ok         | Palettenanzahl dazu
    // --------------------------------------------------------------------------------------------------------
    // 2018-09-04 | DKO     | ok         | Neue Spalte "CEP Nr" - Für LQ18 - Lieferantenqualifizierung
    // ------------------------------------------------------------------------------------------------------------------------------------

    fields
    {
        field(50000; Preisfaktor; Decimal)
        {
            Description = 'LAN1.00';
        }
        field(50001; PackmittelVersion; Code[20])
        {
            Description = 'Petsch';
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
        field(50510; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            Description = 'LAN1.00';
            TableRelation = "Country/Region";
        }
        field(50511; EinAusFuhrBewilligungsNr; Text[100])
        {
            Description = 'MFU';
        }
        field(50512; SMVerwendungszweck; Option)
        {
            Description = 'MFU';
            OptionMembers = " ","Import für Inlandsverbrauch","Import für Wiederausfuhr";
        }
        field(50514; "Suchtgift/Psychotrop"; Text[1])
        {
            Description = 'LAN1.00';
        }
        field(50515; "Direct Unit Cost PE"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCodeFromHeader;
            AutoFormatType = 2;
            Caption = 'Direct Unit Cost PE';
            Description = 'LAN1.00';
        }
        field(50526; "Lieferantenchargennr."; Code[20])
        {
            Description = 'LAN1.00';
        }
        field(50528; "Verkaufschargennr."; Code[20])
        {
            Description = 'LAN1.00';
        }
        field(50529; "Urspr. Menge"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'LAN1.00';
        }
        field(50530; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            Description = 'LAN1.00';
        }
        field(50550; Gebindeanzahl; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'LAN1.00';
        }
        field(50551; Gebindeartencode; Code[10])
        {
            Description = 'LAN1.00';

        }
        field(50553; Palettenanzahl; Integer)
        {
        }
        field(50585; BeschreibungLang; BLOB)
        {
            Description = 'MFU';
        }
        field(50586; "CEP Nr"; Code[50])
        {
        }
        field(50587; "Expiration Date DM"; Text[6])
        {
            Description = 'GL015,EUHUB';
            Numeric = true;
            Width = 6;
        }
    }
}
