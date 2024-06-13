tableextension 50016 T81GenJournalLine extends "Gen. Journal Line"
{ // version NAVW114.45,NAVDACH14.45,TODOPBA

    // -----------------------------------------------------
    // (c) gbedv, OPplus, All rights reserved
    // 
    // No.  Date       changed
    // -----------------------------------------------------
    // OPP  01.11.08   - New Fields added
    //                 - New Keys added
    //                   Applied Account Type,ID Applied-Entry
    //                   Pmt. Import Entry No.
    //                 - New Functions
    // AT   30.08.11   OPplus Payment AT
    //                 - New Field added
    // -----------------------------------------------------
    // 
    // 
    // LAN001 12.11.09 ACPSS LAN1.00
    //   New Fields: ID 50005, 50006 für Mitbuchen der Bestellnr. und Bestelldatum in die Kreditorenposten
    //   Kostenstellenaufteilung
    // 
    // GL001: Warnung, wenn Gegenkonto gleich Kontonr.
    // GL002: Kostenstelle/träger nicht löschen, wenn Gegenkonto eingegeben wird
    //        d.h. Dimensionsneufindung bei Gegenkonto nur, wenn DimCode1 oder 2 in Zeile noch leer
    // GL003: MFU Key für Zahlungs Ausgang Buchblatt hinzugefügt
    // 
    // 
    // Datum      | Autor   | Status     | Beschreibung
    // --------------------------------------------------------------------------------------------------------
    // 2010-02-05 | Petsch  | ok         | Update von 3.60
    // --------------------------------------------------------------------------------------------------------
    // 2011-03-24 | MFU     | ok         | GL004 - KOREdatum eingefügt
    // --------------------------------------------------------------------------------------------------------

    fields
    {
        field(50000; "KORE Date"; Date)
        {
            Caption = 'KOREdatum';
        }
        field(50005; Aufteilungscode; Code[10])
        {
            Description = 'LAN1.00';
            //GLDE nicht benötigt? -- TableRelation = IF ("Account Type" = CONST('G/L Account')) ;

            trigger OnValidate()
            begin
                /*
                //-LAN001
                IF Aufteilungscode <> '' THEN BEGIN
                  IF "Account Type" <> "Account Type"::"G/L Account" THEN
                    ERROR(Text50000);
                
                  GLAcc.GET("Account No.");
                  IF NOT (GLAcc."Account Type" = GLAcc."Account Type"::Posting)
                    OR NOT (GLAcc."Income/Balance" = GLAcc."Income/Balance"::"Income Statement")
                  THEN
                    ERROR(Text50000);
                END;
                //+LAN001
                */

            end;
        }
        field(50006; "Aufteilung erfolgt"; Boolean)
        {
            Description = 'LAN1.00';
        }
        field(50500; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            Description = 'LAN1.00';
        }
        field(50501; "Order Date"; Date)
        {
            Caption = 'Order Date';
            Description = 'LAN1.00';
        }
        field(50502; "Valuta Date"; Date)
        {
            Caption = 'Valuta Date';
            Description = 'LAN1.00';
        }
        field(50580; "Bezogen auf Artikelnr."; Code[20])
        {
            Description = 'LAN1.00';
            TableRelation = Item;
        }
    }
}
