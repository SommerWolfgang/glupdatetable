tableextension 50013 T37SalesLine extends "Sales Line"
{

    // LAN001 12.11.09 ACPSS LAN1.00
    //   New Fields: ID 50000, 50003, 50005 - 50008, 50010, 50506 - 50519, 50600, 50601
    // LAN002 18.12.09 ACPSS LAN1.00
    //   Naturalrabatt, Preisfindung
    // LAN003 18.12.09 ACPSS LAN1.00
    //   Statistik
    // LAN004 18.12.09 ACPSS LAN1.00
    //   Vorschlag Lagerort
    // LAN005 18.12.09 ACPSS LAN1.00
    //   Auftragsdatum aus Kopf übernehmen
    // LAN006 18.12.09 ACPSS LAN1.00
    //   Charge
    // LAN007 18.12.09 ACPSS LAN1.00
    //   Endlosschleife Preisfindung mit Naturalrabatt verhindern
    // LAN008 18.12.09 ACPSS LAN1.00
    //   Alternative anzeigen.
    // LAN009 21.12.09 ACPSS LAN1.00
    //   Bemerkungen zu Rabatten anzeigen
    // LAN010 21.12.09 ACPSS LAN1.00
    //   Wertgutschrift
    // 
    // 
    // GL001 Flowfield Schrumpfgröße
    // GL011 SuchtgiftBerechtigungsprüfung
    // GL013 Wertgutschrift-Zuweisung:  CheckItemChargeShipment(), CheckItemChargeInvoice()
    // GL016 TeststatusOpen bei OnmodifyTrigger eingebaut
    // 
    // 014 Lagerverfügbarkeit bei Teilmenge u. Naturalrabattmenge prüfen. Muss vor Chargenanlage passieren, sonst
    //     Funktionsaufrufsfehler (SS, 25.6.04+2.9.2004)
    // 
    // nicht mehr eingebaut: Gerot: 015 Wenn VK-Statcode: wird bei Menge-validate der Preis wieder null gesetzt
    // 
    // GL017 Korr: Zu/Abschläge berücksichtigten nach Zuweisung geänderten Zeilenrabatt nicht
    //       Korr zu Zu/Abschlägen bei nachträglicher Zeilenrabattänderung sowie Eingabemöglichkeit per Hand oder Copy/Paste
    // Wertgutschrift-Artikelnummer: Kostenstelle aus Kopf belassen, nur wenn leer aus Artikel nehmen
    // Einbau Zuordnung zu Rechnung, Wertgutschriftszuweisung per Klick
    // Korr zu Rechung/Wertgutschriftszuweisung, Fehler wenn Rabatt verwendet wurde
    // Feld Verkaufsstatistikcode: lookup auch für sachkonto+zu/abschlag ermöglicht
    // checkItemAvailable-testen
    // 
    // GL018 MFU 11.02.2010 -> Initialisieren des Record, da sonst leer und kein finden eines Standard Lagerorts
    // GL019 MFU 25.02.2010 -> Key eingefügt für R50051
    //               (Document Type,Type,No.,Variant Code,Drop Shipment,Location Code,Bin Code,Shipment Date)
    // 
    // Datum      | Autor   | Status     | Beschreibung
    // --------------------------------------------------------------------------------------------------------
    // 2010-02-11 | Petsch  | ok         | Update von 3.60
    // --------------------------------------------------------------------------------------------------------
    // 2010-04-09 | Petsch  | ok         | Wertgutschriften() umprogrammiert
    // --------------------------------------------------------------------------------------------------------
    // 2010-04-12 | Petsch  | ok         | Pkt 007 abgeändert, weil Fehler bei Sammelrechungen ->
    //                                     jetzt wird in der T111 von InsertInvLineFromShptLine() ein "Preis gefunden" gesetzt
    // --------------------------------------------------------------------------------------------------------
    // 2010-04-28 | MFU     | ok         | GL020 Zugehörigkeitsdatum für Wertgutschriften Abgrenzung in Zeilen eingebaut
    // --------------------------------------------------------------------------------------------------------
    // 2010-09-08 | MFU     | ok         | GL021 Debuginfo zum finden fehlender Kostenstellen eingebaut
    // --------------------------------------------------------------------------------------------------------
    // 2011-10-13 | MFU     | ok         | GL022 Als Eingabetyp die Pharmazentralnummer dazugegeben -> Wunsch Schmer
    // --------------------------------------------------------------------------------------------------------
    // 2012-05-30 | MFU     | ok         | GL023 Bei Firmenkopf "Polen", die MWST-Produktbuchungsgruppe nicht vom Artikel -> Wunsch Schmer
    // --------------------------------------------------------------------------------------------------------
    // 2012-12-14 | MFU     | ok         | GL024 Zugehörigkeitsdatum bei Wertrechnungen
    // --------------------------------------------------------------------------------------------------------
    // 2013-04-03 | MFU     | ok         | GL025 Mengenverfügbarkeit unterschiedlich (Export/Inland) durchführen
    // --------------------------------------------------------------------------------------------------------
    // 2013-06-25 | MFU     | ok         | GL026 Bemerkungsmeldung anzeigen, wenn beim Artikel hinterlegt
    //                                           (Kommt auch bei Beleg kopieren)
    // --------------------------------------------------------------------------------------------------------
    // 2013-11-13 | MFU     | ok         | GL027 Preise von Rahmenauftrag holen und prüfen auf noch genügend offene Menge
    // --------------------------------------------------------------------------------------------------------
    // 2014-03-13 | MFU     | ok         | GL028 Beim prüfen auf noch genügend offene Menge, keine MESSAGE sondern ERROR ausgeben -> Graf
    // --------------------------------------------------------------------------------------------------------
    // 2014-03-26 | MFU     | ok         | GL029 Gelieferte Rahmenaufträge nicht nicht Berücksichtigen
    // --------------------------------------------------------------------------------------------------------
    // 2014-04-07 | MFU     | ok         | GL030 Gewünschtes Lieferdatum nicht abweichend zum Kopf eingeben lassen -> Wegen Sharepoint Ausw
    // --------------------------------------------------------------------------------------------------------
    // 2015-03-16 | MFU     | ok         | GL031 "Einfuhrbewilligung" in Kopf bei Suchtgiftzeile und Export Auftrag befüllen
    // --------------------------------------------------------------------------------------------------------
    // 2015-07-01 | MFU     | ok         | GL032 Bei Mengen(Teilmenge) änderung in Rechnung wurde Lagerplatz immer zurückgesetzt
    // --------------------------------------------------------------------------------------------------------
    // 2015-07-16 | MFU     | ok         | GL033 NR-Menge für Zeilensumme Berechnung mitnehmen, bei gesetzer Art im Auftrag (Wunsch Nebel)
    //                                           -> Änderung noch nicht aktiviert!!!!!!!!!
    // --------------------------------------------------------------------------------------------------------
    // 2015-07-23 | MFU     | ok         | GL034 Zugehörigkeitsdatum in Auftragszeilen auch setzen
    // --------------------------------------------------------------------------------------------------------
    // 2015-08-18 | Petsch  | ok         | GL035 Flowfield Packungsgröße in Funktion Packungsgröße umgebaut
    // --------------------------------------------------------------------------------------------------------
    // 2015-08-18 | MFU     | ok         | GL036 Chargennr Lookup verbessert
    // --------------------------------------------------------------------------------------------------------
    // 2015-09-15 | MFU     | ok         | Spalte "Pharmazentralnr" in Inlandfilter umbenannt (Wird in Auftragszeile benutzt)
    //                                     Table Relation zu Spalte "No." angepasst das nur Inlandartikel in Schnellübersicht kommen
    //                                                   IF (Type=CONST(Item),Inlandfilter=CONST(Yes)) Item WHERE (Country/Region Code=FILTER(<=A))
    // --------------------------------------------------------------------------------------------------------
    // 2015-09-16 | MFU     | ok         | GL037 Fehler bei Zeilensummenberechnung bei Rahmenaufträgen
    // --------------------------------------------------------------------------------------------------------
    // 2016-01-18 | MFU     | ok         | GL038 Fehler bei Mengenveränderung, wenn nicht auf Lager
    // --------------------------------------------------------------------------------------------------------
    // 2017-01-17 | MFU     | ok         | GL039 Zugehörigkeitsdatum setzen anpassen (Gutschrifttyp "Wertgutschrift" nicht mehr vorhanden)
    // --------------------------------------------------------------------------------------------------------
    // 2017-04-07 | MFU     | ok         | GL040 - Für GL-DE prüfen, ob genug Menge am VKL Lager ist (Koch)
    // --------------------------------------------------------------------------------------------------------
    // 2017-05-31 | DKO     | ok         | GL041 - Naturalrabattmenge in Qty. to Assemble to Order - onValidate ausgenommen von GetDefaultBin
    // --------------------------------------------------------------------------------------------------------
    // 2017-09-07 | MFU     | ok         | GL042 - Einfuhrbewilligung auch bei Gutschriften (nicht nur Aufträgen) setzen
    // --------------------------------------------------------------------------------------------------------
    // 2017-12-07 | DKO     | ok         | GL043 - Chargennr. verändern wenn Menge geliefert > 0 unterbinden
    // --------------------------------------------------------------------------------------------------------
    // 2018-02-13 | MFU     | ok         | GL044 - Artikel Bemerkungsmeldung aus "No." Validate entfernt iund in Page gegeben
    // --------------------------------------------------------------------------------------------------------
    // 2018-02-13 | MFU     | ok         | GL045 - Gewünschtes Lieferdatum Ändern zulassen, wenn Erwartetes Lieferdatum gesetzt ist
    // --------------------------------------------------------------------------------------------------------
    // 2018-08-17 | MFU     | ok         | GL046 - Zeilenpreise bei Buchungsdatum Änderung neu aktualisieren (Währungskurse wurden nicht upgedaten)
    // --------------------------------------------------------------------------------------------------------
    // 2019-09-16 | MFU     | ok         | GL047 - Wenn es einen Ersatzartikel gibt, nicht auf gesperrt prüfen
    // --------------------------------------------------------------------------------------------------------
    // 2020-08-13 | TBO     | ok         | GL048 - Ursprünglicher gewünscher Liefertermin setzen, wenn Sales Line angelegt wurde und gewünschtes Lieferdatum im Sales Header schon existiert
    // --------------------------------------------------------------------------------------------------------
    // 2020-08-26 | MFU     | ok         | GL049 - Lieferzeilen von Rahmenauftrag in VK-Rechnung holen hat Fehler gegeben
    // --------------------------------------------------------------------------------------------------------
    // 
    // 
    // 
    // Checks: alle "Teilmenge" Einbauten gleich 27.6.2014
    fields
    {
        field(50000; Teilmenge; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'LAN1.00';

            trigger OnValidate()
            begin
                //-LAN002
                VALIDATE(Quantity, Teilmenge + Naturalrabattmenge);
                VALIDATE("Abzug %");
                //+LAN002
            end;
        }
        field(50002; Nachlieferungstext; Text[30])
        {
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

            trigger OnValidate()
            var
                Currency: Record Currency;
            begin
                //-LAN002
                IF Quantity <> 0 THEN
                    "Abzug %" := (Quantity - Teilmenge) * 100 / Quantity
                ELSE
                    "Abzug %" := 100;

                //-GL037  Einbau aus 2009
                Abzugsbetrag := 0;
                IF ("Document Type" <> "Document Type"::"Blanket Order") AND ("Document Type" <> "Document Type"::Quote) THEN //MFU 15.09.2021
                                                                                                                              //+GL037
                    Abzugsbetrag :=
                    ROUND(
                      ROUND(Quantity * "Unit Price", Currency."Amount Rounding Precision") *
                      "Abzug %" / 100, Currency."Amount Rounding Precision");

                //-GL033
                if GetHeaderMengeZuNrBerechnung(Rec."Document No.") then
                    Abzugsbetrag := 0;
                //+GL033

                UpdateAmounts;

                VALIDATE("Line Discount %");
                //+LAN002
            end;
        }
        field(50006; Abzugsbetrag; Decimal)
        {
            Description = 'LAN1.00';
        }
        field(50007; "Preis gefunden"; Boolean)
        {
            Description = 'LAN1.00 Hilfsfeld f. Preisfindung, temporär befüllt';
        }
        field(50008; "Lagerbestand prüfen"; Boolean)
        {
            Description = 'LAN1.00 Hilfsfeld f. Preisfindung, temporär befüllt';
        }
        field(50010; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            Description = 'LAN1.00';
            TableRelation = IF (Type = CONST(Item)) "Lot No. Information"."Lot No." WHERE("Item No." = FIELD("No."),
                                                                                         "Variant Code" = FIELD("Variant Code"));
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //-LAN006
                //MFU12.04.2024   HoleCharge;
                //+LAN006
            end;

            trigger OnValidate()
            var
                Chargenstamm: Record "Lot No. Information";
            begin
                //MFU12.04.2024
                /*
                //-LAN006
                TESTFIELD(Type, Type::Item);

                IF ("Lot No." <> xRec."Lot No.") THEN BEGIN
                    "Verkaufschargennr." := '';
                    "Expiration Date" := 0D;
                    LöscheCharge;
                    IF "Lot No." <> '' THEN BEGIN
                        IF NOT Chargenstamm.GET("No.", "Variant Code", "Lot No.") THEN BEGIN
                            IF "Document Type" IN [0, 1, 2, 4] THEN   //Angebot, Auftrag, Rechnung, Rahmenauftrag
                                ERROR('FEHLENDE TEXTVARIABLE T37')
                            ELSE
                                MESSAGE('FEHLENDE TEXTVARIABLE T37');
                            "Verkaufschargennr." := "Lot No.";
                            "Expiration Date" := 0D;
                        END ELSE BEGIN
                            "Lot No." := Chargenstamm."Lot No.";
                            "Verkaufschargennr." := Chargenstamm."Verkaufschargennr.";
                            "Expiration Date" := Chargenstamm."Expiration Date";
                        END;
                        EingabeCharge;
                    END;

                    //-GL040
                    IF COMPANYNAME = 'GL-DE' THEN
                        CheckArtikelVerfügbarkeitVKL("No.", "Lot No.", Quantity, "Document No.");
                    //+GL040

                END;
                //+LAN006
                */
            end;
        }
        field(50011; "Zuordnung zu Lieferung"; Code[20])
        {
            Description = 'Petsch';

            trigger OnLookup()
            var
                SalesShipmentLines: Record "111";
            begin

                IF ("Zuordnung zu Artikelnr." <> '') AND (Type = Type::"Charge (Item)") THEN BEGIN
                    SalesShipmentLines.SETCURRENTKEY("Sell-to Customer No.");
                    SalesShipmentLines.SETRANGE(Type, SalesShipmentLines.Type::Item);
                    SalesShipmentLines.SETRANGE("No.", "Zuordnung zu Artikelnr.");
                    SalesShipmentLines.SETRANGE("Sell-to Customer No.", "Sell-to Customer No.");
                    //TODOPBA IF PAGE.RUNMODAL(PAGE::Page50059, SalesShipmentLines) = ACTION::LookupOK THEN BEGIN
                    //    VALIDATE("Zuordnung zu Lieferung", SalesShipmentLines."Document No.");
                    //END;
                END;
            end;

            trigger OnValidate()
            var
                SalesShipmentLines: Record "111";
            begin
                IF Type <> Type::"Charge (Item)" THEN
                    ERROR('Zuordnung zu Lieferung ist nur bei Art = Zu/Abschlag möglich');
                IF "Zuordnung zu Artikelnr." = '' THEN
                    ERROR('Bitte zuerst Zuweisung zu Artikel setzen');
                IF "Zuordnung zu Rechnung" <> '' THEN
                    ERROR('Zuordnung zu Rechnung darf nicht gleichzeitig ausgefüllt sein!');


                SalesShipmentLines.SETCURRENTKEY("Sell-to Customer No.");
                SalesShipmentLines.SETRANGE(Type, SalesShipmentLines.Type::Item);
                SalesShipmentLines.SETRANGE("No.", "Zuordnung zu Artikelnr.");
                SalesShipmentLines.SETRANGE("Sell-to Customer No.", "Sell-to Customer No.");
                SalesShipmentLines.SETRANGE("Document No.", "Zuordnung zu Lieferung");
                IF SalesShipmentLines.FIND('-') THEN
                    CheckItemChargeShipment(FIELDNO("Zuordnung zu Lieferung"), SalesShipmentLines)
                ELSE
                    IF "Zuordnung zu Lieferung" <> '' THEN
                        ERROR('Unzulässige Liefernummer');

                IF ("Zuordnung zu Lieferung" = '') AND (xRec."Zuordnung zu Lieferung" <> '') THEN BEGIN
                    DeleteChargeChargeAssgnt("Document Type", "Document No.", "Line No.");
                END;
            end;
        }
        field(50012; "Zuordnung zu Rechnung"; Code[20])
        {
            Description = 'Petsch';

            trigger OnLookup()
            var
                SalesInvoiceLines: Record "113";
            begin

                IF ("Zuordnung zu Artikelnr." <> '') AND (Type = Type::"Charge (Item)") THEN BEGIN
                    SalesInvoiceLines.SETCURRENTKEY("Sell-to Customer No.");
                    SalesInvoiceLines.SETRANGE(Type, SalesInvoiceLines.Type::Item);
                    SalesInvoiceLines.SETRANGE("No.", "Zuordnung zu Artikelnr.");
                    SalesInvoiceLines.SETRANGE("Sell-to Customer No.", "Sell-to Customer No.");
                    //TODOPBA IF PAGE.RUNMODAL(PAGE::Page50072, SalesInvoiceLines) = ACTION::LookupOK THEN BEGIN
                    //    VALIDATE("Zuordnung zu Rechnung", SalesInvoiceLines."Document No.");
                    //END;
                END;
            end;

            trigger OnValidate()
            var
                SalesInvoiceLines: Record "113";
            begin
                IF Type <> Type::"Charge (Item)" THEN
                    ERROR('Zuordnung zu Rechnung ist nur bei Art = Zu/Abschlag möglich');
                IF "Zuordnung zu Artikelnr." = '' THEN
                    ERROR('Bitte zuerst Zuweisung zu Artikel setzen');
                IF "Zuordnung zu Lieferung" <> '' THEN
                    ERROR('Zuordnung zu Lieferung darf nicht gleichzeitig ausgefüllt sein!');

                SalesInvoiceLines.SETCURRENTKEY("Sell-to Customer No.");
                SalesInvoiceLines.SETRANGE(Type, SalesInvoiceLines.Type::Item);
                SalesInvoiceLines.SETRANGE("No.", "Zuordnung zu Artikelnr.");
                SalesInvoiceLines.SETRANGE("Sell-to Customer No.", "Sell-to Customer No.");
                SalesInvoiceLines.SETRANGE("Document No.", "Zuordnung zu Rechnung");
                IF SalesInvoiceLines.FIND('-') THEN
                    CheckItemChargeInvoice(FIELDNO("Zuordnung zu Rechnung"), SalesInvoiceLines)
                ELSE
                    IF "Zuordnung zu Rechnung" <> '' THEN
                        ERROR('Unzulässige Rechnungsnummer');

                IF ("Zuordnung zu Rechnung" = '') AND (xRec."Zuordnung zu Rechnung" <> '') THEN BEGIN
                    DeleteChargeChargeAssgnt("Document Type", "Document No.", "Line No.");
                END;
            end;
        }
        field(50013; "Schrumpfgröße"; Decimal)
        {
            CalcFormula = Lookup(Item."Schrumpfgröße" WHERE("No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50014; "Zugehörigkeitsdatum"; Date)
        {
            Description = 'MFU für Wertgutschriften';
        }
        field(50015; Inlandfilter; Boolean)
        {
        }
        field(50016; "Hole Von"; Integer)
        {

            trigger OnLookup()
            var
                tempRecItemLedgerEntry: Record "32" temporary;
                recItem: Record "27";
                ActionReturn: Action;
            begin

                //-UPDATE2013
                IF Type = Type::Item THEN
                    IF recItem.GET("No.") THEN BEGIN
                        //TESTFIELD("Item No.");
                        tempRecItemLedgerEntry."Item No." := "No.";
                        tempRecItemLedgerEntry.SETRANGE("Item No.", "No.");
                        tempRecItemLedgerEntry.SETRANGE(Open, TRUE);
                        IF "Location Code" <> '' THEN BEGIN
                            tempRecItemLedgerEntry."Location Code" := "Location Code";
                            tempRecItemLedgerEntry.SETRANGE("Location Code", "Location Code");
                        END;

                        //TODOPBA ActionReturn := PAGE.RUNMODAL(PAGE::Page50169, tempRecItemLedgerEntry);
                        IF (ActionReturn = ACTION::LookupOK) OR (ActionReturn = ACTION::OK) THEN BEGIN

                            VALIDATE("Lot No.", tempRecItemLedgerEntry."Lot No.");
                            "Verkaufschargennr." := tempRecItemLedgerEntry."Verkaufschargennr.";
                            //IF "Entry Type" = "Entry Type"::Transfer THEN
                            VALIDATE(Teilmenge, tempRecItemLedgerEntry."Remaining Quantity");

                            "Location Code" := tempRecItemLedgerEntry."Location Code";
                            "Bin Code" := tempRecItemLedgerEntry.Lagerplatzhilfsfeld;

                        END;
                    END;

                //+UPDATE2013
            end;
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
            TableRelation = IF (Inlandfilter = CONST(false)) Item
            ELSE
            IF (Inlandfilter = CONST(true)) Item WHERE("Country/Region Code" = FILTER('<=A'));
        }
        field(50511; "Wertkorrektur zu Artikelposten"; Integer)
        {
            Description = 'LAN1.00';

            trigger OnLookup()
            var
                ItemChargeAssgntSales: Record "5809";
                ShipmentLines: Page "5824";
            begin
            end;

            trigger OnValidate()
            begin
                IF Type <> Type::"Charge (Item)" THEN
                    ERROR('Postenzuordnung nur bei Art=Zu/Abschlag erlaubt');
                //schreibe zu/abschlag
            end;
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

            trigger OnValidate()
            begin
                //-LAN002
                VALIDATE(Teilmenge);
                TESTFIELD("Qty. per Unit of Measure");

                IF (Type <> Type::Item) AND (Naturalrabattmenge <> 0) THEN
                    ERROR('FEHLENDE TEXTVARIABLE T37');

                IF "Naturalrabattmenge geliefert" > 0 THEN
                    ERROR('FEHLENDE TEXTVARIABLE T37');
                //+LAN002
            end;
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

            trigger OnValidate()
            begin
                //-LAN006
                IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
                    IF ("Expiration Date" <> xRec."Expiration Date") THEN BEGIN
                        LöscheCharge;
                        EingabeCharge;
                    END;
                END;
                //+LAN006
            end;
        }
        field(50517; "Suchtgift/Psychotrop"; Text[1])
        {
            Description = 'LAN1.00';
        }
        field(50518; "Naturalrabatt fakturiert"; Decimal)
        {
            Description = 'xx';
        }
        field(50519; "Verkaufschargennr."; Code[20])
        {
            Description = 'LAN1.00';

            trigger OnLookup()
            begin
                //-LAN006
                HoleCharge;
                LöscheCharge;
                EingabeCharge;
                //+LAN006
            end;

            trigger OnValidate()
            var
                recLotNoInformation: Record "6505";
                recItem: Record "27";
            begin
                //-LAN006
                IF "Document Type" <> "Document Type"::"Credit Memo" THEN BEGIN
                    Chargenprüfung;
                END ELSE BEGIN
                    TESTFIELD(Type, Type::Item);
                    recItem.GET("No.");
                    recItem.TESTFIELD("Item Tracking Code");
                    IF ("Verkaufschargennr." <> xRec."Verkaufschargennr.") THEN BEGIN
                        IF "Verkaufschargennr." <> '' THEN BEGIN
                            recLotNoInformation.SETCURRENTKEY("Item No.", "Variant Code", "Verkaufschargennr.");
                            recLotNoInformation.SETRANGE("Item No.", "No.");
                            recLotNoInformation.SETRANGE("Variant Code", "Variant Code");
                            recLotNoInformation.SETRANGE("Verkaufschargennr.", "Verkaufschargennr.");
                            IF recLotNoInformation.FIND('-') THEN BEGIN
                                "Lot No." := recLotNoInformation."Lot No.";
                                "Verkaufschargennr." := recLotNoInformation."Verkaufschargennr.";
                                "Expiration Date" := recLotNoInformation."Expiration Date";
                                LöscheCharge;
                                EingabeCharge;
                            END ELSE BEGIN
                                MESSAGE('FEHLENDE TEXTVARIABLE T37');
                                LöscheCharge;
                                EingabeCharge;
                            END;
                        END;
                        VALIDATE("Lot No.");
                    END;
                END;
                //+LAN006
            end;
        }
        field(50522; EDIArtikelBemerkung; Text[100])
        {
        }
        field(50600; Hervorheben; Boolean)
        {
            Description = 'LAN1.00';
        }
        field(50601; "Order Date"; Date)
        {
            Caption = 'Order Date';
            Description = 'LAN1.00';

            trigger OnValidate()
            begin

                //-GL046
                IF (Type = Type::Item) OR (Type = Type::"G/L Account") THEN
                    IF ("Unit Price" > 0) AND ("Currency Code" <> '') THEN
                        UpdateUnitPrice(FIELDNO(Teilmenge));
                //+GL046
            end;
        }
        field(50602; OriginalRequestedDeliveryDate; Date)
        {
            Caption = 'Original Requested Delivery Date';
        }
    }
    procedure EingabeCharge()

    begin
        //Chargeneingabe in VK-Zeile nicht mehr machen!  MFU 12.04.2024
        /*
        //-LAN006
        IF SuspendLotCreation THEN
            EXIT;
        IF "Line No." = 0 THEN
            EXIT;
        IF "Lot No." = '' THEN
            EXIT;
        IF Type <> Type::Item THEN
            EXIT;
        IF "No." = '' THEN
            EXIT;
        TESTFIELD("Quantity Shipped", 0);

        cuChargenverwaltung.EingabeCharge(
          DATABASE::"Sales Line", "Document Type", "Document No.", '', 0, "Line No.",
          "Qty. per Unit of Measure", "Quantity (Base)", "Qty. to Invoice (Base)", "Lot No.",
          "Verkaufschargennr.", '', '', "Expiration Date", "No.", "Variant Code", "Location Code", "Shipment Date");
        //+LAN006
        */
    end;

    procedure "LöscheCharge"()
    begin
        //Chargeneingabe in VK-Zeile nicht mehr machen!  MFU 12.04.2024
        /*
        //-LAN006
        IF SuspendLotCreation THEN
            EXIT;
        IF "Line No." = 0 THEN
            EXIT;
        IF Type <> Type::Item THEN
            EXIT;

        cuChargenverwaltung.LöscheCharge(
          DATABASE::"Sales Line", "Document Type", "Document No.", '', 0, "Line No.", "Lot No.");
        //+LAN006
        */
    end;

    procedure FaktMengeCharge()
    var
        CurrentSignFactor: Integer;
    begin
        //-LAN006
        IF SuspendLotCreation THEN
            EXIT;
        IF "Line No." = 0 THEN
            EXIT;
        IF "Lot No." = '' THEN
            EXIT;
        IF Type <> Type::Item THEN
            EXIT;
        IF "No." = '' THEN
            EXIT;

        LotMgt.FaktMengeCharge(
          DATABASE::"Sales Line", "Document Type", "Document No.", '', 0, "Line No.", "Lot No.", "Qty. to Invoice (Base)");
        //+LAN006
    end;

    procedure HoleCharge()
    var
        ActionReturn: Action;
    begin
        /*
        //-UPDATE2013
        Item.GET("No.");
        Item.TESTFIELD("Item Tracking Code");
        //Chargenstamm."Item No." := "No.";
        //Chargenstamm."Variant Code" := "Variant Code";
        //Chargenstamm."Lot No." := "Lot No.";
        
        CLEAR(Chargenstamm);   //GL036
        
        Chargenstamm.SETRANGE("Item No.","No.");
        //Gutschriften: Zugriff auch auf Chargen mit Lagerstand null
        IF "Document Type" <> "Document Type"::"Credit Memo" THEN BEGIN
          IF "Location Code" <> '' THEN
            Chargenstamm.SETFILTER("Location Filter","Location Code");
          IF "Bin Code" <> '' THEN
            Chargenstamm.SETFILTER("Bin Filter","Bin Code");
          Chargenstamm.SETFILTER(Inventory,'<>0');
          Chargenstamm.SETRANGE(Open,TRUE);
        
        //-GL036
          IF STRLEN("Lot No.")>0 THEN
            Chargenstamm.SETRANGE("Lot No.","Lot No.");
          Chargenstamm."Item No." := "No.";
        //+GL036
        END;
        
        //CLEAR(pChargenUebersicht);
        //pChargenUebersicht.SETTABLEVIEW(Chargenstamm);
        //pChargenUebersicht.SETRECORD(Chargenstamm);
        ActionReturn := PAGE.RUNMODAL(PAGE::Page50512,Chargenstamm);
        IF (ActionReturn = ACTION::LookupOK) OR (ActionReturn = ACTION::OK) THEN BEGIN  //Bei OK wird erste Zeile geliefert
          "Lot No." := Chargenstamm."Lot No.";
          "Verkaufschargennr." := Chargenstamm."Verkaufschargennr.";
          "Expiration Date" := Chargenstamm."Expiration Date";
          IF Item.Artikelart = Item.Artikelart::Fertigprodukt THEN
            TESTFIELD("Verkaufschargennr.");
          VALIDATE("Lot No.");
        END;
        //+UPDATE2013
        
        
        
        {!!!!!!!!!!!!!!1
        //-LAN006
        Item.GET("No.");
        Item.TESTFIELD("Item Tracking Code");
        Chargenstamm."Item No." := "No.";
        Chargenstamm."Variant Code" := "Variant Code";
        Chargenstamm."Lot No." := "Lot No.";
        IF "Document Type" <> "Document Type"::"Credit Memo" THEN BEGIN
          Chargenstamm."Location Filter" := "Location Code";
          Chargenstamm."Bin Filter" := "Bin Code";
          Chargenstamm.SETFILTER(Inventory, '<>0');
          IF LotMgt.Chargenpostenwählen(Chargenstamm) THEN BEGIN
            "Lot No." := Chargenstamm."Lot No.";
            "Verkaufschargennr." := Chargenstamm."Verkaufschargennr.";
            "Expiration Date" := Chargenstamm."Expiration Date";
            IF Item.Artikelart = Item.Artikelart::Fertigprodukt THEN
              TESTFIELD("Verkaufschargennr.");
            VALIDATE("Lot No.");
          END;
        END ELSE BEGIN  //Gutschriften: Zugriff auch auf Chargen mit Lagerstand null
          recCharge.SETRANGE("Item No.",Chargenstamm."Item No.");
          recCharge."Item No." := Chargenstamm."Item No.";
          recCharge."Lot No." := Chargenstamm."Lot No.";
          recCharge."Variant Code" := Chargenstamm."Variant Code";
          IF PAGE.RUNMODAL(PAGE::"Chargenstamm Übersicht",recCharge)=ACTION::LookupOK THEN BEGIN
            "Lot No." := recCharge."Lot No.";
            "Verkaufschargennr." := recCharge."Verkaufschargennr.";
            "Expiration Date" := recCharge."Expiration Date";
            IF Item.Artikelart = Item.Artikelart::Fertigprodukt THEN
              TESTFIELD("Verkaufschargennr.");
            VALIDATE("Lot No.");
          END;
        END;
        //+LAN006
        }
        */

    end;

    procedure "Chargenprüfung"()
    begin
    end;

    procedure Bezugsberechtigung(Artikelnr: Code[20]; Kundennr: Code[20])
    var
        recCustomer: Record "18";
        recItem: Record "27";
    begin
        //-GL011
        IF recCustomer.GET(Kundennr) THEN
            IF recItem.GET(Artikelnr) THEN BEGIN
                IF (recItem.Suchtgift) AND (recCustomer."SG-Bezug" = FALSE) THEN
                    ERROR('Kunde %1 hat keine Suchtgiftbezugsberechtigung', recCustomer."No.");
                IF (recItem."Psychotroper Stoff") AND (recCustomer."PSY-Bezug" = FALSE) THEN
                    ERROR('Kunde %1 hat keine Bezugsberechtigung für psychotrope Stoffe', recCustomer."No.");
            END;
        //+GL011
    end;

    procedure Wertgutschrift()
    var
        TmpVKPreis: Decimal;
        TmpArtikelZuordnung: Code[20];
        TmpSachkonto: Code[20];
        TmpType: Integer;
        localRecSalesLine: Record "37";
        localRecItem: Record "27";
    begin
        //-LAN010
        /*
        IF NOT (Type IN [Type::"G/L Account",Type::"Charge (Item)"]) THEN
          FIELDERROR(Type);
        IF "No." = '' THEN
          FIELDERROR("No.");
        
        localRecSalesLine.COPY(Rec);
        localRecSalesLine.Type := localRecSalesLine.Type::Item;
        localRecSalesLine.VALIDATE("No.", "Zuordnung zu Artikelnr.");
        
        IF localRecItem.GET("Zuordnung zu Artikelnr.") THEN BEGIN
          GetSalesHeader;
          PriceCalcMgt.FindSalesLinePrice(SalesHeader,localRecSalesLine,FIELDNO("No."));
          PriceCalcMgt.FindSalesLineLineDisc(SalesHeader,localRecSalesLine);
        
          "Unit Price" := localRecSalesLine."Unit Price";
          VALIDATE("Unit Price");
          IF SalesHeader."Shortcut Dimension 1 Code" = '' THEN
            VALIDATE("Shortcut Dimension 1 Code",localRecItem."Global Dimension 1 Code");
          IF SalesHeader."Shortcut Dimension 2 Code" = '' THEN
            VALIDATE("Shortcut Dimension 2 Code",localRecItem."Global Dimension 2 Code");
          Description := localRecItem.Description;
          IF SalesHeader."Language Code" <> '' THEN BEGIN
             IF ItemTranslation.GET("Zuordnung zu Artikelnr.","Variant Code",SalesHeader."Language Code") THEN BEGIN
                Description := ItemTranslation.Description;
                "Description 2" := ItemTranslation."Description 2";
              END;
          END ELSE
              Description := localRecItem.Description;
        END;
        
        
        "Wertkorrektur zu Artikelposten" := 0;
        //CLEAR(TmpVKPreis);
        //CLEAR(TmpArtikelZuordnung);
        //CLEAR(TmpSachkonto);
        //TmpSachkonto := "No.";
        //TmpArtikelZuordnung := "Zuordnung zu Artikelnr.";
        //TmpType := Type;
        //Type := Type::Item;
        //"No." := "Zuordnung zu Artikelnr.";
        //VALIDATE("No.");
        //TmpVKPreis := "Unit Price";
        //Type := TmpType; //Type::"G/L Account";
        //"No." := TmpSachkonto;
        //VALIDATE("No.");
        //"Zuordnung zu Artikelnr." := TmpArtikelZuordnung;
        //"Unit Price" := TmpVKPreis;
        
        
        UpdateAmounts;
        //+LAN010
        */

    end;

    procedure SetSuspendLotCreation(NewSuspendLotCreation: Boolean)
    begin
        //-LAN006
        SuspendLotCreation := NewSuspendLotCreation;
        //+LAN006
    end;

    procedure CheckItemChargeShipment(CalledByField: Integer; var SalesShipmentLines: Record "111")
    var
        SalesItemCharge: Record "5809";
    begin
        //-GL013
        IF ("Zuordnung zu Artikelnr." <> '') AND ("Line No." <> 0) THEN BEGIN
            SalesItemCharge.INIT;
            SalesItemCharge."Document Type" := "Document Type";
            SalesItemCharge."Document No." := "Document No.";
            SalesItemCharge."Document Line No." := "Line No.";
            SalesItemCharge."Line No." := 10000;
            SalesItemCharge."Item Charge No." := "No.";
            SalesItemCharge."Item No." := "Zuordnung zu Artikelnr.";
            SalesItemCharge.Description := '';
            SalesItemCharge."Qty. to Assign" := Quantity;
            SalesItemCharge."Qty. Assigned" := 0;
            //SalesItemCharge."Amount to Assign" := ABS("Line Amount"-"Line Discount Amount");
            SalesItemCharge."Amount to Assign" := "Line Amount";
            IF SalesItemCharge."Qty. to Assign" <> 0 THEN
                SalesItemCharge."Unit Cost" := ROUND(SalesItemCharge."Amount to Assign" / SalesItemCharge."Qty. to Assign", 0.00001);
            SalesItemCharge."Applies-to Doc. Type" := SalesItemCharge."Applies-to Doc. Type"::Shipment;
            SalesItemCharge."Applies-to Doc. No." := SalesShipmentLines."Document No.";
            SalesItemCharge."Applies-to Doc. Line No." := SalesShipmentLines."Line No.";
            SalesItemCharge."Applies-to Doc. Line Amount" := 0;
            IF NOT SalesItemCharge.INSERT THEN
                SalesItemCharge.MODIFY;
        END;
        //+GL013
    end;

    procedure CheckItemChargeInvoice(CalledByField: Integer; var SalesInvoiceLines: Record "113")
    var
        SalesItemCharge: Record "5809";
    begin
        //-GL013
        IF ("Zuordnung zu Artikelnr." <> '') AND ("Line No." <> 0) THEN BEGIN
            SalesItemCharge.INIT;
            SalesItemCharge."Document Type" := "Document Type";
            SalesItemCharge."Document No." := "Document No.";
            SalesItemCharge."Document Line No." := "Line No.";
            SalesItemCharge."Line No." := 10000;
            SalesItemCharge."Item Charge No." := "No.";
            SalesItemCharge."Item No." := "Zuordnung zu Artikelnr.";
            SalesItemCharge.Description := '';
            SalesItemCharge."Qty. to Assign" := Quantity;
            SalesItemCharge."Qty. Assigned" := 0;
            //SalesItemCharge."Amount to Assign" := ABS("Line Amount"-"Line Discount Amount");
            SalesItemCharge."Amount to Assign" := "Line Amount";
            IF SalesItemCharge."Qty. to Assign" <> 0 THEN
                SalesItemCharge."Unit Cost" := ROUND(SalesItemCharge."Amount to Assign" / SalesItemCharge."Qty. to Assign", 0.00001);
            //TODOPBA SalesItemCharge."Applies-to Doc. Type" := SalesItemCharge."Applies-to Doc. Type"::;
            SalesItemCharge."Applies-to Doc. No." := SalesInvoiceLines."Document No.";
            SalesItemCharge."Applies-to Doc. Line No." := SalesInvoiceLines."Line No.";
            SalesItemCharge."Applies-to Doc. Line Amount" := 0;
            IF NOT SalesItemCharge.INSERT THEN
                SalesItemCharge.MODIFY;
        END;
        //+GL013
    end;

    procedure GetRahmenauftragPreis(cRahmenNr: Code[20]; iRahmenLineNr: Integer; dPreis: Decimal; dMenge: Decimal; var bReturnOK: Boolean) dPreisReturn: Decimal
    var
        recRSalesLine: Record "37";
        recSalesLineMengen: Record "37";
        dLiefermenge: Decimal;
        recSalesHeader: Record "36";
    begin
        //-GL027
        bReturnOK := TRUE;  //GL028
        dPreisReturn := dPreis;
        IF STRLEN(cRahmenNr) > 0 THEN BEGIN

            //-GL029
            //Ist der Rahmenauftrag noch offen?
            CLEAR(recSalesHeader);
            recSalesHeader.SETRANGE("Document Type", recSalesHeader."Document Type"::"Blanket Order");
            recSalesHeader.SETRANGE("No.", cRahmenNr);
            recSalesHeader.SETRANGE(Auftragsstatus, recSalesHeader.Auftragsstatus::Geliefert);
            IF NOT recSalesHeader.FINDSET THEN BEGIN
                //+GL029

                //Rahmenauftragszeile holen
                CLEAR(recRSalesLine);
                recRSalesLine.SETRANGE("Document Type", "Document Type"::"Blanket Order");
                recRSalesLine.SETRANGE("Document No.", cRahmenNr);
                recRSalesLine.SETRANGE("Line No.", iRahmenLineNr);
                IF recRSalesLine.FINDSET THEN BEGIN
                    dPreisReturn := recRSalesLine."Unit Price";

                    //Prüfen, ob noch genügend Stück am Rahmenauftrag offen sind
                    IF (recRSalesLine.Quantity - recRSalesLine."Quantity Shipped") < dMenge THEN BEGIN
                        bReturnOK := FALSE;   //GL028
                        MESSAGE('Am Rahmenauftrag %1 sind %2 Stk offen!', cRahmenNr,
                          (recRSalesLine.Quantity - recRSalesLine."Quantity Shipped"));

                    END ELSE BEGIN
                        //Mengen "Zu Liefern" in den Aufträgen zu dem Rahmenauftrag summieren
                        dLiefermenge := 0;
                        CLEAR(recSalesLineMengen);
                        recSalesLineMengen.SETRANGE("Document Type", "Document Type"::Order);
                        recSalesLineMengen.SETRANGE("Blanket Order No.", cRahmenNr);
                        recSalesLineMengen.SETRANGE("Blanket Order Line No.", iRahmenLineNr);
                        IF recSalesLineMengen.FINDSET THEN
                            REPEAT
                                //Aktuelle Zeile ausnehmen
                                IF NOT ((Rec."Document Type" = recSalesLineMengen."Document Type")
                                  AND (Rec."Document No." = recSalesLineMengen."Document No.")
                                  AND (Rec."Line No." = recSalesLineMengen."Line No.")) THEN
                                    dLiefermenge += recSalesLineMengen."Qty. to Ship"
                            UNTIL recSalesLineMengen.NEXT = 0;

                        //Ist die offene Menge und die Menge in den Aufträgen kleiner als die Angefordete Menge, dann Meldung
                        IF ((recRSalesLine.Quantity - recRSalesLine."Quantity Shipped") - dLiefermenge) < dMenge THEN BEGIN
                            bReturnOK := FALSE;   //GL028
                            MESSAGE('Für den Rahmenauftrag %1 sind %2 Stk offen und %3 Stk in Aufträgen vorgesehen!',
                              cRahmenNr, (recRSalesLine.Quantity - recRSalesLine."Quantity Shipped"), dLiefermenge + dMenge);
                        END;
                    END;

                END;

                //-GL029
            END ELSE BEGIN
                bReturnOK := FALSE;
                MESSAGE('Der Rahmenauftrag %1 ist fertig geliefert!', cRahmenNr);
            END;
            //+GL029

        END;
        //+GL027
    end;

    procedure Packungsgroesse() cPackungsgroesse: Code[10]
    var
        recItem: Record "27";
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

    procedure GetHeaderMengeZuNrBerechnung(cAuftragsNr: Code[20]) bReturn: Boolean
    var
        recSH: Record "36";
    begin
        //-GL033
        //Ist die Funktionalität im Kopf aktiviert?
        bReturn := FALSE;
        IF recSH.GET(recSH."Document Type"::Order, cAuftragsNr) THEN
            bReturn := recSH."VKBetragMenge+NR";

        //+GL033
    end;

    procedure "CheckArtikelVerfügbarkeitVKL"(cItemNo: Code[20]; cLotNo: Code[20]; dMengeBedarf: Decimal; cAuftragNr: Code[20])
    var
        recitem: Record "27";
        dlagerstand: Decimal;
        recSL: Record "37";
        dmengeInAuftraege: Decimal;
        recItemLedgerEntry_lokal: Record "32";
    begin
        //-GL040

        IF recitem.GET(cItemNo) THEN BEGIN
            IF (STRLEN(cLotNo) > 0) AND (dMengeBedarf > 0) THEN BEGIN

                //Lagerstand auf VKL ermitteln
                CLEAR(recItemLedgerEntry_lokal);
                recItemLedgerEntry_lokal.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date",
                  "Expiration Date", "Lot No.", "Serial No.");
                recItemLedgerEntry_lokal.SETRANGE(Open, TRUE);
                recItemLedgerEntry_lokal.SETRANGE("Item No.", cItemNo);
                recItemLedgerEntry_lokal.SETFILTER("Location Code", 'VKL');
                recItemLedgerEntry_lokal.SETRANGE("Lot No.", cLotNo);
                IF recItemLedgerEntry_lokal.FINDFIRST THEN BEGIN
                    dlagerstand := 0;
                    REPEAT
                        dlagerstand += recItemLedgerEntry_lokal."Remaining Quantity";
                    UNTIL recItemLedgerEntry_lokal.NEXT = 0;
                END;

                //Menge in Aufträge, nicht geliefert, ermitteln
                recSL.SETRANGE(Type, recSL.Type::Item);
                recSL.SETRANGE("No.", cItemNo);
                recSL.SETRANGE("Lot No.", cLotNo);
                recSL.SETFILTER("Document No.", '<>' + cAuftragNr);      //Eigenen Auftrag ausnehmen
                IF recSL.FINDFIRST THEN
                    REPEAT
                        dmengeInAuftraege += recSL."Qty. to Ship";
                    UNTIL recSL.NEXT = 0;
                //Eigenen Auftrag nicht mitnehmen


                //Genug offene Menge vorhanden?
                IF dMengeBedarf > (dlagerstand - dmengeInAuftraege) THEN
                    MESSAGE('Keine Ausreichende Menge auf VKL der Charge %1 vorhanden!', cLotNo);

            END;
        END;
        //+GL040
    end;

    procedure SetOriginalRequestedDeliveryDate()
    var
        SalesHeader: Record "Sales Header";
    begin
        // >> GL048
        SalesHeader.GET("Document Type", "Document No.");
        IF ((OriginalRequestedDeliveryDate = 0D) AND
             (SalesHeader."Requested Delivery Date" <> 0D) AND
             (Type = Type::Item)) THEN BEGIN
            OriginalRequestedDeliveryDate := SalesHeader."Requested Delivery Date";
        END;
        // << GL048
    end;

    var
        LotMgt: Codeunit 50002;
        cuChargenverwaltung: Codeunit ChargenverwaltungPageApp;
        SuspendLotCreation: Boolean;
}
