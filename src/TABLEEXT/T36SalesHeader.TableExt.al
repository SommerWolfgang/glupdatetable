tableextension 50012 T36SalesHeader extends "Sales Header"
{
    fields
    {
        // version NAVW114.48,NAVDACH14.48,TODOPBA

        // LAN001 12.11.09 ACPSS LAN1.00
        //   New Fields: ID 50500, 50501, 50515, 50601, 50602, 51000, 52000
        //   Änderung Filter bei Feld ID 12
        // LAN002 12.11.09 ACPSS LAN1.00
        //   Musterlieferungen
        // LAN003 12.11.09 ACPSS LAN1.00
        //   Alternative Rechnungsadressen
        // LAN004 12.11.09 ACPSS LAN1.00
        //   Synchronisierung von Status und Auftragsstatus, Auftragsstatus prüfen
        // LAN005 21.12.09 ACPSS LAN1.00
        //   Auftragsdatum in den Zeilen aktualisieren
        // LAN006 21.12.09 ACPSS LAN1.00
        //   Auftrag löschen: Kommissionierung berücksichtigen
        // LAN007 21.12.09 ACPSS LAN1.00
        //   Lief. an Code, Fakt. an Code
        // LAN008 21.12.09 ACPSS LAN1.00
        //   Buchungsbeschreibung ist Deb.-Name
        // LAN009 05.01.10 ACPSS LAN1.00
        //   New Key: "Document Type,Auftragsstatus"
        // 
        // 
        // GL003 Sammelrechnungstyp, Sammelrechnungsadresse aus Rech. an Deb. ermitteln
        // GL007 Lief. an Code, Fakt. an Code ermitteln
        // GL009 Invoice copies und shipment copies vom Kunden übernehmen
        // GL010 Customer Price Group und Customer Discount Group vom Sell to, nicht Bill to Customer!
        // GL011 Rieder: Zahlungsformcode auch für Gutschriften vom Kunden übernehmen
        // GL012 Petsch: Check auf Kostenstellen bei Sachkonto vor Auftragsfreigabe
        // GL014 Vorbelegung VK-Lagerortcode
        // GL015 Auch bei Gutschriften "Shipment Date" vorbelegen
        // nicht mehr eingebaut 016 Skonto-,Fälligkeitsdatum bei Gutschriften und Reklamationen (WF, 15.11.06)
        // GL016 Wenn der Firmenkopf geändert wird auch die Geschäftsbuchungsgruppen im "Sales Header" und "Sales Line" mitändern
        // GL017 Lagerplatz und Lagerort bei Konsignationsgeschäfte laden
        // 
        // ------------------------------------------------------------------------------------------------------------------------------------
        // Datum      | Autor   | Status     | Beschreibung
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2010-02-10 | Petsch  | ok         | Update von 3.60
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2010-04-15 | MFU     | ok         | GL018 Lieferadresse bei Wertgutschriften wurde nicht richtig angelegt
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2010-04-28 | MFU     | ok         |
        // 
        // GL019 Zugehörigkeitsdatum für Wertgutschriften befüllen
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2010-05-04 | MFU     | ok         | GL020 Spalte "Ship-to Customer No." eingefügt
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2010-06-25 | MFU     | ok         | GL021 Contact von Kundenkarte nicht in den Verkäufen übernehmen
        //                                     (Kontakte werden nur zu Info Zwecken benötigt und nicht auf Belegen)
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2010-10-28 | Rieder  | ok         | Französische Caption für "USt.ID" und "Ihre Referenz" eingetragen
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2011-03-17 | MFU     | ok         | GL022 Buchungstext vom Kundennamen übernehmen
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2011-04-13 | MFU     | ok         | GL023 Bei der Eingabe eines Ortes die PLZ nich mitverändern
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2012-03-15 | Petsch  | ok         | Valeant-Felder InternerDatenaustausch mitnehmen
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2012-05-07 | Petsch  | ok         | Korr: GL012, es war nach dem get then begin ein semicolon, dieses entfernt
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2012-07-11 | MFU     | ok         | GL024 Fakturenadresse zum Rechnungskunden automatisch bei Kundenwahl eintragen
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2012-10-15 | MFU     | ok         | GL025 Postleitzahl bei Lookup von Ort nicht überschreiben (Wunsch Graf)
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2012-12-11 | MFU     | ok         | GL026 Zugehörigkeitsdatum für Wertrechnungen
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2012-12-27 | MFU     | ok         | GL027 Zugehörigkeitsdatum mit Buchungsdatum mitändern
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2012-12-29 | MFU     | ok         | GL028 Lieferdatumsfeld eingebaut
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2013-04-16 | MFU     | ok         | GL029 PDF-Rechnung Anpassungen
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2013-05-06 | MFU     | ok         | Feld "StornoMitRechNr" zur Erkennung einer Storno-Gutschrift für Suchtgiftabrechnung
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2013-09-30 | MFU     | ok         | GL030 PDF-Rechnung Mail Adresse bei Wechsel von Rechnungscode auch leer lassen
        //                                           -> Für keine PDF-Rechnung, wenn Rechnungskunde kein PDF bekommen soll
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2013-11-11 | MFU     | ok         | GL031 Stornierung mit Lieferscheinnummer, wenn Lieferschein mit Artikelbuchung vorhanden ist
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2013-11-25 | MFU     | ok         | GL032 Auftragsdatum bei Anlage einer Rahmenbestellung automatisch setzen
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2013-11-27 | MFU     | ok         | GL033 Bei Änderung der MWST-Geschäftsbuchungsgruppe auch die Geschäftsbuchungsgruppe dazu ändern
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2014-09-01 | MFU     | ok         | Key "Requested Delivery Date" für sortierung der Aufträge hinzugefügt
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2015-01-07 | MFU     | ok         | "Your Reference" von 35 auf 50 Zeichen erweitert
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2015-03-16 | MFU     | ok         | Spalte "Einfuhrbewilligung" eingebaut -> Für Automatische Benachrichtigung in Export Aufträgen
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2015-06-16 | MFU     | ok         | Funktion "UpdateCurrencyFactor" Global gesetzt (Aufruf aus CU-Kommissionierung)
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2015-09-18 | MFU     | ok         | Feld "VKBetragMenge+NR" eingebaut (Nebel NR Berechnung)
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2015-10-02 | MFU     | ok         | GL034 - Auftragsstatus nicht von Kommissionierung in was anderes manuell ändern lassen
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2015-11-24 | MFU     | ok         | GL035 - Auftragsdatum mit dem Buchungsdatum mit umsetzen
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2015-12-17 | MFU     | ok         | GL036 - Nach Ändern der Firmenkopfes wurde der Zeilenbetrag nicht richtig berechnen (Validate auf Teilmenge)
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2016-02-25 | MFU     | ok         | GL037 - Zugehörigkeitsdatum beim löschen im Kopf nicht in den Zeilen auf Leer setzen
        // ------------------------------------------------------------------------------------------------------------------------------------
        // 2016-12-05 | MFU     | ok         | EinAusFuhrBewilligungsNr Spalte eingebaut
        // --------------------------------------------------------------------------------------------------------
        // 2017-01-12 | MFU     | ok         | Lieferungstext * Spalten eingebaut
        // --------------------------------------------------------------------------------------------------------
        // 2017-03-23 | MFU     | ok         | GL038 -> Einmalige Preisanpassung für Rahmenaufträge  -> Wieder entfernt
        // --------------------------------------------------------------------------------------------------------
        // 2017-03-27 | MFU     | ok         | GL039 -> Transportversicherungshakerl Vorschlagen
        // --------------------------------------------------------------------------------------------------------
        // 2017-04-13 | MFU     | ok         | GL040 -> Bei Auftragsstatus auf "Geliefert" setzen, prüfen ob noch Mengen offen sind
        // --------------------------------------------------------------------------------------------------------
        // 2017-09-26 | MFU     | ok         | Spalte "Export_Mengenimport" für Suchtgiftabrechnung eingebaut
        // --------------------------------------------------------------------------------------------------------
        // 2017-11-07 | MFU     | ok         | GL041 -> Bei Lieferdatum Änderung auch das geplante Lieferdatum aktualisieren
        // --------------------------------------------------------------------------------------------------------
        // 2018-02-21 | MFU     | ok         | GL042 -> Gewünschtes Lieferdatum ändern lassen, auch wen Zugesagtes Lieferdatum gesetzt ist
        // --------------------------------------------------------------------------------------------------------
        // 2018-05-30 | MFU     | ok         | GL043 -> Mail Rechnungsadresse aus Rechnungsanschrift des Hauptkunden nehmen, wenn dort zum vorziehen definiert
        // --------------------------------------------------------------------------------------------------------
        // 2018-06-22 | MFU     | ok         | AblaufdatumDrucken und HerstelldatumDrucken Bool Felder angelegt
        // --------------------------------------------------------------------------------------------------------
        // 2018-07-13 | MFU     | ok         | Feld StornoMitRechNr war Enabled auf No, dehalb in Page nicht sichtbar -> wieder aktiviert
        // --------------------------------------------------------------------------------------------------------
        // 2018-08-07 | MFU     | ok         | Feld Korrekturgrund_ZSMOPL eingebaut
        // --------------------------------------------------------------------------------------------------------
        // 2018-11-07 | MFU     | ok         | GL044 -> Feld Address 3 eingebaut
        // --------------------------------------------------------------------------------------------------------
        // 2019-01-09 | MFU     | ok         | GL045 -> Ein / Ausfuhrbew. Nr erweitert
        // --------------------------------------------------------------------------------------------------------
        // 2019-05-17 | MFU     | ok         | GL046 -> Erstellungsdatum bei neuanlage befüllen
        // --------------------------------------------------------------------------------------------------------
        // 2019-10-11 | MFU     | ok         | GL047 -> Anpassungen Schenker
        // --------------------------------------------------------------------------------------------------------
        // 2020-04-06 | MFU     | ok         | GL048 -> Gewünschtes Lieferdatum bei Inland setzen -> Für BI4C Auftragsauswertung
        // --------------------------------------------------------------------------------------------------------
        // 2020-08-13 | TBO     | ok         | GL049 -> Ursprünglicher gewünscher Liefertermin
        // --------------------------------------------------------------------------------------------------------
        // 2021-04-12 | PBA     | ok         | CCU580 -> "VAT Registration No." aus Lieferadresse
        // --------------------------------------------------------------------------------------------------------


        field(50000; "shipment copies"; Integer)
        {
            Caption = 'Shipment Copies';
            Description = 'Petsch';
        }
        field(50001; "Preis Null"; Boolean)
        {
            Description = 'Petsch';
        }
        field(50002; "100% Zeilenrabatt"; Boolean)
        {
            Description = 'Petsch';
        }
        field(50003; "invoice copies"; Integer)
        {
            Caption = 'Invoice Copies';
            Description = 'Petsch';
        }
        field(50004; Auftragsnummer; Code[20])
        {
            Description = 'MFU';
        }
        field(50005; Firmenkopf; Code[10])
        {
            Caption = 'Company head';
            Description = 'Fuerbass';


            trigger OnValidate()
            var
                recCompanyInformation: Record "79";
            begin
                //-GL016
                IF recCompanyInformation.GET(Firmenkopf) THEN
                    IF STRLEN(recCompanyInformation."Gen. Bus. Posting Group") > 0 THEN BEGIN
                        "Gen. Bus. Posting Group" := recCompanyInformation."Gen. Bus. Posting Group";
                        VALIDATE("Gen. Bus. Posting Group");
                    END ELSE BEGIN
                        GetCust("Sell-to Customer No.");
                        "Gen. Bus. Posting Group" := Customer."Gen. Bus. Posting Group";
                        VALIDATE("Gen. Bus. Posting Group");
                    END;

                //+GL016
            end;
        }
        field(50007; Transportversicherung; Boolean)
        {
            Description = 'mfu';
        }
        field(50008; InternerDatenaustausch; Boolean)
        {
            Description = 'Petsch';
        }
        field(50009; EDIZielNr; Code[20])
        {
            Description = 'Petsch';
        }
        field(50010; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            Description = 'Petsch';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"));
        }
        field(50011; "Konsignationsgeschäft"; Boolean)
        {
            Description = 'Petsch';

            trigger OnValidate()
            var
                recInventorySetup: Record "313";
            begin
                //-GL017
                IF Konsignationsgeschäft = TRUE THEN BEGIN
                    recInventorySetup.GET;
                    "Location Code" := recInventorySetup.Konsignationslagerortcode;
                    "Bin Code" := recInventorySetup.Konsignationslagerfachcode;
                END;
                //+GL017
            end;
        }
        field(50012; Paketgewicht; Decimal)
        {
            Description = 'Petsch';
        }
        field(50013; Ladehilfsmittel; Text[30])
        {
            Description = 'Petsch';
        }
        field(50014; "Zugehörigkeitsdatum"; Date)
        {
            Caption = 'Posting Date';

            trigger OnValidate()
            begin
                //-GL019
                //Zeilen Updaten
                UpdateSalesLines(FIELDCAPTION(Zugehörigkeitsdatum), FALSE);
                //+GL019
            end;
        }
        field(50015; "Ship-to Customer No."; Code[20])
        {
            Caption = 'Lief. an Deb.-Nr.';
            Description = 'MFU';
            TableRelation = Customer;

            trigger OnValidate()
            var
                recShipToAddress: Record "222";
            begin
                //-GL020
                IF ("Document Type" = "Document Type"::Order) AND
                   (xRec."Ship-to Customer No." <> "Ship-to Customer No.")
                THEN BEGIN
                    SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
                    SalesLine.SETRANGE("Document No.", "No.");
                    SalesLine.SETFILTER("Purch. Order Line No.", '<>0');
                    IF NOT SalesLine.ISEMPTY THEN
                        ERROR(
                          'FEHLENDER TEXT %1',
                          FIELDCAPTION("Ship-to Customer No."));
                    SalesLine.RESET;
                END;

                "Ship-to Code" := '';


                IF ("Document Type" = "Document Type"::Order) THEN BEGIN

                    IF "Ship-to Customer No." <> '' THEN
                        IF xRec."Ship-to Customer No." <> '' THEN BEGIN
                            GetCust("Sell-to Customer No.");
                            IF Customer."Location Code" <> '' THEN
                                VALIDATE("Location Code", Customer."Location Code");
                            "Tax Area Code" := Customer."Tax Area Code";
                        END;
                    GetCust("Ship-to Customer No.");

                    //Hat der Kunde eine Lieferadresse? (die erste nehmen!)
                    CLEAR(recShipToAddress);
                    recShipToAddress.SETRANGE("Customer No.", "Ship-to Customer No.");
                    recShipToAddress.SETRANGE(Type, recShipToAddress.Type::Shipment);
                    IF recShipToAddress.FINDSET THEN BEGIN
                        //"Ship-to Code" := recShipToAddress.Code;
                        "Ship-to Name" := recShipToAddress.Name;
                        "Ship-to Name 2" := recShipToAddress."Name 2";
                        "Ship-to Address" := recShipToAddress.Address;
                        "Ship-to Address 2" := recShipToAddress."Address 2";
                        "Ship-to Address 3" := recShipToAddress."Address 3";    //GL044
                        "Ship-to City" := recShipToAddress.City;
                        "Ship-to Post Code" := recShipToAddress."Post Code";
                        "Ship-to County" := '';
                        VALIDATE("Ship-to Country/Region Code", recShipToAddress."Country/Region Code");
                        "Ship-to Contact" := recShipToAddress.Contact;
                        "Shipment Method Code" := recShipToAddress."Shipment Method Code";
                        IF recShipToAddress."Location Code" <> '' THEN
                            VALIDATE("Location Code", recShipToAddress."Location Code");
                        "Shipping Agent Code" := recShipToAddress."Shipping Agent Code";
                        "Shipping Agent Service Code" := recShipToAddress."Shipping Agent Service Code";
                        IF Customer."Tax Area Code" <> '' THEN
                            "Tax Area Code" := Customer."Tax Area Code";
                        "Tax Liable" := Customer."Tax Liable";
                    END ELSE BEGIN
                        "Ship-to Name" := Customer.Name;
                        "Ship-to Name 2" := Customer."Name 2";
                        "Ship-to Address" := Customer.Address;
                        "Ship-to Address 2" := Customer."Address 2";
                        "Ship-to Address 3" := Customer."Address 3";    //GL044
                        "Ship-to City" := Customer.City;
                        "Ship-to Post Code" := Customer."Post Code";
                        "Ship-to County" := Customer.County;
                        VALIDATE("Ship-to Country/Region Code", Customer."Country/Region Code");
                        "Ship-to Contact" := Customer.Contact;
                        "Shipment Method Code" := Customer."Shipment Method Code";
                        IF Customer."Location Code" <> '' THEN
                            VALIDATE("Location Code", Customer."Location Code");
                        "Shipping Agent Code" := Customer."Shipping Agent Code";
                        "Shipping Agent Service Code" := Customer."Shipping Agent Service Code";
                        IF Customer."Tax Area Code" <> '' THEN
                            "Tax Area Code" := Customer."Tax Area Code";
                        "Tax Liable" := Customer."Tax Liable";
                    END;
                END ELSE
                    IF "Sell-to Customer No." <> '' THEN BEGIN
                        GetCust("Sell-to Customer No.");
                        "Ship-to Name" := Customer.Name;
                        "Ship-to Name 2" := Customer."Name 2";
                        "Ship-to Address" := Customer.Address;
                        "Ship-to Address 2" := Customer."Address 2";
                        "Ship-to Address 3" := Customer."Address 3";  //GL044
                        "Ship-to City" := Customer.City;
                        "Ship-to Post Code" := Customer."Post Code";
                        "Ship-to County" := Customer.County;
                        VALIDATE("Ship-to Country/Region Code", Customer."Country/Region Code");
                        "Ship-to Contact" := Customer.Contact;
                        "Shipment Method Code" := Customer."Shipment Method Code";
                        "Tax Area Code" := Customer."Tax Area Code";
                        "Tax Liable" := Customer."Tax Liable";
                        IF Customer."Location Code" <> '' THEN
                            VALIDATE("Location Code", Customer."Location Code");
                        "Shipping Agent Code" := Customer."Shipping Agent Code";
                        "Shipping Agent Service Code" := Customer."Shipping Agent Service Code";
                    END;




                IF ((xRec."Sell-to Customer No." = "Sell-to Customer No.") AND (xRec."Ship-to Customer No." <> "Ship-to Customer No.")) AND
                  ((xRec."VAT Country/Region Code" <> "VAT Country/Region Code") OR (xRec."Tax Area Code" <> "Tax Area Code")) THEN BEGIN
                    RecreateSalesLines(FIELDCAPTION("Ship-to Customer No."))
                END ELSE BEGIN
                    IF xRec."Shipping Agent Code" <> "Shipping Agent Code" THEN
                        MessageIfSalesLinesExist(FIELDCAPTION("Shipping Agent Code"));
                    IF xRec."Shipping Agent Service Code" <> "Shipping Agent Service Code" THEN
                        MessageIfSalesLinesExist(FIELDCAPTION("Shipping Agent Service Code"));
                    IF xRec."Tax Liable" <> "Tax Liable" THEN
                        VALIDATE("Tax Liable");
                END;

            END;
            //+GL020

        }
        field(50016; Lieferdatum; Text[30])
        {

            trigger OnValidate()
            var
                dtHelp: Date;
            begin

                //-GL041
                IF EVALUATE(dtHelp, Lieferdatum) THEN
                    Rec.VALIDATE("Requested Delivery Date", dtHelp);
                //-GL041
            end;
        }
        field(50018; "VKBetragMenge+NR"; Boolean)
        {
        }
        field(50019; "Lieferungstext 1"; Text[50])
        {
            Description = 'MFU';
        }
        field(50020; "Lieferungstext 2"; Text[50])
        {
            Description = 'MFU';
        }

        field(50023; "Sell-to Address 3"; Text[50])
        {
            Caption = 'Verk. an Adresse 3';
        }
        field(50024; "Ship-to Address 3"; Text[50])
        {
            Caption = 'Lief. an Adresse 3';
        }
        field(50025; "Bill-to Address 3"; Text[50])
        {
            Caption = 'Rech. an Adresse 3';
        }
        field(50030; AblaufdatumDrucken; Boolean)
        {
        }
        field(50031; HerstelldatumDrucken; Boolean)
        {
        }
        field(50032; ZolltarifnrDrucken; Boolean)
        {
        }
        field(50033; BereitstellungsStatus; Option)
        {
            Description = 'BSN,GL046';
            OptionMembers = " ","An Stapler gesendet",Abgeschlossen;
        }
        field(50500; Wertgutschrift; Boolean)
        {
            Description = 'LAN1.00';
        }
        field(50501; "Bill-to Code"; Code[10])
        {
            Caption = 'Bill-to Code';
            Description = 'LAN1.00';
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Bill-to Customer No."),
                                                          Type = FILTER(<> Shipment));

            trigger OnValidate()
            begin
                //-LAN003
                /*
                IF "Bill-to Code" <> '' THEN BEGIN
                  //ShipToAddr.GET("Bill-to Customer No.","Bill-to Code");
                  "Bill-to Name" := ShipToAddr.Name;
                  "Bill-to Name 2" := ShipToAddr."Name 2";
                  "Bill-to Address" := ShipToAddr.Address;
                  "Bill-to Address 2" := ShipToAddr."Address 2";
                  "Bill-to Address 3" := ShipToAddr."Address 3";    //GL044
                  "Bill-to City" := ShipToAddr.City;
                  "Bill-to Post Code" := ShipToAddr."Post Code";
                  "Bill-to County" := ShipToAddr.County;
                  "Bill-to Country/Region Code" := ShipToAddr."Country/Region Code";
                  //-GL029
                  "Bill-to E-Mail" := ShipToAddr."E-Mail";
                    //-GL030
                    //Nicht nehmen der Mail Adresse vom Hauptkunden, wenn der Fakturierungskunde keine Mail Adresse hinterlegt hat
                    //IF STRLEN("Bill-to E-Mail")=0 THEN BEGIN
                    //  GetCust("Bill-to Customer No.");
                    //  "Bill-to E-Mail" := Cust."E-Mail";  //Alternativ die Mail Adresse vom Kundenstamm holen
                    //END;
                    //-GL030
                  //+GL029
                  //-GL021
                  //"Bill-to Contact" := ShipToAddr.Contact;
                  //+GL021
                END ELSE BEGIN
                  GetCust("Bill-to Customer No.");
                  "Bill-to Name" := Cust.Name;
                  "Bill-to Name 2" := Cust."Name 2";
                  "Bill-to Address" := Cust.Address;
                  "Bill-to Address 2" := Cust."Address 2";
                  "Bill-to Address 3" := Cust."Address 3";   //GL044
                  "Bill-to City" := Cust.City;
                  "Bill-to Post Code" := Cust."Post Code";
                  "Bill-to County" := Cust.County;
                  "Bill-to Country/Region Code" := Cust."Country/Region Code";
                  "Bill-to E-Mail" := Cust."E-Mail";     //GL029
                  //-GL021
                  //"Bill-to Contact" := Cust.Contact;
                  //+GL021
                END;
                //+LAN003
                */

            end;
        }
        field(50502; PDFRechnung; Boolean)
        {

        }
        field(50503; "Bill-to E-Mail"; Text[80])
        {
        }
        field(50504; StornoMitRechNr; Code[150])
        {

            trigger OnValidate()
            var
                recArtikelPosten: Record "32";
            begin
                //-GL031
                /*
                //Prüfen, ob die Rechnung Artikelbuchungen in den Posten hat, sonst die Belegnummer angeben!
                CLEAR(recArtikelPosten);
                recArtikelPosten.SETRANGE("Document No.",Rec.StornoMitRechNr);
                IF NOT recArtikelPosten.FINDSET THEN
                  ERROR('Beleg %1 beinhaltet keine Artikelbewegungen. Bitte zugehörigen Lieferschein oder Rechnung eingeben!',Rec.StornoMitRechNr);
                */
                //-GL031

            end;
        }
        field(50505; Einfuhrbewilligung; Option)
        {
            Description = 'MFU';
            OptionMembers = " ",Erforderlich,Erhalten;
        }
        field(50506; EinFuhrBewilligungsNr; Text[150])
        {
            Description = 'MFU';
        }
        field(50507; AusFuhrBewilligungsNr; Text[150])
        {
            Description = 'MFU';
        }
        field(50508; Export_Mengenimport; Boolean)
        {
            Description = 'MFU';
        }
        field(50509; Erstellungsdatum; Date)
        {
            Description = 'MFU';
        }
        field(50515; Verkaufsstatistikcode; Code[10])
        {
            Description = 'LAN1.00';

            trigger OnValidate()
            begin
                IF Verkaufsstatistikcode <> '' THEN
                    "100% Zeilenrabatt" := TRUE;
            end;
        }
        field(50601; Sammelrechnungstyp; Option)
        {
            Description = 'LAN1.00';
            OptionMembers = "Pro Auftrag","Pro Tag",ProWoche,"Pro Monat";
        }
        field(50602; Auftragsstatus; Option)
        {
            Description = 'LAN1.00';
            OptionMembers = " ",Freigegeben,"In Kommission",Teillieferung,Geliefert;

            trigger OnValidate()
            var
                recSalesLine: Record "37";
            begin
                //-LAN004
                IF Auftragsstatus = Auftragsstatus::"In Kommission" THEN
                    ERROR('FEHLENDE TEXTVARIABLE T36');

                //-GL034
                //ALT
                //IF xRec.Auftragsstatus = Auftragsstatus::"In Kommission" THEN
                //  IF NOT CONFIRM(Text50003,FALSE,Rec."No.") THEN     //UPDATE2013 Belegnummer dazugegeben
                //    Auftragsstatus := xRec.Auftragsstatus;
                IF xRec.Auftragsstatus = Auftragsstatus::"In Kommission" THEN
                    ERROR('Auftragsstatus von Kommissionierung nicht änderbar!');
                //+GL034

                //-GL012
                IF Auftragsstatus = Auftragsstatus::Freigegeben THEN
                    KostenstellenCheck;
                //+GL012

                IF (Auftragsstatus <> Auftragsstatus::" ") AND (Status = Status::Open) THEN
                    //Status::Freigegeben setzen
                    ReleaseSalesDoc.RUN(Rec);

                IF (Auftragsstatus = Auftragsstatus::" ") AND (Status = Status::Released) THEN
                    //Status::Offen setzen
                    ReleaseSalesDoc.Reopen(Rec);
                //+LAN004

                //-GL040
                //Gibt es noch offene Mengen in den Zeilen? -> Dann nicht auf Geliefert setzen lassen
                IF ("Document Type" = "Document Type"::Order) AND
                  (Auftragsstatus = Auftragsstatus::Geliefert) AND (xRec.Auftragsstatus <> xRec.Auftragsstatus::Geliefert) THEN BEGIN
                    recSalesLine.SETRANGE("Document No.", "No.");
                    IF recSalesLine.FINDFIRST THEN
                        REPEAT
                            IF recSalesLine."Outstanding Qty. (Base)" <> 0 THEN
                                ERROR('Der Auftrag kann nicht auf Geliefert gesetzt werden. Es sind noch offene Mengen vorhanden!');
                        UNTIL recSalesLine.NEXT = 0;
                END;
                //+GL040
            end;
        }
        field(51000; Etikettenanzahl; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'LAN1.00';
        }
        field(51001; "Outstanding Qty. (Base)"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Outstanding Qty. (Base)" WHERE("Document Type" = FIELD("Document Type"),
                                                                            "Document No." = FIELD("No."),
                                                                            Type = CONST(Item)));
            Caption = 'Outstanding Qty. (Base)';
            Description = 'LAN1.00';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52000; Musterlieferung; Boolean)
        {
            Description = 'LAN1.00';

            trigger OnValidate()
            begin
                //-LAN002
                SalesLine.RESET;
                SalesLine.SETRANGE("Document Type", "Document Type");
                SalesLine.SETRANGE("Document No.", "No.");
                SalesLine.SETFILTER("Quantity Shipped", '<>0');
                IF SalesLine.FINDFIRST THEN
                    ERROR('FEHLENDE TEXTVARIABLE T36', "No.");

                SalesLine.RESET;
                SalesLine.SETRANGE("Document Type", "Document Type");
                SalesLine.SETRANGE("Document No.", "No.");
                IF SalesLine.FINDFIRST THEN
                    MESSAGE('FEHLENDE TEXTVARIABLE T36', "No.");

                "Preis Null" := TRUE;
                //+LAN002
            end;
        }
    }
    procedure KostenstellenCheck()
    var
        verkzeile: Record "37";
        DefaultDimension: Record "352";
        recItem: Record "27";
    begin

        //-GL012
        verkzeile.SETRANGE("Document Type", "Document Type");
        verkzeile.SETRANGE("Document No.", "No.");
        verkzeile.SETRANGE(Type, verkzeile.Type::"G/L Account");
        //VerkZeile.SETFILTER(Menge,'>0');
        IF verkzeile.FIND('-') THEN
            REPEAT
                IF DefaultDimension.GET(15, verkzeile."Shortcut Dimension 1 Code", 'KOSTENSTELLE') THEN BEGIN
                    IF DefaultDimension."Value Posting" = DefaultDimension."Value Posting"::"Code Mandatory" THEN
                        IF verkzeile."Shortcut Dimension 1 Code" = '' THEN
                            ERROR('Kostenstelle muß angegeben werden in Sachkonto %1!', verkzeile."No.");
                    IF DefaultDimension."Value Posting" = DefaultDimension."Value Posting"::"Same Code" THEN
                        IF verkzeile."Shortcut Dimension 1 Code" <> DefaultDimension."Dimension Value Code" THEN
                            ERROR('Kostenstelle muß %1 sein in Sachkonto %2!', DefaultDimension."Dimension Value Code",
                                   verkzeile."No.");
                    IF DefaultDimension."Value Posting" = DefaultDimension."Value Posting"::"No Code" THEN
                        IF verkzeile."Shortcut Dimension 1 Code" <> '' THEN
                            ERROR('Kostenstelle darf nicht angegeben werden in Sachkonto %1!', verkzeile."No.");
                END;
            UNTIL verkzeile.NEXT = 0;
        //+GL012


        //Diese Prüfung bei Update auf 2013 nicht mehr Einbauen
        /*
        //MFU 03.08.2010  -> Zum testen der fehlenden Dimensionwertcodes im hintergrund bei den Verkaufszeilen
        // -> wieder entfernen wenn nicht mehr benötigt (macht vermutlich etwas langsam)
        verkzeile.SETRANGE("Document Type","Document Type");
        verkzeile.SETRANGE("Document No.","No.");
        verkzeile.SETRANGE(Type,verkzeile.Type::Item);
        IF verkzeile.FIND('-') THEN
          REPEAT
            IF recItem.GET(verkzeile."No.") THEN BEGIN
              IF recItem.Artikelart = recItem.Artikelart::Fertigprodukt THEN BEGIN
                IF STRLEN(verkzeile."Shortcut Dimension 1 Code")>0 THEN BEGIN
        
                  CLEAR(DocumentDimension);
                  DocumentDimension.SETRANGE("Table ID",37);
                  DocumentDimension.SETRANGE("Document Type","Document Type");
                  DocumentDimension.SETRANGE("Document No.","No.");
                  DocumentDimension.SETRANGE("Line No.",verkzeile."Line No.");
                  IF DocumentDimension.FINDFIRST THEN BEGIN
                    IF NOT (verkzeile."Shortcut Dimension 1 Code"=DocumentDimension."Dimension Value Code") THEN
                      MESSAGE('Unterschiedliche Kostenstelle bei Artikel %1!',verkzeile."No.");
                  END ELSE BEGIN
                    MESSAGE('Keine Kostenstelle bei Artikel %1 vorhanden!',verkzeile."No.");
                  END;
        
                END;
              END;
            END;
          UNTIL verkzeile.NEXT=0
        */

    end;


    var
        Cust: Record Customer;
        ReleaseSalesDoc: Codeunit "Release Sales Document";
}
