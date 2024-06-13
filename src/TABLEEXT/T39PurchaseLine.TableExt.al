tableextension 50015 T39PurchaseLine extends "Purchase Line"
{ // version NAVW114.43,NAVDACH14.43,TODOPBA

    // LAN001 12.11.09 ACPSS LAN1.00
    //   New Fields: ID 50010, 50506 - 50511, 50514 - 50516, 50526, 50528 - 50530, 50550, 50551, 50580 - 50584
    // LAN002 21.12.09 ACPSS LAN1.00
    //   Bemerkung anzeigen
    // LAN003 21.12.09 ACPSS LAN1.00
    //   Preiseinheit, EK-Preis PE, Mengeninfo Mengenstaffel
    // LAN004 21.12.09 ACPSS LAN1.00
    //   Opt. Menge, Beschreibung aus Artikellieferant
    // LAN005 21.12.09 ACPSS LAN1.00
    //   Chargen
    // LAN006 21.12.09 ACPSS LAN1.00
    //   Ändern der Menge pro Einheit
    // LAN007 21.12.09 ACPSS LAN1.00
    //   Abfrage Bestellstatus
    // LAN008 21.12.09 ACPSS LAN1.00
    //   Statistik
    // LAN009 21.12.09 ACPSS LAN1.00
    //   Preisfindung
    // LAN010 21.12.09 ACPSS LAN1.00
    //   Wertgutschrift
    // 
    // 
    // GL001 Lieferantenbewertung
    // GL002 Flowfields: Einkäufercode, Bestelldaum
    // CheckInternalLotNr() nicht mehr eingebaut
    // Druckunterlagenverwaltung nicht mehr eingebaut
    // MFU: Key angepasst für Rahmenstelellung
    // 
    // ------------------------------------------------------------------------------------------------------------------------------------
    // Datum      | Autor   | Status     | Beschreibung
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-02-09 | Petsch  | ok         | Update von 3.60
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-04-09 | Petsch  | ok         | Funktion Wertgutschrift() Lan010 komplett umgeschrieben
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-09-10 | MFU     | ok         | GL003 - Bei Lieferantenbewertungsabfrage Historische Daten nicht mit einbeziehen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-12-16 | Pranter | ok         | Neuer Key (Document Type,Type,Packmittelversion)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-01-14 | Pranter | ok         | Neuer Key (Document Type,Type,No.,Variant Code,Drop Shipment,Location Code,Bin Code,...)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-02-16 | MFU     | ok         | GL004 - Andere Prüfung bei "Artikel-Hersteller" Abfrage
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-04-08 | MFU     | ok         | GL005 - Lagerort wechsel setze auch EK-Preis wieder auf Standardwert -> wurde entfernt
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-11-03 | Petsch  | ok         | in CalcVATAmountLines() Fehler bei MwSt und in Gutschrift reingeholten Rücklieferungen behoben
    //                                     https://mbs.microsoft.com/knowledgebase/KBDisplay.aspx?scid=kb;EN-US;2545999
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-12-06 | MFU     | ok         | GL006 - Bei Lieferantenbewertung den Varianten Code mit berücksichtigen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2013-01-24 | MFU     | ok         | Key erweitert für Rahmenbestellmengen Berechung in Item Tabelle
    //                                     Document Type,Type,No.,Variant Code,Drop Shipment,Location Code,Expected Receipt Date,Blanket Or
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2013-10-16 | MFU     | ok         | Key eingefügt  "Document Type,Type,Expected Receipt Date" für Bericht "Lager-Anlieferungen"
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-05-10 | MFU     | ok         | GL007 - Gleiche Chargennummer bei unterschiedlichen Artikel bei Wareneingang nicht zulassen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-05-23 | MFU     | ok         | Feld "BeschreibungLang" BLOB für Textspeicherung eingebaut
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-06-27 | MFU     | ok         | ZU GL007 - Rückbau auf Ursprüngliche Variante (Einkauf auf unterschiedliche Artikel mit gleicher Chargennummer zulassen (Bei HF und Fertigartikel))
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-07-22 | MFU     | ok         | GL008 - Bei "Zuordnung zu Artikelnummer" bei Sachkonto Einkäufen nicht mehr die Artikeldaten übernehmen (Palko)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2017-03-13 | MFU     | ok         | GL009 - Bei Bestellung auf Projekt nur Artikel ohne Lagerbewertun zulassen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2017-06-02 | MFU     | ok         | GL010 - Bei Rahmenbestellungsnr schreiben in Bestellzeile wurde die Zeilennummer leer gelassen, was zu keiner Abbuchung vom Rahmen beim buchen geführt hat
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2018-06-06 | MFU     | ok         | GL011 - Ablaufdatum und VK-Charge aus Chargenplanung bei Bestellung vorschlagen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2018-07-20 | MFU     | ok         | Palettenanzahl dazu
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2018-08-09 | MFU     | ok         | GL012 - Datum Übernahme vom Kopf in die Zeilen neu geregelt (Maurer)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2018-09-04 | DKO     | ok         | Neue Spalte "CEP Nr" - Für LQ18 - Lieferantenqualifizierung
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2018-09-04 | DKO     | ok         | GL013 - CEP Nr. wenn möglich aus ArtikelherstellerKarte beziehen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2018-12-05 | DKO     | ok         | GL014 - AHK Status Überprüfung an neuer Stelle, nachdem sowohl Artikel, Lieferant als auch Hersteller bekannt sind
    //                                             Eigener Lookup für HerstellerNr
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2018-12-18 | DKO     | ok         | GL015 - Ablaufdatum DataMatrix Feld für EU-Hub hinzugefügt.
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2019-01-11 | DKO     | ok         | GL016 - Frei für Alle Artikel - bei HerstellerNr Überprüfung abfragen                                                                  - Lookup anpassen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2019-02-18 | DKO     | ok         | GL017 - EK-Preis PE auf EK-Preis (ohne MWst) validaten und vice versa
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2019-03-29 | DKO     | ok         | GL018 - CheckCepChange - Bei Änderung von CEP Nr. Benachrichtigung an QS per Mail
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2019-04-05 | DKO     | ok         | GL019 - CheckHerstellerIdentical - Wenn mögliche Hersteller quasi identisch / gleichwertig, true zurückliefern
    //                                           - bei mehreren möglichen Herstellern die identisch / gleichwertig sind, den ersten nehmen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2019-05-06 | DKO     | ok         | GL020 - Probleme bei Beleg kopieren wegen RUNMODAL --> Dialog nicht anzeigen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2019-09-06 | DKO     | ok         | GL021 - Hersteller OnLookup --> Je nach Artikelart Liste nach Herstellertyp filtern
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2020-01-20 | MFU     | ok         | GL022 - Lagerort ändern ohne Mengen update -> Für Schenker Anlieferung
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2021-05-17 | DKO     | ok         | GL023 - CheckCepChange - DMF Nr. abfragen
    //                                           - CEP Nr. nur bei Wirkstoffen/Leer-Kapseln befüllen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2021-06-01 | DKO     | ok         | GL024 - CheckCepChange - Abfrage umgestaltet
    // 
    // 
    // 
    // wieder zulassen von Einkauf mit gleicher Chargennummer auf HF und Fertigartikel
    fields
    {
        field(50000; Preisfaktor; Decimal)
        {
            Description = 'Petsch';
        }
        field(50001; Packmittelversion; Code[20])
        {
            Description = 'Petsch';
            TableRelation = IF (Type = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("No."));

            trigger OnValidate()
            var
                Chargenstamm: Record "Lot No. Information";
            begin
                //-LAN005
                Chargenstamm.SETRANGE("Item No.", "No.");
                Chargenstamm.SETRANGE("Variant Code", "Variant Code");
                Chargenstamm.SETRANGE("Lot No.", "Lot No.");
                IF Chargenstamm.FINDFIRST THEN BEGIN
                    Packmittelversion := Chargenstamm.Packmittelversion;
                    MESSAGE('Keine Textvariable T39', "No.", FIELDCAPTION(Packmittelversion), Packmittelversion);
                END;

                VALIDATE("Lot No.");
                //+LAN005
            end;
        }
        field(50002; "DruckUnterlagenPrüfung"; Option)
        {
            Description = 'Petsch';
            OptionMembers = " ",offen,erledigt;
        }
        field(50003; "Einkäufercode"; Code[20])
        {
            CalcFormula = Lookup("Purchase Header"."Purchaser Code" WHERE("Document Type" = FIELD("Document Type"),
                                                                           "No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(50004; Bestelldatum; Date)
        {
            CalcFormula = Lookup("Purchase Header"."Order Date" WHERE("Document Type" = FIELD("Document Type"),
                                                                       "No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(50005; HerstellerNr; Code[20])
        {

        }
        field(50006; "CEP Nr"; Code[50])
        {

        }
        field(50010; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            Description = 'LAN1.00';
            TableRelation = IF (Type = CONST(Item)) "Lot No. Information"."Lot No." WHERE("Item No." = FIELD("No."),
                                                                                         "Variant Code" = FIELD("Variant Code"));
            ValidateTableRelation = false;
        }
        field(50500; "Off. Gesamtmenge in Bestellung"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Outstanding Qty. (Base)" WHERE("Document Type" = CONST("Order"),
                                                                               Type = CONST(Item),
                                                                               "No." = FIELD("No.")));
            DecimalPlaces = 0 : 5;
            Description = 'LAN1.00';
            Editable = false;
            FieldClass = FlowField;
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
        field(50511; "Opt. Menge"; Text[20])
        {
            Description = 'LAN1.00';
        }
        field(50514; "Suchtgift/Psychotrop"; Text[1])
        {
            Description = 'LAN1.00';
        }
        field(50515; "Direct Unit Cost PE"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Direct Unit Cost PE';
            Description = 'LAN1.00';
        }
        field(50516; "Mengeninfo Mengenstaffel"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'LAN1.00';
            Editable = false;
        }
        field(50526; "Lieferantenchargennr."; Code[20])
        {
            Description = 'LAN1.00';

            trigger OnValidate()
            var
                Artikel: Record "27";
                Chargenstamm: Record "6505";
            begin
            end;
        }
        field(50528; "Verkaufschargennr."; Code[20])
        {
            Description = 'LAN1.00';

            trigger OnValidate()
            var
                Artikel: Record "27";
                Chargenstamm: Record "6505";
            begin
                //-LAN005
                Artikel.GET("No.");
                Chargenstamm.SETRANGE("Item No.", "No.");
                Chargenstamm.SETRANGE("Variant Code", "Variant Code");
                Chargenstamm.SETRANGE("Lot No.", "Lot No.");
                IF Chargenstamm.FINDFIRST THEN BEGIN
                    "Verkaufschargennr." := Chargenstamm."Verkaufschargennr.";
                    MESSAGE('KEINE TEXTVARIABLE T39', "No.", FIELDCAPTION("Verkaufschargennr."), "Verkaufschargennr.");
                END;

                VALIDATE("Lot No.");
                //+LAN005
            end;
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

            trigger OnValidate()
            var
                artikel: Record "27";
                chargenstamm: Record "6505";
            begin


                artikel.GET("No.");
                chargenstamm.SETRANGE("Item No.", "No.");
                chargenstamm.SETRANGE("Variant Code", "Variant Code");
                chargenstamm.SETRANGE("Lot No.", "Lot No.");
                IF chargenstamm.FINDFIRST THEN BEGIN
                    "Expiration Date" := chargenstamm."Expiration Date";
                    MESSAGE('KEINE TEXTVARIABLE T39', "No.", FIELDCAPTION("Expiration Date"), "Expiration Date");
                END;

                VALIDATE("Lot No.");

            end;
        }
        field(50550; Gebindeanzahl; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'LAN1.00';
        }
        field(50551; Gebindeartencode; Code[10])
        {
            Description = 'LAN1.00';
            //TableRelation = Gebindeart;
        }
        field(50552; "Abruf Bestellmenge"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Outstanding Quantity" WHERE("Document Type" = CONST("Order"),
                                                                            "Blanket Order No." = FIELD("Document No."),
                                                                            "Blanket Order Line No." = FIELD("Line No.")));
            DecimalPlaces = 0 : 5;
            Description = 'LAN1.00';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50553; Palettenanzahl; Integer)
        {
        }
        field(50580; "Bezug Artikelnr."; Code[20])
        {
            Description = 'LAN1.00';
            TableRelation = Item;
        }
        field(50581; "Bezug Art.Posten"; Integer)
        {
            Description = 'LAN1.00';
        }
        field(50583; "Wertkorrektur zu Artikelposten"; Integer)
        {
            Description = 'LAN1.00';
        }
        field(50584; "Zuordnung zu Artikelnr."; Code[20])
        {
            Description = 'LAN1.00';
            TableRelation = Item;

            trigger OnValidate()
            begin
                //-LAN010
                "Wertkorrektur zu Artikelposten" := 0;
                Wertgutschrift;
                //+LAN010
            end;
        }
        field(50585; BeschreibungLang; BLOB)
        {
            Description = 'MFU';
        }

        field(50587; "Expiration Date DM"; Text[6])
        {
            Description = 'GL015,EUHUB';
            Numeric = true;
            Width = 6;

            trigger OnValidate()
            begin
                CheckExpDate(); //GL015
            end;
        }
    }
    var
        "//-LAN1.00 Var": Integer;
        Chargenstamm: Record "6505";
        LotMgt: Codeunit "50002";
        Codesammlung: Codeunit "50000";
        SpeichernGefragt: Boolean;
        "BemerkungsmeldungUnterdrücken": Boolean;
        Text50000: Label 'Artikel %1, im Chargenstamm besteht bereits ein Eintrag; daher wurde %2 auf %3 gesetzt.';
        Text50001: Label '%1 zu Charge %2 kann nur mehr im Stamm verändert werden!';
        Text50002: Label 'Charge existiert nicht.';
        Text50003: Label 'Charge existiert noch nicht und wird mit der Zugangsbuchung angelegt.';
        Text50004: Label 'Menge pro Einheit darf nicht negativ sein.';
        Text50005: Label 'Art muß leer, Sachkonto oder Zuschlag sein bei Wertgutschriften!';
        cuNaviPharma: Codeunit "50001";
        tmpCEPnr: Code[50];
        bFFAAactive: Boolean;
        PurchHeader: Record "Purchase Header";

    procedure FaktMengeCharge()
    var
        CurrentSignFactor: Integer;
    begin
        //-LAN005
        IF "Line No." = 0 THEN
            EXIT;
        IF "Lot No." = '' THEN
            EXIT;
        IF Type <> Type::Item THEN
            EXIT;
        IF "No." = '' THEN
            EXIT;

        LotMgt.FaktMengeCharge(
          DATABASE::"Purchase Line", "Document Type", "Document No.", '', 0, "Line No.", "Lot No.", "Qty. to Invoice (Base)");
        //+LAN005
    end;

    procedure LiefMengeCharge()
    var
        CurrentSignFactor: Integer;
    begin
        //-LAN005
        IF "Line No." = 0 THEN
            EXIT;
        IF "Lot No." = '' THEN
            EXIT;
        IF Type <> Type::Item THEN
            EXIT;
        IF "No." = '' THEN
            EXIT;

        LotMgt.LiefMengeCharge(
          DATABASE::"Purchase Line", "Document Type", "Document No.", '', 0, "Line No.", "Lot No.", "Qty. to Receive (Base)");
        //+LAN005
    end;

    procedure HoleCharge()
    begin
    end;

    procedure NeueCharge(): Boolean
    begin
        //-LAN005
        IF NOT Chargenstamm.GET("No.", "Variant Code", "Lot No.") THEN
            EXIT(TRUE);
        //+LAN005
    end;

    procedure "Änderungsabfrage"()
    var
        MsgText: Text[250];
    begin


        //-LAN007
        IF SpeichernGefragt THEN
            EXIT;

        Rec.GetPurchHeader;
        IF PurchHeader.Bestellstatus = PurchHeader.Bestellstatus::Versendet THEN BEGIN
            IF ("Line No." = 0) THEN
                MsgText := STRSUBSTNO('Bestellstatus ist %1!. Wollen Sie trotzdem neue Zeilen erfassen?', PurchHeader.Bestellstatus)
            ELSE
                MsgText := STRSUBSTNO('Bestellstatus ist %1!. Wollen Sie Ihre Änderung trotzdem speichern?', PurchHeader.Bestellstatus);
        END ELSE
            EXIT;

        SpeichernGefragt := TRUE;

        IF NOT CONFIRM(MsgText, TRUE) THEN
            ERROR('Änderungen wurden nicht gespeichert');
        //+LAN007
    end;

    procedure Wertgutschrift()
    var
        localRecPurchaseLine: Record "39";
        localRecItem: Record "27";
    begin

        "Wertkorrektur zu Artikelposten" := 0;


    end;

    procedure BlockeBemerkungsmeldung(newSetzeBemerkungsMeldung: Boolean)
    begin
        BemerkungsmeldungUnterdrücken := newSetzeBemerkungsMeldung;
    end;

    procedure Packungsgroesse() cPackungsgroesse: Text[20]
    var
        recItem: Record "27";
    begin
        IF Type = Type::Item THEN
            IF recItem.GET("No.") THEN
                cPackungsgroesse := recItem."Packungsgröße";
    end;

    procedure LotNoCheck()
    var
        recItem: Record "27";
        recLotNoInfo: Record "6505";
    begin

        recItem.GET("No.");
        IF recItem.Artikelart IN [recItem.Artikelart::Rohstoff, recItem.Artikelart::Verpackungsstoff] THEN BEGIN
            recLotNoInfo.SETCURRENTKEY("Lot No.");
            recLotNoInfo.SETRANGE("Lot No.", "Lot No.");
            IF recLotNoInfo.FINDFIRST THEN
                IF recLotNoInfo."Item No." <> "No." THEN
                    ERROR('Rohstoffcharge wurde schon zu anderer Artikelnummer vergeben!');
        END;

    end;

    procedure UrspMenge(nMengeBisher: Decimal)
    begin

        IF ("Document Type" IN ["Document Type"::Order, "Document Type"::Invoice, "Document Type"::"Blanket Order"]) AND
          (nMengeBisher <> 0) AND (Type = Type::Item) THEN BEGIN

            IF STRMENU(STRSUBSTNO('Ursprüngliche Menge auf %1 setzen?', CONVERTSTR(FORMAT(nMengeBisher), ',', '.')), 1) = 1 THEN
                "Urspr. Menge" := nMengeBisher;

        END;
    end;

    procedure CheckProjektArtikel(cItemNo: Code[20]; cJobNo: Code[20])
    var
        recItem: Record "27";
    begin

        IF (STRLEN(cItemNo) > 1) AND (STRLEN(cJobNo) > 1) THEN
            IF recItem.GET(cItemNo) THEN
                IF recItem."Inventory Value Zero" = FALSE THEN
                    ERROR('Eine Projektnummer ist nicht zulässig, wenn ein Artikel mit Lagerwert Bestellt wird!');
    end;


    local procedure CheckExpDate()
    var
        tYearHelp: Text[4];
        tYearHelpDM: Text[4];
        tMonHelp: Text[2];
        tMonHelpDM: Text[2];
        iDayHelp: Integer;
        iMonHelp: Integer;
    begin
        //-GL015
        IF ("Expiration Date DM" <> '') THEN BEGIN
            IF STRLEN("Expiration Date DM") < 6 THEN
                ERROR('DataMatrix Ablaufdatum muss Format JJMMTT (YYMMDD) haben!');

            IF EVALUATE(iMonHelp, COPYSTR("Expiration Date DM", 3, 2)) THEN BEGIN
                IF (iMonHelp < 1) OR (iMonHelp > 12) THEN
                    ERROR('DataMatrix Ablaufdatum muss Format JJMMTT (YYMMDD) haben!');
            END ELSE
                ERROR('DataMatrix Ablaufdatum muss Format JJMMTT (YYMMDD) haben!');

            IF EVALUATE(iDayHelp, COPYSTR("Expiration Date DM", 5, 2)) THEN BEGIN
                IF (iDayHelp < 0) OR (iDayHelp > 31) THEN
                    ERROR('DataMatrix Ablaufdatum muss Format JJMMTT (YYMMDD) haben!');
            END ELSE
                ERROR('DataMatrix Ablaufdatum muss Format JJMMTT (YYMMDD) haben!');

            IF ("Expiration Date" <> 0D) THEN BEGIN
                tYearHelp := FORMAT(DATE2DMY("Expiration Date", 3));
                tYearHelpDM := '20' + COPYSTR("Expiration Date DM", 1, 2);
                tMonHelp := Codesammlung.TextAuffuellen(FORMAT(DATE2DMY("Expiration Date", 2)), 2, '0');
                tMonHelpDM := COPYSTR("Expiration Date DM", 3, 2);
                IF (tYearHelp <> tYearHelpDM) OR (tMonHelp <> tMonHelpDM) THEN
                    IF NOT CONFIRM('DataMatrix Ablaufdatum: %1-%2 weicht von Ablaufdatum: %3-%4 ab. Trotzdem übernehmen?', FALSE, tMonHelp, tYearHelp, tMonHelpDM, tYearHelpDM) THEN
                        ERROR('Abgebrochen: DataMatrix Ablaufdatum weicht ab!');
            END;
        END;
        //+GL015
    end;
}



