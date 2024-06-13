tableextension 50032 T5802ValueEntry extends "Value Entry"
{// version NAVW114.22,NAVDACH14.22,TODOPBA2

    // LAN001 02.12.09 ACPSS LAN1.00
    //   New Fields: 50506 - 50516, 50552
    // 
    // 
    // Alte Doku:
    // Neuer Key für Statistik: Posting Date,Item No.,Source Type,Source No.,Verkaufsstatistikcode
    // Key: "Item No.,Posting Date,Document No." für Artikelkontoinfo (SS, 19.11.03)
    // Key Posting Date,Item No.,Source Type,Source No.,Item Ledger Entry Type,Verkaufsstatistikcode,Sales Amount (Actual)
    // um Sales Amount (Actual) verlängert
    // EK-Betrag (tats.), EK.Betrag (erw.) wie in 3.70; plus SumIndex bei 2. Key dazugefügt
    // Am dritten Key am Ende Bin Code angehängt
    // Am vorletzen Key Global Dimension 1 Code angehängt
    // Achtung: Kompilieren der T5802 dauert im SQL-Server bis zu 30min! Die Datenbankgröße steigt dabei um 10GB (bis zum nächsten wartungs
    //          planlauf)
    // KEYS sind jetzt ziemlich anderes: es sollte erhoben werden, welche Statistik welchen Key benötigt und dann neu designed werden!
    // Feld 50001 und 50002 sind jetzt im Standard als Feld 148 und 149 vorhanden. Umkopieren, dann löschen
    // Feld 5403 Bin Code ist jetzt aus Wertposten verschwunden! ->Statistiken!
    // ----
    // 
    // 
    // GL001: Funktion SetValueEntryKundenFilter()
    // GL002: Flowfield Chargennr.
    // GL003  Am vorletzten Key: Posting Date angehängt Item No.,Expected Cost,Valuation Date,Location Code,Variant Code,Posting Date
    //        für Lagerliste Stichtag nach Var. 201
    // 
    // Datum      | Autor   | Status     | Beschreibung
    // --------------------------------------------------------------------------------------------------------
    // 2010-02-05 | Petsch  | in arbeit  | Update von 3.60
    // --------------------------------------------------------------------------------------------------------
    // 2010-04-12 | MFU     | ok         | Key erweitert um Verkaufsstatistikcode für Bericht "Kunden-Artikelstatistik"
    // --------------------------------------------------------------------------------------------------------
    // 2010-04-12 | Petsch  | ok         | GL003
    // --------------------------------------------------------------------------------------------------------
    // 2015-03-26 | MFU     | ok         | UPDATE2013 -> Bei Spalte "Entry Type" die Deutsche Bezeichnung auf "EK-Preis" geändert
    // --------------------------------------------------------------------------------------------------------
    // 2016-10-17 | MFU     | ok         | Lookup Feld "Suchtgiftnr." auf Artikelstamm eingebaut (Mayrhofer)
    // --------------------------------------------------------------------------------------------------------
    fields
    {
        field(50000; "Lot No."; Code[20])
        {
            CalcFormula = Lookup("Item Ledger Entry"."Lot No." WHERE("Entry No." = FIELD("Item Ledger Entry No.")));
            Caption = 'Lot No.';
            FieldClass = FlowField;
        }
        field(50001; "EK-Betrag (tats.)"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50002; "EK-Betrag (erw.)"; Decimal)
        {
            Description = 'Petsch';
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
        field(50510; "Fremdwährung"; Code[10])
        {
            Description = 'LAN1.00';
        }
        field(50511; "Betrag (FW)"; Decimal)
        {
            Description = 'LAN1.00';
        }
        field(50512; "Bestellnr."; Code[20])
        {
            Description = 'LAN1.00';
        }
        field(50513; Bestelldatum; Date)
        {
            Description = 'LAN1.00';
        }
        field(50514; Verkaufsstatistikcode; Code[10])
        {
            Description = 'LAN1.00';
        }
        field(50515; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            Description = 'LAN1.00';
            TableRelation = "Country/Region";
        }
        field(50516; Naturalrabattmenge; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'LAN1.00';
        }
        field(50552; Musterlieferung; Boolean)
        {
            Description = 'LAN1.00';
        }
        field(50553; SuchtgiftNr; Code[20])
        {
            CalcFormula = Lookup(Item."Suchtgiftnr." WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
    }
    procedure SetValueEntryKundenFilter(var recValueEntry: Record "5802")
    var
        sFilter: Text[100];
    begin
        //-GL001
        //Einen Filter zum möglicherweise bestehneden dazugeben

        //Schon gesetzte Filter auslesen
        sFilter := recValueEntry.GETFILTER("Source No.");

        IF STRLEN(sFilter) > 0 THEN
            sFilter := '(' + sFilter + ') & ';
        sFilter += '<50004';

        recValueEntry.SETFILTER("Source No.", sFilter);
        //+GL001
    end;
}
