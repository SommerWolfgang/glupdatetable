tableextension 50011 T32ItemLedgerEntry extends "Item Ledger Entry"
{ // version NAVW114.31,TODOPBA

    // LAN001 12.11.09 ACPSS LAN1.00
    //   New Fields: ID 50500, 50501, 50506 - 50509, 50512 - 50517, 50521, 50522, 50529, 50550 - 50552, 50600, 50601
    //   Code bei LookUp Chargennr. gelöscht.
    // LAN002 14.12.09 ACPSS LAN1.00
    //   New Key: "Item No.,Lot No."
    // 
    // GL001 Funktion Wiegeposten(), (flowfield würde bei nichtfa-posten fehlmeldungen machen)
    // GL002 Einstandspreis()
    // GL003 SetItemLedgerEntryKundenFilter() (für Page 50070)
    // GL004 Key (Entry Type,Nonstock,Item No.,Posting Date) aktiviert
    // GL005 Key (Document No.,Posting Date) hinzugefügt für R50064
    // 
    // Flowfields EK-Betrag (erw.) und EK-Betrag (tats.): derzeit nicht eingebaut, ev. umstellen auf Standardfelder: Petsch, 10.2.2010
    // 
    // 
    // Datum      | Autor   | Status     | Beschreibung
    // --------------------------------------------------------------------------------------------------------
    // 2010-02-25 | Fuerbass  | ok       | Update von 360
    // --------------------------------------------------------------------------------------------------------
    // 2010-03-24 | Petsch    | ok       | Feld Lagerplatzhilfsfeld für HoleVon-Maske eingebaut, wird nur in Temp-Tabelle befüllt
    //                                     an Key: "Item No.,Lot No.,Open,Positive,Location Code, Lagerplatzhilfsfeld" angehängt
    // --------------------------------------------------------------------------------------------------------
    // 2013-06-19 | Fuerbass  | ok       | Feld Laetus Code Lookub für Maurer eingebaut
    // --------------------------------------------------------------------------------------------------------
    // 2015-10-28 | Fuerbass  | ok       | Feld Entwicklungsprojekt für Buchhaltung eingebaut  (Für Postenausschluss in R50013)
    // --------------------------------------------------------------------------------------------------------
    // 2016-04-29 | Fuerbass  | ok       | Feld VernichtungNachverrechnung für Buchhaltung eingebaut (Erkennung von Vernichtungen die Nachverrechnet wurden)
    // --------------------------------------------------------------------------------------------------------
    // 2017-05-08 | Fuerbass  | ok       | Key für FA-Dispoliste eingebaut
    // --------------------------------------------------------------------------------------------------------
    // 2019-12-10 | Fuerbass  | ok       | Neues FlowField "ArtikelStandortHerstellung" für Bericht Lieferantenstatistic quer
    // --------------------------------------------------------------------------------------------------------
    // 
    // 
    // 
    // 
    // Untenstehende Keys je nach Bedarf einbauen:
    // 
    // Alte Doku
    // Neuer Key: "Location Code,Bin Code,Open"
    // Neuer Key: "Item No.,Lot No.,Open,Positive,Location Code, Bin Code"
    // 2004-08-30 | Petsch  | ok         | Key: "Item No.,Lot No.,Open,Positive,Location Code, um "Bin Code" erweitert für Umlag.Info
    // Key "Source Type,Source No.,Entry Type,Item No.,Variant Code,Posting Date" Enable = JA
    // Neuer Key: "Item No., Lot No., Posting Date"
    // Neues Feld: "TreeViewStatus_Temp" für Umlagerinfo Baumansicht
    fields
    {
        field(50000; "EK-Betrag (tats.)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Value Entry"."EK-Betrag (tats.)" WHERE("Item Ledger Entry No." = FIELD("Entry No.")));

        }
        field(50001; "EK-Betrag (erw.)"; Decimal)
        {
            CalcFormula = Sum("Value Entry"."EK-Betrag (erw.)" WHERE("Item Ledger Entry No." = FIELD("Entry No.")));
            FieldClass = FlowField;
        }
        field(50002; Lagerplatzposten; Integer)
        {
            CalcFormula = Count("Warehouse Entry" WHERE("Location Code" = FIELD("Location Code"),
                                                         "Item No." = FIELD("Item No."),
                                                         "Variant Code" = FIELD("Variant Code"),
                                                         "Lot No." = FIELD("Lot No.")));
            FieldClass = FlowField;
        }
        field(50003; Lagerplatzhilfsfeld; Code[20])
        {
        }
        field(50004; Chargen_LaetusCode; Text[15])
        {
            CalcFormula = Lookup("Lot No. Information"."Laetus-Code" WHERE("Item No." = FIELD("Item No."),
                                                                          "Lot No." = FIELD("Lot No.")));
            FieldClass = FlowField;
        }
        field(50500; "Externe Rahmennr."; Code[20])
        {
            Description = 'LAN1.00';
        }
        field(50501; Abrufdatum; Date)
        {
            Description = 'LAN1.00';
        }
        field(50502; TreeViewStatus_Temp; Integer)
        {
        }
        field(50503; Entwicklungsprojekt; Boolean)
        {
            Description = 'MFU';
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
        field(50510; ArtikelStandortHerstellung; Code[20])
        {
            CalcFormula = Lookup(Item."Site Manufacturing" WHERE("No." = FIELD("Item No.")));
            Description = 'MFU';
            FieldClass = FlowField;
        }
        field(50512; "Bestellnr."; Code[20])
        {
            Description = 'LAN1.00';
        }
        field(50513; Bestelldatum; Date)
        {
            Description = 'LAN1.00';
        }
        field(50514; "Wertgutschriftsnr."; Code[20])
        {
            Description = 'LAN1.00';
        }
        field(50515; "Ländercode"; Code[10])
        {
            Description = 'LAN1.00';
            TableRelation = "Country/Region";
        }
        field(50516; Naturalrabattmenge; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'LAN1.00';
        }
        field(50517; Verkaufsstatistikcode; Code[10])
        {
            Description = 'LAN1.00';
        }
        field(50521; "Suchtgift/Psychotrop"; Text[1])
        {
            Description = 'LAN1.00';
        }
        field(50522; "Verkaufschargennr."; Code[20])
        {
            Description = 'LAN1.00';
        }
        field(50529; "Urspr. Menge"; Decimal)
        {
            DecimalPlaces = 0 : 5;
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
        field(50552; Musterlieferung; Boolean)
        {
            Description = 'LAN1.00';
        }
        field(50553; "Hole Von"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("Item No."),
                                                                              "Location Code" = FIELD("Location Code"),
                                                                              Open = const(true)));
            FieldClass = FlowField;
        }
        field(50600; Sachpostenkorrektur; Decimal)
        {
            Description = 'LAN1.00';
        }
        field(50601; "Wertgutschrift Korrekturbetrag"; Decimal)
        {
            Description = 'LAN1.00';
        }
        field(50602; RUELLagerplatzStandort; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Warehouse Entry"."Bin Code" WHERE("Location Code" = const('RÜL'),
                                                                     "Item No." = FIELD("Item No."),
                                                                     "Variant Code" = FIELD("Variant Code"),
                                                                     "Lot No." = FIELD("Lot No."),
                                                                     "Registering Date" = FIELD("Posting Date"),
                                                                     "Location Code" = FIELD("Location Code"),
                                                                     Quantity = FIELD(Quantity)));

        }
        field(50603; "KeineLagerstandÜbernahme"; Boolean)
        {
        }
    }

    procedure Einstandspreis(): Decimal
    begin
        //-GL001
        IF "Invoiced Quantity" <> 0 THEN BEGIN
            CALCFIELDS("Cost Amount (Actual)");
            EXIT("Cost Amount (Actual)" / "Invoiced Quantity");
        END;
        //+GL001
    end;



    procedure SetItemLedgerEntryKundenFilter(var recArtikelposten: Record "32")
    var
        sFilter: Text[100];
    begin
        //-GL003
        //Einen Filter zum möglicherweise bestehneden dazugeben
        //Schon gesetzte Filter auslesen
        sFilter := recArtikelposten.GETFILTER("Source No.");

        IF STRLEN(sFilter) > 0 THEN
            sFilter += ' & ';
        sFilter += '<50004';

        recArtikelposten.SETFILTER("Source No.", sFilter);
        //+GL003
    end;
}
