
//Task58 Task58.01    11.04.2024  MFU: Anpassungen Artikelbuchblatt  

tableextension 50017 T83ItemJournalLine extends "Item Journal Line"
{  // version NAVW114.44,TODOPBA

    // LAN001 12.11.09 ACPSS LAN1.00
    //   New Fields: 50500, 50501, 50506 - 50514, 50524, 50525, 50528, 50550 - 50554
    // LAN002 22.12.09 ACPSS LAN1.00
    //   Statistik
    // LAN003 22.12.09 ACPSS LAN1.00
    //   Anzeige Posten bei "Hole von", "Hole nach"
    // LAN004 22.12.09 ACPSS LAN1.00
    //   Charge
    // 
    // GL004 Bei FA: Belegnr.=Chargennr.
    // GL005 Arbeitsgänge erhalten Prod.Buchgruppe aus FA, nicht von AP-Karte!
    // GL006 FA-Lookup je nach Betriebskennzeichen
    // GL007 Lagerortbelegung bei Verbrauchsbuchung+Navision Bug Behebung
    // GL008 Umlagerungsbuchungen: Feld "Neuer Kostenstellen Code" befüllen
    // GL009 Korr: Bei Neubewertungen mit apply-to entry wurde nach lookup die Nummer wieder gelöscht
    // GL010 PPS: Output: invoiced quantity setzen!
    // GL011 Keine Lagerplatzvorbelegung bei Umlagerungsbuchblatt
    // 
    // 
    // Changelog:
    // Datum      | Autor   | Status     | Beschreibung
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-01-14 | Petsch  | ok         | Update aus 3.60
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-04-23 | Petsch  | ok         | Pkt. GL011
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-05-05 | MFU     | ok         | GL012 Vorschlagen des Standard Lagerplatzes nach Wahl eines neuen Lagerorts nicht machen
    //                                           (Wunsch Lager wegen Vorschlag falschen Lagerplatzes)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-05-11 | MFU     | ok         | GL013 Text geändert
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-09-21 | MFU     | ok         | GL014 Bei Lookup bei Feld "Prod. Order No." wurde Filter angepasst
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-01-05 | Rieder  | ok         | GL014 ausgebessert
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-06-09 | Rieder  | ok         | Schlüssel hinzugefügt: Journal Template Name,Work Center No.,Description
    //                      |            | (für Report Jahresmaschinenstunden, Pranter)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-11-28 | MFU     | ok         | Schlüssel hinzugefügt: Lagerort, Lagerplatz (Wunsch Buchhaltung)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-12-20 | MFU     | ok         | Spalte "Sortierung" und Key für Sortierung des Inventurbuchblatts hinzugefügt
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-12-20 | MFU     | ok         | GL015 - Basiseinheitencode aus Einheit für Verbrauchsbuchblatt genommen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2013-05-16 | MFU     | ok         | GL017 - Lookup in Buchblätter bei Belegnummer zur vereinheitlichung der Texte der Buchungen
    //                                             (Für Auswertungen)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2014-04-29 | Petsch  | ok         | Update von 2009 auf 2013R2 (Prod. Order No. => Order No.) etc.
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2015-08-20 | MFU     | ok         | GL018 - Artikelbeschreibung bei löschen der Artikelnummer auch löschen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-02-22 | MFU     | ok         | "Source No" und "Source Type" editierbar gemacht, für eingabe in Artikelbuchblatt von Suchtgiftbuchungen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-02-26 | MFU     | ok         | GL019 - Reservierungsposten vor dem Buchen der FA Verbräuche löschen, damit kein Verbuchen in 2 Zeilen passiert
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-03-07 | MFU     | ok         | GL020 - Geschäftsbuchungsgruppe bei Verbrauchbuchungen zu FA mit ProjektNr mitnehmen -> Wird bei Lagerreg dann auf richtige Sachkonten geschrieben
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-07-15 | MFU     | ok         | GL021 - Geschäftsbuchungsgruppe bei Istmeldungen zu FA mit ProjektNr mitnehmen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2018-02-20 | PRA     | ok         | GL022 - Artikel Bemerkung Umlagerung
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2020-08-04 | DKO     | ok         | GL023 - Wenn Charge bereits vorhanden, Felder aber unverändert, dann Buchung zulassen
    // ------------------------------------------------------------------------------------------------------------------------------------
    fields
    {
        field(50000; Lagerstand; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("Item No."),
                                                                              "Location Code" = FIELD("Location Code")));
            FieldClass = FlowField;

            trigger OnLookup()
            var
                tempRecItemLedgerEntry: Record 32 temporary;
                ActionReturn: Action;
            begin

                //-UPDATE2013 -> Nur zur Info im Verbrauchsbuchblatt ohne Lagerortfilter öffnen
                IF "Journal Template Name" = 'FAVERB' THEN BEGIN
                    TESTFIELD("Item No.");
                    tempRecItemLedgerEntry."Item No." := "Item No.";
                    tempRecItemLedgerEntry.SETRANGE("Item No.", "Item No.");
                    tempRecItemLedgerEntry.SETRANGE(Open, TRUE);
                    //TODOPBA - PAGE.RUNMODAL(PAGE::Page50169, tempRecItemLedgerEntry);
                END;
                //+LAN003
            end;
        }
        field(50001; "Packungsgröße"; Text[10])
        {
            CalcFormula = Lookup(Item."Packungsgröße" WHERE("No." = FIELD("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; Sortierung; Text[30])
        {
        }
        field(50003; Regalnummer; Text[30])
        {
            CalcFormula = Lookup(Item."Shelf No." WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(50041; "User ID"; Code[50])
        {
            Description = 'CCU11,CCU109,LIMS';
        }
        field(50102; "CEP Nr"; Code[50])
        {
            Description = 'LQ18.1';

            trigger OnValidate()
            var
            begin
                /*
                IF ("Item No." <> '' ) AND ("CEP Nr" <> '') THEN BEGIN
                  recAHA.SETRANGE(ArtikelnrZusatz,"Item No.");
                  recAHA.SETRANGE(HerstellerNr,HerstellerNr);
                  recAHA.SETFILTER(Status,'<>Gesperrt');
                  bFound := FALSE;
                  IF NOT recAHA.ISEMPTY THEN BEGIN
                    IF recAHA.FINDSET THEN
                      REPEAT
                        IF recAHK.GET(recAHA.RefID) THEN BEGIN
                          IF (recAHK."CEP Nr" = "CEP Nr") OR (recAHK."DMF Nr" = "CEP Nr") THEN
                            bFound := TRUE;
                        END;
                      UNTIL (recAHA.NEXT = 0) OR bFound;
                  END;
                  IF NOT bFound THEN
                    ERROR('ungültige CEP Nr ''%1'' für Artikel ''%2'', Hersteller ''%3''',"CEP Nr","Item No.",HerstellerNr);
                END;
                */

            end;
        }
        field(50103; HerstellerNr; Code[20])
        {
            Description = 'LQ18.1';

            trigger OnValidate()
            var
            begin
                /*
                IF ("Item No." <> '' ) AND (HerstellerNr <> '') THEN BEGIN
                  recAHA.SETRANGE(ArtikelnrZusatz,"Item No.");
                  recAHA.SETRANGE(HerstellerNr,HerstellerNr);
                  recAHA.SETFILTER(Status,'<>Gesperrt');
                  IF recAHA.ISEMPTY THEN
                    ERROR('ungültiger Hersteller ''%1'' für den Artikel ''%2''',HerstellerNr,"Item No.");
                END;
                */

            end;
        }
        field(50500; "Externe Rahmennr."; Code[20])
        {
            Description = 'LAN1.00';
        }
        field(50501; Abrufdatum; Date)
        {
            Description = 'LAN1.00';
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
        field(50510; "Bestellnr."; Code[20])
        {
            Description = 'LAN1.00';
        }
        field(50511; Bestelldatum; Date)
        {
            Description = 'LAN1.00';
        }
        field(50512; "Ländercode"; Code[10])
        {
            Description = 'LAN1.00';
            TableRelation = "Country/Region";
        }
        field(50513; Naturalrabattmenge; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'LAN1.00';
        }
        field(50514; Verkaufsstatistikcode; Code[10])
        {
            Description = 'LAN1.00';
        }
        field(50515; "Währungsfaktor"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50524; "Suchtgift/Psychotrop"; Text[1])
        {
            Description = 'LAN1.00';
        }
        field(50525; "Verkaufschargennr."; Code[20])
        {
            Description = 'LAN1.00';

            trigger OnLookup()
            begin
                //-LAN004
                IF "Entry Type" <> "Entry Type"::Output THEN
                    HoleCharge;
                //+LAN004
            end;

            trigger OnValidate()
            var
                vergleich: Code[20];
                Item: Record Item;

            begin
                //-LAN004
                //IF ("Entry Type" <> "Entry Type"::Purchase) AND ("Entry Type" <> "Entry Type"::"Positive Adjmt.") THEN
                //  FIELDERROR("Entry Type",Text50004);

                vergleich := xRec."Verkaufschargennr.";
                IF "Line No." = 0 THEN
                    vergleich := '';
                IF ("Verkaufschargennr." <> vergleich) THEN BEGIN
                    Item.GET("Item No.");
                    IF Item."Item Tracking Code" = '' THEN BEGIN
                        "Verkaufschargennr." := '';
                        MESSAGE('Artikel ist nicht chargenpflichtig!');
                    END;
                END;

                IF "Lot No." <> '' THEN
                    IF NOT NeueCharge() THEN
                        IF Chargenstamm."Verkaufschargennr." <> "Verkaufschargennr." THEN //GL023
                            ERROR('Bestehende Charge %1 kann nicht verändert werden!', "Lot No.");

                LöscheCharge();
                EingabeCharge();
                //+LAN004
            end;
        }
        field(50528; "Urspr. Menge"; Decimal)
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
        field(50553; "Hole von"; Decimal)
        {
            CaptionML = DEU = 'Hole Von', ENU = 'Get from';

            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("Item No."),
                                                                              "Location Code" = FIELD("Location Code"),
                                                                              Open = CONST(true)));
            DecimalPlaces = 0 : 5;
            //Editable = false;   //Mit Editable false funktioniert das OnLookup nicht!
            FieldClass = FlowField;


            trigger OnLookup()
            var
                tempRecItemLedgerEntry: Record "Item Ledger Entry" temporary;
                ActionReturn: Action;
            begin

                TESTFIELD("Item No.");
                tempRecItemLedgerEntry."Item No." := "Item No.";
                tempRecItemLedgerEntry.SETRANGE("Item No.", "Item No.");
                tempRecItemLedgerEntry.SETRANGE(Open, TRUE);
                IF "Location Code" <> '' THEN BEGIN
                    tempRecItemLedgerEntry."Location Code" := "Location Code";
                    tempRecItemLedgerEntry.SETRANGE("Location Code", "Location Code");
                END;

                ActionReturn := PAGE.RUNMODAL(PAGE::UmlagerInfoNeu, tempRecItemLedgerEntry);
                IF (ActionReturn = ACTION::LookupOK) OR (ActionReturn = ACTION::OK) THEN BEGIN
                    "Location Code" := tempRecItemLedgerEntry."Location Code";
                    "Bin Code" := tempRecItemLedgerEntry.Lagerplatzhilfsfeld;

                    IF "Entry Type" IN ["Entry Type"::Transfer, "Entry Type"::"Negative Adjmt."] THEN BEGIN
                        IF ("Entry Type" = "Entry Type"::"Negative Adjmt.") then
                            VALIDATE(Quantity, tempRecItemLedgerEntry."Remaining Quantity");

                        VALIDATE("Lot No.", tempRecItemLedgerEntry."Lot No.");

                        //Wird mit dem Validate der LotNo schon befüllt  "Verkaufschargennr." := tempRecItemLedgerEntry."Verkaufschargennr.";
                        IF ("Entry Type" = "Entry Type"::Transfer) THEN
                            VALIDATE(Quantity, tempRecItemLedgerEntry."Remaining Quantity");

                    END;
                END;

            end;

            trigger OnValidate()
            var
                tTest: Text[10];
            begin
                tTest := '';
            end;
        }
        field(50554; "Lieferantenchargennr."; Code[20])
        {
            Description = 'LAN1.00';

            trigger OnValidate()
            begin
                //-LAN004
                IF ("Entry Type" <> "Entry Type"::Purchase) AND ("Entry Type" <> "Entry Type"::"Positive Adjmt.") THEN
                    FIELDERROR("Entry Type", 'FEHLENDE VARIABLE T83');
                IF "Lot No." <> '' THEN
                    IF NOT NeueCharge THEN
                        IF Chargenstamm."Lief. Chargennr." <> "Lieferantenchargennr." THEN //GL023
                            ERROR('FEHLENDE VARIABLE T83', FIELDCAPTION("Lieferantenchargennr."), "Lot No.");
                EingabeCharge;
                //+LAN004
            end;
        }
        field(50555; Packmittelversion; Code[20])
        {
            Description = 'Petsch';

            trigger OnValidate()
            begin
                //-LAN004
                IF ("Entry Type" <> "Entry Type"::Purchase) AND ("Entry Type" <> "Entry Type"::"Positive Adjmt.") THEN
                    FIELDERROR("Entry Type", 'FEHLENDE VARIABLE T83');
                IF "Lot No." <> '' THEN
                    IF NOT NeueCharge THEN
                        IF Chargenstamm.Packmittelversion <> Packmittelversion THEN //GL023
                            ERROR('FEHLENDE VARIABLE T83', FIELDCAPTION(Packmittelversion), "Lot No.");
                EingabeCharge;
                //+LAN004
            end;
        }

        //MFU 12.04.2024  Nicht Nötig
        /*
        field(50556; "Hole nach"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("Item No."),
                                                                              "Location Code" = FIELD("New Location Code"),
                                                                              Open = CONST(true)));
            DecimalPlaces = 0 : 5;
            Description = 'LAN1.00';
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup()
            var
                tempRecItemLedgerEntry: Record "32" temporary;
                ActionReturn: Action;
            begin
                //-LAN003
                //Verwendet, um bei Umlagerungen Lagerplätze zu finden, wo der Artikel schon liegt.
                TESTFIELD("Item No.");
                tempRecItemLedgerEntry."Item No." := "Item No.";
                tempRecItemLedgerEntry.SETRANGE("Item No.", "Item No.");
                tempRecItemLedgerEntry.SETRANGE(Open, TRUE);
                IF "New Location Code" <> '' THEN BEGIN
                    tempRecItemLedgerEntry."Location Code" := "New Location Code";
                    tempRecItemLedgerEntry.SETRANGE("Location Code", "New Location Code");
                END;

                IF "Entry Type" IN ["Entry Type"::Transfer] THEN BEGIN
                    //TODOPBA - ActionReturn := PAGE.RUNMODAL(PAGE::Page50169, tempRecItemLedgerEntry);
                    IF (ActionReturn = ACTION::LookupOK) OR (ActionReturn = ACTION::OK) THEN BEGIN
                        //IF Form.RUNMODAL(Form::UmlagerungsinfoNeu, tempRecItemLedgerEntry) = ACTION::LookupOK THEN BEGIN
                        "New Location Code" := tempRecItemLedgerEntry."Location Code";
                        "New Bin Code" := tempRecItemLedgerEntry.Lagerplatzhilfsfeld;
                        //VALIDATE("Lot No.",tempRecItemLedgerEntry."Lot No.");  HoleNach: nur für Lagerort+Platz suchen, keine Chargennr!
                        //"Verkaufschargennr." := tempRecItemLedgerEntry."Verkaufschargennr.";
                    END;
                END;
                //+LAN003
            end;
        }
        */

        modify(Quantity)
        {

            trigger OnBeforeValidate()
            var
                vergleich: Decimal;
            begin

                // >> Task58.01
                //Nach Mengenänderung in Buchblatt, bei Chargenpflichtigen Artikel die Artikelverfolgung auch Anpassen
                vergleich := xRec.Quantity;
                IF "Line No." = 0 THEN
                    vergleich := 0;
                IF (Quantity <> vergleich) THEN BEGIN
                    LöscheCharge();
                    IF (Rec."Journal Template Name" = 'INVENTUR') AND (Rec."Entry Type" = Rec."Entry Type"::"Negative Adjmt.")
                        AND (Rec."Lot No." = '') AND (xRec."Lot No." > '') THEN
                        Rec."Lot No." := xRec."Lot No.";
                    EingabeCharge();
                END;
                // << Task58.01

            end;
        }

        modify("Lot No.")
        {

            trigger OnAfterValidate()
            var
                vergleich: code[20];
            begin

                // >> CCU7.01
                vergleich := xRec."Lot No.";
                IF "Line No." = 0 THEN
                    vergleich := '';
                IF ("Lot No." <> vergleich) THEN BEGIN
                    Item.GET("Item No.");
                    IF Item."Item Tracking Code" = '' THEN
                        ERROR(Text50000);
                    "Verkaufschargennr." := '';
                    "Expiration Date" := 0D;
                    //Packmittelversion := '';
                    "Lieferantenchargennr." := '';
                    LöscheCharge;
                    IF "Lot No." <> '' THEN BEGIN
                        IF NOT Chargenstamm.GET("Item No.", "Variant Code", "Lot No.") THEN BEGIN
                            IF "Entry Type" IN [1, 3, 4, 5] THEN BEGIN         //Abgang, Verkauf, Umlagerung, Verbrauch   MFU 09.04.2021 Zugang (2) dazu;  CCU32.02 Zugang wieder zulassen
                                ERROR(Text50002, "Lot No.")
                            END ELSE BEGIN
                                IF ("Order Type" <> "Order Type"::Production) AND ("Order No." = '') THEN BEGIN //...bei Istmeldungen wäre diese Meldung wenig sinnvoll
                                    LotNoCheck;
                                    MESSAGE(Text50003, "Lot No.");
                                    "Verkaufschargennr." := "Lot No.";
                                    "Expiration Date" := 0D;

                                END;

                            END;
                        END ELSE BEGIN
                            "Lot No." := Chargenstamm."Lot No.";
                            "Verkaufschargennr." := Chargenstamm."Verkaufschargennr.";
                            "Expiration Date" := Chargenstamm."Expiration Date";

                        END;
                        EingabeCharge;
                    END;
                END;
                // << CCU7.01

            end;

            //OnLookup Trigger nur auf der Page verfügbar

        }

        modify("Expiration Date")
        {
            trigger OnAfterValidate()
            var
                vergleich: Date;
            begin

                if (xRec."Expiration Date" <> Rec."Expiration Date") then begin
                    IF (Rec."Entry Type" = Rec."Entry Type"::"Positive Adjmt.") or (Rec."Entry Type" = Rec."Entry Type"::Purchase) then begin
                        LöscheCharge();
                        EingabeCharge();
                    end;
                end;

            end;
        }


    }
    var
        "//-LAN1.00 Var": Integer;
        ItemLedgEntry: Record "32";
        Chargenstamm: Record "6505";
        LotMgt: Codeunit "50002";
        cuChargenVerwaltung: Codeunit ChargenverwaltungPageApp;
        cuNaviPharma: Codeunit "50001";
        cuCodeSammlung: Codeunit "50000";
        SalesBlockedErr: Label 'You cannot sell this item because the Sales Blocked check box is selected on the item card.';
        PurchasingBlockedErr: Label 'You cannot purchase this item because the Purchasing Blocked check box is selected on the item card.';
        BlockedErr: Label 'You cannot purchase this item because the Blocked check box is selected on the item card.';
        Item: Record Item;


        Text50000: TextConst DEU = 'Artikel ist nicht chargenpflichtig', ENU = 'Item does not require batching';
        Text50002: TextConst DEU = 'Charge %1 existiert nicht', ENU = 'Batch %1 does not exist';
        Text50003: TextConst DEU = 'Charge %1 existiert noch nicht und wird mit der Zugangsbuchung angelegt.', ENU = 'Batch %1 does not exist and will be created with the receipt posting!';





    procedure "LöscheCharge"()
    begin
        //-LAN004
        IF "Line No." = 0 THEN
            EXIT;

        cuChargenVerwaltung.LöscheCharge(
          DATABASE::"Item Journal Line", "Entry Type", "Journal Template Name", "Journal Batch Name",
                     0, "Line No.", "Lot No.");
        //+LAN004
    end;

    procedure EingabeCharge()
    begin
        //-LAN004
        IF "Line No." = 0 THEN
            EXIT;
        IF "Lot No." = '' THEN
            EXIT;
        IF "Item No." = '' THEN
            EXIT;

        cuChargenVerwaltung.EingabeChargeForItemJnlLine(Rec);
        /*
        LotMgt.EingabeCharge(
          DATABASE::"Item Journal Line", "Entry Type", "Journal Template Name", "Journal Batch Name", 0, "Line No.",
          "Qty. per Unit of Measure", "Quantity (Base)", "Invoiced Qty. (Base)", "Lot No.",
          "Verkaufschargennr.", "Lieferantenchargennr.", Packmittelversion, "Expiration Date", "Item No.", "Variant Code",
          "Location Code", 0D);
        //+LAN004
        */
    end;

    procedure HoleCharge()
    var
        Item: Record Item;
    begin
        //-LAN004
        Item.GET("Item No.");
        IF Item."Item Tracking Code" = '' THEN
            ERROR('FEHLENDE VARIABLE T83');
        Chargenstamm."Item No." := "Item No.";
        Chargenstamm."Variant Code" := "Variant Code";
        Chargenstamm."Lot No." := "Lot No.";
        Chargenstamm."Location Filter" := "Location Code";
        Chargenstamm."Bin Filter" := "Bin Code";

        IF LotMgt.Chargenpostenwählen(Chargenstamm) THEN BEGIN
            "Lot No." := Chargenstamm."Lot No.";
            "Verkaufschargennr." := Chargenstamm."Verkaufschargennr.";
            "Expiration Date" := Chargenstamm."Expiration Date";
            IF Item.Artikelart = Item.Artikelart::Fertigprodukt THEN
                TESTFIELD("Verkaufschargennr.");
            //Rec.Modify();
            VALIDATE("Lot No.", Chargenstamm."Lot No.");
        END;
        //+LAN004
    end;

    procedure NeueCharge(): Boolean
    begin
        //-LAN004
        IF NOT Chargenstamm.GET("Item No.", "Variant Code", "Lot No.") THEN
            EXIT(TRUE);
        //+LAN004
    end;

    procedure LotNoCheck()
    var
        recItem: Record "27";
        recLotNoInfo: Record "6505";
    begin
        //Eindeutigkeit der Rohstoffchargennr.
        recItem.GET("Item No.");
        IF recItem.Artikelart IN [recItem.Artikelart::Rohstoff, recItem.Artikelart::Verpackungsstoff] THEN BEGIN
            recLotNoInfo.SETCURRENTKEY("Lot No.");
            recLotNoInfo.SETRANGE("Lot No.", "Lot No.");
            IF recLotNoInfo.FIND('-') THEN
                IF recLotNoInfo."Item No." <> "Item No." THEN
                    ERROR('Rohstoffcharge wurde schon zu anderer Artikelnummer vergeben!');
        END;
    end;




}
