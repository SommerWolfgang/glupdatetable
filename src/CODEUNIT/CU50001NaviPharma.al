codeunit 50001 NaviPharma
{

    // version GL,LQ18.1,Schenker,Instance,TODOPBA2

    // 
    // ------------------------------------------------------------------------------------------------------------------------------------
    // Datum      | Autor   | Status     | Beschreibung
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-04-11 | Petsch  | ok         | Update von 3.60
    //                                   | Alle Druckausgaben wurden in CU50002 ausgelagert
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-07-07 | MFU     | ok         | GL001 - Anzeigen der FA-Dispoliste hat bei Verpackungsmaterialien nicht funktioniert
    //                                   | (bei nicht genügend auf Lager )  -> wurde am 14.07.2010 wieder entfernt MFU
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-08-02 | Petsch  | ok         | SchreibeEreignisposten() eingebaut
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-09-07 | Petsch  | ok         | SchreibeEreignisposten() korrigiert, ConvertDateTime() hiefür eingebaut
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-09-14 | Petsch  | ok         | Standortweiche(): ITEM_SITE_MANUFACTURING eingebaut
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-09-16 | Petsch  | OK         | Standortweiche(): USER eingebaut
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-12-03 | Petsch  | ok         | Chargenfunktionen in CU50001 verschoben
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-01-10 | Rieder  | ok         | GL002 Standortweiche für Artikel- und Usermerkmale umgebaut (log)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-01-12 | Rieder  | ok         | GL003 Standortweiche für Lagerort hinzugefügt (log)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-01-18 | Rieder  | ok         | GL004 Standortweiche für Fertigungsaufträge hinzugefügt (log)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-01-19 | Rieder  | ok         | GL005 Tabellenschlüssel korrigiert (log)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-03-28 | MFU     | ok         | GL006 Sektion in Funktion Standortweiche eingebaut
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-04-09 | Rieder  | ok         | GL007 Funktion PrüfeUnterstufeFrei() ergänzt (log)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-04-28 | Rieder  | ok         | GL008 Funktion PrüfeUnterstufeFrei() erweitert auf Rohstoffprüfung (log)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-04-29 | MFU     | ok         | GL006 Erweiterung
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-05-07 | Rieder  | ok         | GL008 Anpassung (log)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-11-17 | MFU     | ok         | GL009 Funktion zum Prüfen ob genug freie Artikel vorhanden sind eingefügt
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-12-01 | Petsch  | ok         | Umlagerungssperre für Fertigprodukt in PL aufgehoben, Wunsch Dr. Posch
    //                                     d.h. jetzt dürfen Halbfabrikat und Fertigprodukt in Quarantäne nach PL gelagert werden
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2012-02-26 | Rieder  | ok         | IsTestEnvironment():Boolean eingebaut. Gibt false=ECHT oder true=TEST zurück.
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2014-06-11 | MFU     | ok         | GetUserName(): Username mit Funktion holen -> Muss Konvertiert werden
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2014-12-18 | MFU     | ok         | GL010 - Fehler bei Korrekurbuchung zu Ismeldung bei Unterstufenprüfung behoben
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2015-05-13 | PRA     | ok         | GL011 - Fehler bei Berechnung Ablaufdatum für FF korrigiert
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2015-05-13 | PRA     | ok         | GL012 - Abfrage Testumgebung schnell ohne Serverabfrage damit Echt funktioniert
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-03-16 | PRA     | ok         | GL013 - FADispoCheck mit Datumsfilter --> Eingrenzung bis FA-Endedatum
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-12-07 | MFU     | ok         | GL014 - Bei Umlagerung in Verkaufslagern prüfen, ob Mepis die Chargen zum Hub hochgeladen hat -> Noch nicht aktiviert!
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2017-01-30 | MFU     | ok         | GL015 - Funktion GetHerstelldatum(FAxxxxxx) -> Das Herstelldatum eines Fertigartikel ermitteln (Istmeldung / Erste Einwaage)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2017-02-22 | PRA     | ok         | GL016 - GetHerstelldatum-Wien Berechnung für Fertigprodukte aus AblaufdatumsUltimo und nicht aus Chargennr
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2017-05-09 | MFU     | ok         | GL017 - GetArtikelMarketingLinie() -> Holen der Marketinglinie aus der Kostenträgertabelle
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2017-06-14 | MFU     | ok         | GL018 - Lagerstand vor Ort ohne neuen Lagerort RESERVIERT
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2018-01-16 | MFU     | ok         | GL019 - Filter entfernt, da dieser bei AH-Karten Umbau stört und nicht relevant ist
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2018-02-19 | DKO     | ok         | GL020 - HACK bei Uhrzeitüberlauf, Datum +1D rechnen. --> FIX bei Umstellung auf NAV2018
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2018-03-28 | MFU     | ok         | GL021 - Ablaufdatumprüfung auf Monatsletzten angepasst
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2018-03-28 | MFU     | ok         | GL022 - TA* Artikel bei der Unterstufenprüfung aushemen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2018-08-08 | MFU     | ok         | GL023 - Neue Funktion zum prüfen von Windream Dokumente
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2018-10-17 | DKO     | ok         | GL024 - LQ18 - Anpassungen auf neue Tabelle
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2018-12-05 | DKO     | ok         | GL025 - LQ18 - AHK Status Abfrage angepasst - Art, Lief, Herst müssen alle vorhanden sein
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2019-01-29 | DKO     | ok         | GL026 - Bei Unterstufenprüfung von Fertigprodukt, HF Kommentare von HF Ware anzeigen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2019-03-28 | DKO     | ok         | GL027 - GetLastLedgerEntry - Gibt Datum des letzten Bewegungspostens für Kreditor/Debitor/Kostenstellen/-arten/-träger/Sachkonto zurück
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2019-03-29 | DKO     | ok         | GL028 - CepChangeEmailNotify - Einheitliche Fkt zum Versenden der CEP Change Benachrichtigung von T39 und T6505 aus
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2019-04-15 | DKO     | ok         | GL029 - CepChangeEmailNotify - Artikelname und Herstellername in Mail schreiben
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2019-09-10 | PRA     | ok         | GL030 - CC1949 LagerstandFrei: Bestände ohne Lagerorte W-RÜL,W-GESPERRT, W-PE und W-ANALYTIK
    //            |         |            | GL031                   Entfernung des Dualsystems
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2019-09-16 | DKO     | ok         | GL032 - IsItemLQrelevant - Fertigware welche keine Serialisierungskarte besitzt oder noch nie zertifiziert wurde, ist nicht LQ relevant
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2019-10-14 | MFU     | ok         | GL033 - Anpassungen Schenker -> Umlagerungssperren
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2020-06-09 | DKO     | ok         | GL034 - CheckInstances -> Überprüft ob NAV bereits geöffnet, Ausnahme "SUPER" User
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2021-01-27 | DKO     | ok         | GL035 - CepChangeEmailNotify - Empfänger-Email aus LIMS Config holen wenn möglich
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2021-02-10 | MFU     | ok         | GL036 - Prüffunktion auf Mengen einer älteren Charge auf einem Lagerort
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 
    // 
    // Update: Petsch: CalcDate ab 2013 in <> einklammern, sonst Fehler bei Multilanguage und statt L (laufend) C (current) und d statt T verwenden


    trigger OnRun()
    begin
    end;

    procedure CheckArtikelBewegung(artikelbuchblattzeile: Record "83") ok: Boolean
    var
        recManufacturingSetup: Record "99000765";
        lOK: Boolean;
        Item: Record "27";
        Chargenstamm: Record "6505";
    begin
        EXIT(TRUE); // >> 02.07.2021 PBA
        lOK := FALSE;

        WITH artikelbuchblattzeile DO BEGIN

            //Kostenstellenprüfung
            IF "Entry Type" <> "Entry Type"::Transfer THEN
                IF Item.GET("Item No.") THEN
                    IF NOT Item."Inventory Value Zero" THEN
                        IF "Shortcut Dimension 1 Code" = '' THEN
                            ERROR('Kostenstelle fehlt bei Artikelnummer %1, Buchblattzeilennummer %2, Belegzeilennummer %3', "Item No.",
                                    "Line No.", "Document Line No.");

            //Schränke zulässiges Buchungsdatum ein
            CheckArtikelBuchDatGrenze("Posting Date");

            //Prüfung: keine Chargennr. bei nichtchargenpflicht. Artikeln erlaubt
            IF "Lot No." <> '' THEN
                IF Item.GET("Item No.") THEN
                    IF Item."Item Tracking Code" = '' THEN
                        ERROR('Artikel ' + "Item No." + ': Chargennr. eingegeben, aber Artikel nicht chargenpflichtig ' +
                                 '(Feld Artikelverfolgungscode in Artikelkarte leer)');

            IF Quantity = 0 THEN  //Wenn nur Rechnungsmenge ohne Liefervorgang: keine Artikelbewegung, also keine Ch.Prüfungen
                EXIT(TRUE);

            IF Item.GET("Item No.") THEN  //bei nicht chargenpflichtigen Artikeln ab hier Aussprung
                IF Item."Item Tracking Code" = '' THEN
                    EXIT(TRUE);

            //Prüfung auf Freigabe bei Umlagerung ins VKL/KONL/LOHN
            IF "New Location Code" IN ['VKL', 'KONL', 'LOHN', 'SVKL'] THEN BEGIN      //-GL033
                IF Chargenstamm.GET("Item No.", '', "Lot No.") = FALSE THEN
                    ERROR('Artikel ' + "Item No." + ', Ch.Nr.' + "Lot No." + ': kein Eintrag in Chargenstammm, Umlagerung in '
                           + 'VKL/KONL/LOHN/SVKL unzulässig!')
                ELSE BEGIN
                    IF Chargenstamm.Status <> Chargenstamm.Status::Frei THEN
                        ERROR('Artikel ' + "Item No." + ', Ch.Nr.' + "Lot No." + ' ist nicht freigegeben, Umlagerung in VKL/KONL/LOHN/SVKL unzulässig!');
                    IF Chargenstamm."Expiration Date" = 0D THEN
                        ERROR('Artikel ' + "Item No." + ', Ch.Nr.' + "Lot No." +
                              ' kein Ablaufdatum eingetragen, Umlagerung in VKL/KONL/LOHN unzulässig!');
                    IF Chargenstamm."Expiration Date" <= (WORKDATE) THEN
                        ERROR('Artikel ' + "Item No." + ', Ch.Nr.' + "Lot No." + ' ist abgelaufen, Umlagerung in VKL/KONL/LOHN/SVKL unzulässig!');

                    //-GL014  Noch nicht aktiviert
                    /*
                    //Prüfen, ob Mepis die Seriennummern zum Hub geladen hat
                    IF Item.Artikelart = Item.Artikelart::Fertigprodukt THEN
                      IF recSeri.GET("Item No.") THEN
                        IF (recSeri.Status=recSeri.Status::Zertifiziert) AND (recSeri.serialization=TRUE) THEN BEGIN  //Serialisierung Vorhanden und Zertifiziert?

                           //Bei Ärztemuster prüfen, ob es eine Istmeldung zur Charge gibt (Wenn keine Istmeldung wurde das Ärztemuster nur beklebt -> In MEPIS nichts machen)
                           bOK := TRUE;
                           IF COPYSTR(Item."Packungsgröße",1,2)='ÄM' THEN BEGIN
                             bOK := FALSE;
                             CLEAR(recItemPosten);
                             recItemPosten.SETRANGE("Item No.","Item No.");
                             recItemPosten.SETRANGE("Lot No.","Lot No.");
                             recItemPosten.SETRANGE("Entry Type",recItemPosten."Entry Type"::Output);  //Istmeldung zu der Charge
                             IF recItemPosten.FINDFIRST THEN
                               bOK := TRUE;
                           END;

                          IF bOK=TRUE THEN BEGIN
                             iReturn := cuMepis.Send_is_wo_sn_transfer_to_hub("Item No.","Lot No.",tReturn);
                             IF iReturn<>0 THEN
                               MESSAGE('Fehler bei Anlage des Wareneingang in MEPIS! %1 - %2',iReturn,tReturn);
                          END;

                        END;
                    */
                    //+GL014


                END;
            END;

            //Umlagerung in PL bei Artikelart=Halbfabrikat+Fertigware von Quarantäneware erlaubt
            IF "New Location Code" IN ['PL'] THEN BEGIN
                IF Chargenstamm.GET("Item No.", '', "Lot No.") = FALSE THEN
                    ERROR('Artikel ' + "Item No." + ', Ch.Nr.' + "Lot No." + ': kein Eintrag in Chargenstammm, Umlagerung in '
                           + 'PL unzulässig!')
                ELSE BEGIN
                    IF ((Item.Artikelart = Item.Artikelart::Halbfabrikat) OR (Item.Artikelart = Item.Artikelart::Fertigprodukt)) THEN BEGIN
                        IF Chargenstamm.Status = Chargenstamm.Status::Gesperrt THEN
                            ERROR('Artikel ' + "Item No." + ', Ch.Nr.' + "Lot No." + ' ist gesperrt, Umlagerung in PL unzulässig!');
                    END ELSE BEGIN  // Sperren für alles außer Bulk+FW
                        IF Chargenstamm.Status <> Chargenstamm.Status::Frei THEN
                            ERROR('Artikel ' + "Item No." + ', Ch.Nr.' + "Lot No." + ' ist nicht freigegeben, Umlagerung in PL unzulässig!');
                        IF Chargenstamm."Expiration Date" = 0D THEN
                            ERROR('Artikel ' + "Item No." + ', Ch.Nr.' + "Lot No." +
                               ' kein Ablaufdatum eingetragen, Umlagerung in PL unzulässig!');
                        IF Chargenstamm."Expiration Date" <= (WORKDATE) THEN
                            ERROR('Artikel ' + "Item No." + ', Ch.Nr.' + "Lot No." + ' ist abgelaufen, Umlagerung in PL unzulässig!');
                    END;
                END;
            END;


            //Prüfung auf Freigabe Verkauf von chargenpflichtigen Artikeln
            IF ("Entry Type" = "Entry Type"::Sale) AND (Quantity > 0) THEN BEGIN  //Gutschriften nicht prüfen!AND (Menge > 0)
                IF Chargenstamm.GET("Item No.", '', "Lot No.") = FALSE THEN
                    ERROR('Artikel ' + "Item No." + ', Ch.Nr.' + "Lot No." + ': kein Chargeneintrag vorhanden!')
                ELSE BEGIN
                    //Prüfungen auf abgelaufene Ware
                    IF Chargenstamm.Status <> Chargenstamm.Status::Frei THEN //Freigabedatum = 0D THEN
                        ERROR('Artikel ' + "Item No." + ', Ch.Nr.' + "Lot No." + ' ist noch nicht freigegeben, kein Verkauf möglich');
                    IF "Location Code" = 'KONL' THEN BEGIN
                        IF Chargenstamm."Expiration Date" <= (WORKDATE) THEN
                            IF CONFIRM('Artikel ' + "Item No." + ', Ch.Nr.' + "Lot No." + ' ist am ' + FORMAT(Chargenstamm."Expiration Date")
                                     + ' abgelaufen!, Rechnungsposition trotzdem fakturieren?') = FALSE THEN
                                ERROR('Auftrag abgebrochen');
                    END ELSE BEGIN //alle anderen Lagerorte
                        IF Chargenstamm."Expiration Date" <= (WORKDATE - 14) THEN
                            ERROR('Artikel ' + "Item No." + ', Ch.Nr.' + "Lot No." + ' ist abgelaufen, kein Verkauf möglich');
                        IF Chargenstamm."Expiration Date" <= CALCDATE('<CM-9M>', WORKDATE) THEN
                            IF CONFIRM('Artikel ' + "Item No." + ', Ch.Nr.' + "Lot No." + ' läuft in weniger als 9 '
                                 + 'Monaten ab, trotzdem verkaufen ?') = FALSE THEN
                                ERROR('Auftrag abgebrochen');
                    END;
                END;
            END;

            //Prüfung auf gleiche Verkaufschargennr., wenn plus-Mengenbuchung
            IF Chargenstamm.GET("Item No.", "Variant Code", "Lot No.") THEN BEGIN
                IF (("Entry Type" IN ["Entry Type"::Sale, "Entry Type"::Consumption, "Entry Type"::"Negative Adjmt."]) AND (Quantity < 0))
                  OR (("Entry Type" IN ["Entry Type"::Purchase, "Entry Type"::Output, "Entry Type"::"Positive Adjmt."]) AND (Quantity > 0))
                  OR ("Entry Type" = "Entry Type"::Transfer)
                THEN BEGIN
                    IF Chargenstamm."Verkaufschargennr." <> "Verkaufschargennr." THEN
                        ERROR('Die Verkaufschargennr. %1 stimmt nicht mit dem Chargenstammeintrag %2 überein; ' +
                           '(Änderung ist nur mehr im Chargenstamm (Artikelnr. %3, Chargennr. %4) möglich) ',
                          "Verkaufschargennr.", Chargenstamm."Verkaufschargennr.", "Item No.", "Lot No.");
                    //IF StandortWeiche("Item No.",'ITEM')='LANNACH' THEN BEGIN
                    IF Chargenstamm."Expiration Date" <> "Expiration Date" THEN
                        ERROR('Das Ablaufdatum %1 stimmt nicht mit dem Chargenstammeintrag %2 überein; ' +
                        '(Änderung ist nur mehr im Chargenstamm (Artikelnr. %3, Chargennr. %4) möglich) ',
                       "Expiration Date", Chargenstamm."Expiration Date", "Item No.", "Lot No.");
                    //END ELSE IF StandortWeiche("Item No.",'ITEM')='WIEN' THEN BEGIN
                    //  IF ("Expiration Date" <> 0D) AND (Chargenstamm."Expiration Date" <> "Expiration Date") THEN
                    //    ERROR('Das Ablaufdatum %1 stimmt nicht mit dem Chargenstammeintrag %2 überein; ' +
                    //     '(Änderung ist nur mehr im Chargenstamm (Artikelnr. %3, Chargennr. %4) möglich) ',
                    //    "Expiration Date",Chargenstamm."Expiration Date","Item No.","Lot No.");
                    //END;

                END;
            END;

        END;
        EXIT(lOK);

    end;

    procedure CheckArtikelBuchDatGrenze(BuchDatum: Date)
    var
        fibuEinrichtung: Record "98";
        dBeginn: Date;
    begin
        //Anmerkung: in Nav. 2009 gäbe es eigene Artikelbuchungsperioden...
        fibuEinrichtung.GET;
        IF fibuEinrichtung.ArtikelBuchDatGrenze THEN BEGIN
            IF (DATE2DMY(WORKDATE(), 2) - 1) = 0 THEN
                dBeginn := DMY2DATE(1, 12, DATE2DMY(WORKDATE(), 3) - 1)
            ELSE
                dBeginn := DMY2DATE(1, DATE2DMY(WORKDATE(), 2) - 1, DATE2DMY(WORKDATE(), 3));
            IF ((BuchDatum < dBeginn) OR (BuchDatum >= WORKDATE() + 15)) THEN
                ERROR('Buchungsdatum %1 liegt ausserhalb des zulässigen Bereichs von 1. des Vormonats bzw. +15 Tagen', BuchDatum);
        END;
    end;


    procedure Ablaufdatum(artikelnummer: Code[20]; chargennummer: Code[20]; startdatum: Date) ablaufdatum: Date
    var
        artikel: Record "27";
        cHilf: Text[30];
        dHilf: Date;
        nHilf: Integer;
        nJahr: Integer;
        nMonat: Integer;
        ManufacturingSetup: Record "99000765";
    begin
        ManufacturingSetup.GET;
        IF ManufacturingSetup.Chargennummernsystem = ManufacturingSetup.Chargennummernsystem::Lannacher THEN BEGIN
            IF artikel.GET(artikelnummer) THEN BEGIN
                IF (COPYSTR(chargennummer, 1, 4) > '2200') OR (COPYSTR(chargennummer, 1, 4) < '1999') OR
                    (COPYSTR(chargennummer, 5, 1) < 'A') OR (COPYSTR(chargennummer, 5, 1) > 'M') THEN BEGIN //keine gültige Ch.nr, nimm startdatum
                    IF startdatum = 0D THEN
                        MESSAGE('weder erkennbare Chargennummer, noch Startdatum vorhanden!')
                    ELSE BEGIN
                        //dHilf := CALCDATE('+1M-1T',startdatum); //Monatsletzten bestimmen
                        dHilf := DMY2DATE(1, DATE2DMY(startdatum, 2), DATE2DMY(startdatum, 3)); //Monatsersten errechnen MFU
                        dHilf := CALCDATE('<-1D>', dHilf); //Damit es gleich ist wie das Datum von den Chargennummern kommend MFU
                        dHilf := CALCDATE('<-1M>', dHilf); //Damit es gleich ist wie von den Chargennummern kommend MFU
                    END;
                END ELSE BEGIN //errechnen aus gültiger Ch.nr
                    cHilf := COPYSTR(chargennummer, 5, 1);
                    CASE cHilf OF
                        'A':
                            nMonat := 1;
                        'B':
                            nMonat := 2;
                        'C':
                            nMonat := 3;
                        'D':
                            nMonat := 4;
                        'E':
                            nMonat := 5;
                        'F':
                            nMonat := 6;
                        'G':
                            nMonat := 7;
                        'H':
                            nMonat := 8;
                        'J':
                            nMonat := 9;
                        'K':
                            nMonat := 10;
                        'L':
                            nMonat := 11;
                        'M':
                            nMonat := 12;
                    END;
                    EVALUATE(nJahr, COPYSTR(chargennummer, 1, 4));
                    dHilf := DMY2DATE(1, nMonat, nJahr);
                    dHilf := CALCDATE('<-1D>', dHilf); //Monatsletzten bestimmen
                    dHilf := CALCDATE('<-1M>', dHilf);
                END;

                IF dHilf <> 0D THEN BEGIN
                    IF FORMAT(artikel."Expiration Calculation") <> '' THEN BEGIN
                        ablaufdatum := CALCDATE('<+' + FORMAT(artikel."Expiration Calculation") + '>', dHilf);
                        //IF CALCDATE('+24M',dHilf) >= ablaufdatum THEN  //016 MFU
                        ablaufdatum := CALCDATE('<+1M>', ablaufdatum); //Artikel unter 24 Monate Laufzeit bis letzten des lauf. Monats
                        ablaufdatum := DMY2DATE(1, DATE2DMY(ablaufdatum, 2), DATE2DMY(ablaufdatum, 3)); //Monatsletzten errechnen
                        ablaufdatum := CALCDATE('<+2M>', ablaufdatum); //Monatsletzten errechnen
                        ablaufdatum := CALCDATE('<-1D>', ablaufdatum); //Monatsletzten errechnen
                    END ELSE
                        MESSAGE('Keine Haltbarkeitsformel in der Artikelkarte hinterlegt!');
                END;
            END;
        END;
    end;


    procedure AblaufdatumFremd(artikelnummer: Code[20]; chargennummer: Code[20]; startdatum: Date) ablaufdatum: Date
    var
        artikel: Record "27";
        cHilf: Text[30];
        dHilf: Date;
        nHilf: Integer;
        nJahr: Integer;
        nMonat: Integer;
        ManufacturingSetup: Record "99000765";
    begin
        ManufacturingSetup.GET;
        IF ManufacturingSetup.Chargennummernsystem = ManufacturingSetup.Chargennummernsystem::Lannacher THEN BEGIN
            IF artikel.GET(artikelnummer) THEN BEGIN
                IF (COPYSTR(chargennummer, 1, 4) > '2200') OR (COPYSTR(chargennummer, 1, 4) < '1999') OR
                    (COPYSTR(chargennummer, 5, 1) < 'A') OR (COPYSTR(chargennummer, 5, 1) > 'M') THEN BEGIN //keine gültige Ch.nr, nimm startdatum
                    IF startdatum = 0D THEN
                        MESSAGE('weder erkennbare Chargennummer, noch Startdatum vorhanden!')
                    ELSE BEGIN
                        //dHilf := CALCDATE('+1M-1T',startdatum); //Monatsletzten bestimmen
                        dHilf := DMY2DATE(1, DATE2DMY(startdatum, 2), DATE2DMY(startdatum, 3)); //Monatsersten errechnen MFU
                        dHilf := CALCDATE('<-1D>', dHilf); //Damit es gleich ist wie das Datum von den Chargennummern kommend MFU
                        dHilf := CALCDATE('<-1M>', dHilf); //Damit es gleich ist wie von den Chargennummern kommend MFU
                    END;
                END ELSE BEGIN //errechnen aus gültiger Ch.nr
                    cHilf := COPYSTR(chargennummer, 5, 1);
                    CASE cHilf OF
                        'A':
                            nMonat := 1;
                        'B':
                            nMonat := 2;
                        'C':
                            nMonat := 3;
                        'D':
                            nMonat := 4;
                        'E':
                            nMonat := 5;
                        'F':
                            nMonat := 6;
                        'G':
                            nMonat := 7;
                        'H':
                            nMonat := 8;
                        'J':
                            nMonat := 9;
                        'K':
                            nMonat := 10;
                        'L':
                            nMonat := 11;
                        'M':
                            nMonat := 12;
                    END;
                    EVALUATE(nJahr, COPYSTR(chargennummer, 1, 4));
                    dHilf := DMY2DATE(1, nMonat, nJahr);
                    dHilf := CALCDATE('<-1D>', dHilf); //Monatsletzten bestimmen
                    dHilf := CALCDATE('<-1M>', dHilf);
                END;

                IF dHilf <> 0D THEN BEGIN
                    IF FORMAT(artikel."Expiration Calculation") <> '' THEN BEGIN
                        ablaufdatum := CALCDATE('<+' + FORMAT(artikel."Expiration Calculation") + '>', dHilf);
                        //IF CALCDATE('+24M',dHilf) >= ablaufdatum THEN  diese zeile nicht bei gerotschen artikeln
                        ablaufdatum := CALCDATE('<+1M>', ablaufdatum); //Artikel unter 24 Monate Laufzeit bis letzten des lauf. Monats
                        ablaufdatum := DMY2DATE(1, DATE2DMY(ablaufdatum, 2), DATE2DMY(ablaufdatum, 3)); //Monatsletzten errechnen
                        ablaufdatum := CALCDATE('<+2M>', ablaufdatum); //Monatsletzten errechnen
                        ablaufdatum := CALCDATE('<-1D>', ablaufdatum); //Monatsletzten errechnen
                    END ELSE
                        MESSAGE('Keine Haltbarkeitsformel in der Artikelkarte hinterlegt!');
                END;
            END;
        END;
    end;

    procedure AblaufDatumPlausibel(sArtikelnummer: Text[20]; dtDate: Date) bResult: Boolean
    var
        recItem: Record "27";
        dtHelp: Date;
        dtHelpToday: Date;
    begin

        bResult := FALSE;
        IF dtDate = 0D THEN EXIT(TRUE);
        IF dtDate <= TODAY THEN BEGIN
            MESSAGE('Das Ablaufdatum muss in der Zukunft liegen!\Das Datum wird zurückgesetzt.');
            EXIT;
        END;
        IF NOT recItem.GET(sArtikelnummer) THEN EXIT;
        IF (FORMAT(recItem."Expiration Calculation") <> '') THEN BEGIN
            //-GL021
            //Neu:
            dtHelp := CALCDATE('<-' + FORMAT(recItem."Expiration Calculation") + '>', dtDate);
            dtHelpToday := CALCDATE('+LM', TODAY); //Auf Monatsletzten setzen
                                                   //ORG:  IF (CALCDATE('<-' + FORMAT(recItem."Expiration Calculation")+'>', dtDate) > TODAY) THEN
                                                   //+GL021
            IF (dtHelp > dtHelpToday) THEN BEGIN
                MESSAGE('Gemäß der Ablaufdatumsformel würde das Herstelldatum in der Zukunft liegen! Das kann nicht sein.\' +
                  'Das Datum wird zurückgesetzt.');
                EXIT;
            END;
        END;
        bResult := TRUE;
    end;

    procedure DatumsUltimoGerot(dtDate: Date) dtResult: Date
    var
        iMonth: Integer;
        iYear: Integer;
    begin

        //diese funktion bestimmt den ultimo des vormonats!

        IF dtDate = 0D THEN ERROR('Der Funktion DatumsUltimoGerot wurde kein gültiges Datum übergeben!');

        iMonth := DATE2DMY(dtDate, 2);
        iYear := DATE2DMY(dtDate, 3);

        dtResult := DMY2DATE(1, iMonth, iYear);
        dtResult := CALCDATE('<-1D>', dtResult);
    end;

    procedure DatumsFormatGerot(dtDate: Date; sFormat: Text[60]) sResult: Text[30]
    begin

        sResult := '';
        IF dtDate = 0D THEN BEGIN
            //->003 ausgeblendet, da sonst beim druck von freigabeetikette stört, wenn charge noch kein ablaufdatum hat
            //     MESSAGE('Der Berechnung für das Datumsformat wurde kein Datum übergeben!');
            //<-003
            EXIT;
        END;
        IF sFormat = '' THEN EXIT(FORMAT(dtDate));

        sResult := FORMAT(dtDate, 0, sFormat);
    end;

    procedure Produktionsdatum(chargennummer: Code[20]) produktionsdatum: Date
    var
        dHilf: Date;
        nHilf: Integer;
        nJahr: Integer;
        nMonat: Integer;
        cHilf: Text[30];
        ManufacturingSetup: Record "99000765";
    begin
        produktionsdatum := 0D;
        ManufacturingSetup.GET;
        IF ManufacturingSetup.Chargennummernsystem = ManufacturingSetup.Chargennummernsystem::Lannacher THEN BEGIN
            //Ermitteln des Produktionsdatums aus der Chargennr. (für GUS-Artikel)
            IF (COPYSTR(chargennummer, 1, 4) > '2200') OR (COPYSTR(chargennummer, 1, 4) < '1999') OR
              (COPYSTR(chargennummer, 5, 1) < 'A') OR (COPYSTR(chargennummer, 5, 1) > 'M') THEN
                MESSAGE(chargennummer + ' ist keine gültige Lannacher Chargennummer!')
            ELSE BEGIN
                cHilf := COPYSTR(chargennummer, 5, 1);
                CASE cHilf OF
                    'A':
                        nMonat := 1;
                    'B':
                        nMonat := 2;
                    'C':
                        nMonat := 3;
                    'D':
                        nMonat := 4;
                    'E':
                        nMonat := 5;
                    'F':
                        nMonat := 6;
                    'G':
                        nMonat := 7;
                    'H':
                        nMonat := 8;
                    'J':
                        nMonat := 9;
                    'K':
                        nMonat := 10;
                    'L':
                        nMonat := 11;
                    'M':
                        nMonat := 12;
                END;
                EVALUATE(nJahr, COPYSTR(chargennummer, 1, 4));
                produktionsdatum := DMY2DATE(1, nMonat, nJahr);
            END;
        END ELSE
            IF ManufacturingSetup.Chargennummernsystem = ManufacturingSetup.Chargennummernsystem::Gerot THEN BEGIN

            END;
    end;

    procedure FABulkMenge()
    begin
    end;


    procedure LagerStandFrei(artikelnummer: Code[20]) mengefrei: Decimal
    var
        chargenstamm: Record "6505";
        artikel: Record "27";
        nGesamt: Decimal;
        nFrei: Decimal;
    begin
        //Duallogik verwenden, je nachdem ob mehr Chargen frei oder unfrei sind...
        IF artikel.GET(artikelnummer) THEN BEGIN
            artikel.CALCFIELDS(Inventory);
            mengefrei := artikel.Inventory;
        END;
        chargenstamm.SETFILTER("Item No.", artikelnummer);
        nGesamt := chargenstamm.COUNT();
        IF nGesamt = 0 THEN
            EXIT(0);
        //-GL031
        //chargenstamm.SETCURRENTKEY(Status,"Item No.","Lot No.");
        //chargenstamm.SETFILTER(Status,'Frei');
        //nFrei := chargenstamm.COUNT();
        //IF nFrei / nGesamt > 0.8 THEN BEGIN
        //  chargenstamm.SETFILTER(Status,'<>Frei');
        //  chargenstamm.SETFILTER(Inventory,'>0');
        //  IF chargenstamm.FIND('-') THEN
        //     REPEAT
        //       chargenstamm.CALCFIELDS(Inventory);
        //       mengefrei := mengefrei - chargenstamm.Inventory;
        //     UNTIL chargenstamm.NEXT = 0;
        //END ELSE BEGIN
        //  chargenstamm.SETFILTER(Status,'=Frei');
        //  chargenstamm.SETFILTER(Inventory,'>0');
        //  mengefrei := 0;
        //  IF chargenstamm.FIND('-') THEN
        //     REPEAT
        //       chargenstamm.CALCFIELDS(Inventory);
        //       mengefrei := mengefrei + chargenstamm.Inventory;
        //     UNTIL chargenstamm.NEXT = 0;
        //END;
        //+GL031
        //-GL031 Ohne Duallogik:
        chargenstamm.SETFILTER("Item No.", artikelnummer);
        chargenstamm.SETFILTER(Status, '=Frei');
        chargenstamm.SETFILTER(Inventory, '>0');
        //GL-030
        chargenstamm.SETFILTER("Location Filter", '<>W-RÜL & <>W-GESPERRT & <>W-PE & <>W-ANALYTIK');
        //GL+030
        mengefrei := 0;
        IF chargenstamm.FIND('-') THEN BEGIN
            //mengefrei := 0;
            REPEAT
                chargenstamm.CALCFIELDS(Inventory);
                mengefrei := mengefrei + chargenstamm.Inventory;
            UNTIL chargenstamm.NEXT = 0;
        END;
        //+GL031
    end;

    procedure LagerStandGesperrt(artikelnummer: Code[20]) mengegesperrt: Decimal
    var
        chargenstamm: Record "6505";
        artikel: Record "27";
    begin
        chargenstamm.SETCURRENTKEY(Status, "Item No.", "Lot No.");
        chargenstamm.SETRANGE("Item No.", artikelnummer);
        chargenstamm.SETRANGE(Status, chargenstamm.Status::Gesperrt);
        IF chargenstamm.FIND('-') THEN
            REPEAT
                chargenstamm.CALCFIELDS(Inventory);
                mengegesperrt += chargenstamm.Inventory;
            UNTIL chargenstamm.NEXT = 0;
    end;

    procedure DatumsFilterVorjahr(datumsstring: Text[30]) neuerstring: Text[30]
    var
        artikel: Record "27";
    begin
        artikel.SETFILTER("Date Filter", datumsstring);
        neuerstring := FORMAT(CALCDATE('<-1Y>', artikel.GETRANGEMIN("Date Filter"))) + '..'
                             + FORMAT(CALCDATE('<-1Y>', artikel.GETRANGEMAX("Date Filter")));
    end;

    procedure Berechtigung(Aktion: Code[20]) ok: Boolean
    var
        MfgSetup: Record "99000765";
        recAccessControl: Record "2000000053";
        recUser: Record "2000000120";
        UserSecurityID: Guid;
    begin
        //Im Code verwendete Aktionen
        //'$HALTBARKEITSINFO' Eingaberecht ins Feld Ablaufdatumsformel der Artikelkarte
        //'$CHARGENVERGABE' Vollrechte in der Maske Chargenvergabe
        //'$ARTIKELBEARBEITEN' Bearbeiten Button in der Artikelkarte
        //'$EINSTANDSPREISE' (wenn nicht vorhanden, werden die Einstandspreise+DB ausgeblendet
        //'$KALKULATION' Aufruf des Reports Produktkalkulation
        //'$MANDANTENCHECK' Im Lannacher-System: Sperre der Mandanten über diesen Weg
        //'$ADMIN' Administratorberechtigung

        ok := FALSE;

        recUser.SETCURRENTKEY("User Name");
        recUser.SETRANGE("User Name", USERID);
        recUser.FINDFIRST;
        UserSecurityID := recUser."User Security ID";

        recAccessControl.SETRANGE("User Security ID", UserSecurityID);
        recAccessControl.SETRANGE("Role ID", Aktion);
        IF recAccessControl.FINDFIRST THEN
            ok := TRUE;

        IF Aktion = '$MANDANTENCHECK' THEN BEGIN
            ok := Berechtigung('$' + UPPERCASE(COMPANYNAME)); //rekursiver Funktionsaufruf
            EXIT(ok);
        END;

        IF NOT ok THEN BEGIN  //bei Rolle Super alle Berechtigung für
            recAccessControl.SETRANGE("Role ID", 'SUPER');
            IF recAccessControl.FINDFIRST THEN
                EXIT(TRUE);
        END;
    end;

    procedure Division("zähler": Decimal; nenner: Decimal) ergebnis: Decimal
    begin
        ergebnis := 0;
        IF nenner <> 0 THEN
            ergebnis := zähler / nenner;
    end;

    procedure "DatumÜbersetzen"(dtDate: Date; sLanguage: Text[3]) sResult: Text[30]
    var
        iVal: array[3] of Integer;
        month_french: array[12] of Text[10];
    begin
        month_french[1] := 'janvier';
        month_french[2] := 'février';
        month_french[3] := 'mars';
        month_french[4] := 'avril';
        month_french[5] := 'mai';
        month_french[6] := 'juin';
        month_french[7] := 'juillet';
        month_french[8] := 'août';
        month_french[9] := 'septembre';
        month_french[10] := 'octobre';
        month_french[11] := 'novembre';
        month_french[12] := 'décembre';

        sResult := 'n/a for ' + sLanguage + '!';
        iVal[1] := DATE2DMY(dtDate, 1);
        iVal[2] := DATE2DMY(dtDate, 2);
        iVal[3] := DATE2DMY(dtDate, 3);

        CASE sLanguage OF
            '':
                sResult := FORMAT(dtDate, 0, 4);
            'DE':
                sResult := FORMAT(dtDate, 0, 4);
            'EN':
                sResult := FORMAT(dtDate, 0, 4);
            'FR':
                sResult := STRSUBSTNO('%1. %2 %3', iVal[1], month_french[iVal[2]], iVal[3]);
        END;

        EXIT(sResult);
    end;

    procedure IncStr(source: Text[10]; increase: Integer; fillupcount: Integer) result: Text[10]
    var
        iVal: Integer;
        iResult: Integer;
        sResult: Text[50];
    begin

        IF NOT EVALUATE(iResult, source) THEN ERROR('Der übergebene Wert kann nicht in eine Zahl umgewandelt werden!');
        IF increase < 1 THEN ERROR('Der Erhöhungswert muss größer oder gleich 1 sein!');
        IF fillupcount > 9 THEN
            MESSAGE('Die Auffüllung ist maximal auf 10 Zeichen möglich! Darüber hinaus wird die Auffüllung ignoriert!');

        sResult := FORMAT(iResult + increase);

        IF STRLEN(sResult) > 10 THEN ERROR('Das Ergebnis würde eine Stringlänge von mehr als 10 Zeichen ergeben!');

        IF fillupcount > 0 THEN
            WHILE (STRLEN(sResult) < 10) AND (STRLEN(sResult) < fillupcount) DO
                sResult := '0' + sResult;

        result := sResult;
    end;

    procedure "PrüfeUnterstufeFrei"(sItemNr: Text[20]; sLotNr: Text[20]; bBulkOnly: Boolean; bLoop: Boolean; bWarnings: Boolean) bResult: Boolean
    var
        recItemLedgerEntry: Record "32";
        recItem: Record "27";
        recLotNoInformation: Record "6505";
        bBulk: Boolean;
        bCheck: Boolean;
        sProdOrderNr: Text[20];
    begin
        recItemLedgerEntry.SETCURRENTKEY("Item No.", "Lot No.", "Posting Date");
        recItemLedgerEntry.SETFILTER("Lot No.", sLotNr);
        recItemLedgerEntry.SETFILTER("Item No.", sItemNr);
        recItemLedgerEntry.SETRANGE("Entry Type", recItemLedgerEntry."Entry Type"::Output);
        IF NOT recItemLedgerEntry.FIND('-') THEN BEGIN
            recItem.GET(sItemNr);
            IF (recItem."Replenishment System" = recItem."Replenishment System"::"Prod. Order") AND
                bWarnings THEN
                MESSAGE('Die Prüfung des Status der Unterstufen wurde abgebrochen, da für Charge ''%1'' des ' +
'Artikels ''%2'' keine Istmeldungsposten vorhanden sind! Dies deutet darauf hin, dass die Charge ''%1'' nicht ' +
'im Haus gefertigt wurde. Das System lässt die Freigabe daher ohne weitere Prüfung dieser Unterstufe zu.',
sLotNr, sItemNr);
            EXIT(TRUE);
        END;

        sProdOrderNr := recItemLedgerEntry."Order No.";
        IF recItemLedgerEntry.COUNT > 1 THEN
            REPEAT
                IF sProdOrderNr <> recItemLedgerEntry."Order No." THEN BEGIN
                    IF bWarnings THEN
                        ERROR('Die Freigabe der Charge ''%1'' des Artikels ''%2'' kann nicht gestattet werden, da ' +
        'mehrere Istmeldungen mit unterschiedlichen Fertigungsauftragsnummern verbucht sind. Bitte melden Sie diesen ' +
        'Fehler dringend der obersten Qualitätssicherung! ', recItemLedgerEntry."Lot No.", recItemLedgerEntry."Item No.");
                END;
            UNTIL recItemLedgerEntry.NEXT = 0;

        recItemLedgerEntry.RESET;
        //+GL005
        //recArtikelposten.SETCURRENTKEY("Prod. Order No.","Prod. Order Line No.","Prod. Order Comp. Line No.","Entry Type");
        recItemLedgerEntry.SETCURRENTKEY("Order Type", "Order No.", "Order Line No.", "Entry Type", "Prod. Order Comp. Line No.");
        //-GL005
        recItemLedgerEntry.SETRANGE("Order Type", recItemLedgerEntry."Order Type"::Production);
        recItemLedgerEntry.SETFILTER("Order No.", sProdOrderNr);
        recItemLedgerEntry.SETRANGE("Entry Type", recItemLedgerEntry."Entry Type"::Consumption);
        recItemLedgerEntry.SETFILTER("Source No.", sItemNr);
        recItemLedgerEntry.SETFILTER("Item No.", '<>TA*');      //GL022
        IF NOT recItemLedgerEntry.FIND('-') THEN BEGIN
            IF bWarnings THEN
                MESSAGE('Die Prüfung des Status der Unterstufen wurde abgebrochen, da für Charge ''%1'' des ' +
'Artikels ''%2'' keine Herstellposten vorhanden sind! Das System lässt die Freigabe daher ohne Unterstufenprüfung zu.',
recItemLedgerEntry."Lot No.", recItemLedgerEntry."Item No.");
            EXIT(TRUE);
        END;

        bCheck := FALSE;
        //+GL007
        bResult := TRUE;
        //-GL007
        //+GL008
        REPEAT
            recItem.GET(recItemLedgerEntry."Item No.");
            bBulk := recItem.Artikelart = recItem.Artikelart::Halbfabrikat;

            IF ((NOT bBulkOnly) OR (bBulk AND bBulkOnly)) AND (recItem."Item Tracking Code" <> '') THEN   //GL007 Tracking Code ergänzt
            BEGIN
                bCheck := TRUE;
                IF recItem."Als Unterstufe nicht prüfen" THEN
                    bResult := TRUE
                ELSE BEGIN
                    recLotNoInformation.SETFILTER("Item No.", recItemLedgerEntry."Item No.");
                    recLotNoInformation.SETFILTER("Lot No.", recItemLedgerEntry."Lot No.");
                    recLotNoInformation.FIND('-');
                    bResult := recLotNoInformation.Status = recLotNoInformation.Status::Frei;
                    IF NOT bResult AND bWarnings THEN
                        MESSAGE('Charge %1 von Artikel %2 ist nicht freigegeben!',
recItemLedgerEntry."Lot No.", recItemLedgerEntry."Item No.");
                    //-GL026
                    IF recLotNoInformation."HF Kommentar" <> '' THEN
                        IF NOT CONFIRM('Kommentar bei %1:\\%2\\Freigabe fortsetzen?', FALSE, recItemLedgerEntry."Item No.", recLotNoInformation."HF Kommentar") THEN
                            ERROR('Freigabe aufgrund von HF Kommentar abgebrochen');
                    //+GL026

                END;

                IF bResult AND bBulk AND bLoop THEN

                    //-GL010
                    IF (sItemNr <> recItemLedgerEntry."Item No.") OR (sLotNr <> recItemLedgerEntry."Lot No.") THEN
                        bResult := PrüfeUnterstufeFrei(recItemLedgerEntry."Item No.", recItemLedgerEntry."Lot No.", bBulkOnly, bLoop, bWarnings)
                    ELSE
                        IF bWarnings THEN
                            MESSAGE('Istmeldung und Verbrauchsbuchung zu gleichem Artikel in einem FA vorhanden! Unterstufenprüfung abgebrochen!');
                //+GL010

            END;
        UNTIL (recItemLedgerEntry.NEXT = 0) OR (NOT bResult);
        //-GL008

        IF bBulkOnly AND NOT bCheck THEN BEGIN
            bResult := TRUE;
            IF bWarnings THEN
                MESSAGE('Da in den Stücklisten kein Bulk enthalten ist, wurde keine Unterstufencharge auf ihren ' +
'Status überprüft! Das System lässt die Freigabe daher ohne Unterstufenprüfung zu.');
        END;
    end;

    procedure StrCrypt(sWord: Text[30]; iKey: Integer; bDecode: Boolean) Result: Text[30]
    var
        i_ARRAYLENGTH: Integer;
        s_CHARARRAY: Text[100];
        i: Integer;
        t: Integer;
        z: Integer;
        c: Char;
        x: Integer;
    begin
        //Achtung: randomize+random liefern in 2009 und 2013R2 verschiedene Ergebnisse!!!!!!!!!!!!!!!!!!!!!!!!
        //PIN-Codes daher beim Update entschlüsseln in 2009 und neu Verschlüsseln mit 2013
        Result := '';
        s_CHARARRAY := '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        i_ARRAYLENGTH := STRLEN(s_CHARARRAY);

        IF bDecode THEN z := -1 ELSE z := 1;
        RANDOMIZE(iKey);

        Result := '';
        FOR i := 1 TO STRLEN(sWord) DO BEGIN
            c := sWord[i];
            t := STRPOS(s_CHARARRAY, FORMAT(sWord[i]));
            IF t > 0 THEN BEGIN
                x := RANDOM(i_ARRAYLENGTH);
                //MESSAGE(FORMAT(x));
                t := t + (z * x);
                IF (t < 1) OR (t > i_ARRAYLENGTH) THEN t := t - (z * i_ARRAYLENGTH);
                c := s_CHARARRAY[t];
            END;
            Result := Result + FORMAT(c);
        END;
    end;

    procedure LagerstandFreiLannacher_EXP(artikelnummer: Code[20]) mengefrei: Decimal
    var
        chargenstamm: Record "6505";
        artikel: Record "27";
        recCompanyInfo: Record "79";
    begin

        //+014
        //Lagerstand fix vom Lannacher Mandanten holen

        //Negativlogik verwenden, da performance besser, weil meiste Chargen ja frei sind
        recCompanyInfo.GET;
        artikel.CHANGECOMPANY('LANNACHER');
        chargenstamm.CHANGECOMPANY('LANNACHER');

        IF artikel.GET(artikelnummer) THEN BEGIN
            artikel.CALCFIELDS(Inventory);
            mengefrei := artikel.Inventory;
        END;
        chargenstamm.SETCURRENTKEY("Item No.", "Variant Code", "Lot No.");
        chargenstamm.SETFILTER("Item No.", artikelnummer);
        chargenstamm.SETFILTER(Inventory, '>0');
        chargenstamm.SETFILTER(Status, '<>Frei');  //chargenstamm.SETRANGE(Status,chargenstamm.Status::Frei);
        IF chargenstamm.FIND('-') THEN
            REPEAT
                chargenstamm.CALCFIELDS(Inventory);
                mengefrei := mengefrei - chargenstamm.Inventory;
            UNTIL chargenstamm.NEXT = 0;
        //-014
    end;

    procedure FremdChargennrRequired(cItemNo: Code[20]): Boolean
    var
        recItem: Record "27";
        recManufacturingSetup: Record "99000765";
        lRequired: Boolean;
    begin
        //1.7.09, Petsch
        lRequired := FALSE;
        recItem.SETRANGE("No.", cItemNo);
        IF recItem.FIND('-') THEN BEGIN
            recManufacturingSetup.GET;
            IF recItem."Gen. Prod. Posting Group" = recManufacturingSetup.FremdChNrProdBuchGruppe THEN
                lRequired := TRUE;
            IF recItem."Item Tracking Code" = 'CHARGEWIEN' THEN
                lRequired := TRUE;
        END;
        EXIT(lRequired);
    end;

    procedure StandortWeiche(Datenfeld: Text[30]; Wert: Text[40]): Text[30]
    var
        recItem: Record "27";
        recUserSetup: Record "91";
        recLocation: Record "14";
        recProductionOrder: Record "5405";
        iNum: Integer;
    begin
        //+GL002
        CASE Datenfeld OF
            'ITEM_SITE_MANUFACTURING':
                IF recItem.GET(Wert) AND (recItem."Site Manufacturing" <> '') THEN
                    EXIT(recItem."Site Manufacturing");  //LANNACH/WIEN/EXTERN
            'ITEM_SITE_BATCH_RELEASE':
                IF recItem.GET(Wert) AND (recItem."Site Batch Release" <> '') THEN
                    EXIT(recItem."Site Batch Release");  //LANNACH/WIEN
            'ITEM_SITE_ASSIGNMENT':
                IF recItem.GET(Wert) AND (recItem."Site Assignment" <> '') THEN
                    EXIT(recItem."Site Assignment");  //LANNACH/WIEN
            'ITEM_SITE_SAMPLES':
                IF recItem.GET(Wert) AND (recItem."Site Samples" <> '') THEN
                    EXIT(recItem."Site Samples");  //LANNACH/WIEN
            'ITEM_SITE_ANALYSES':
                IF recItem.GET(Wert) AND (recItem."Site Analyses" <> '') THEN
                    EXIT(recItem."Site Analyses");  //LANNACH/WIEN
            'ITEM_SITE_STABILITIES':
                IF recItem.GET(Wert) AND (recItem."Site Stabilities" <> '') THEN
                    EXIT(recItem."Site Stabilities");  //LANNACH/WIEN/EXTERN
        END;

        CASE Datenfeld OF
            'USER_SITE_MANUFACTURING':
                IF recUserSetup.GET(Wert) AND (recUserSetup."Site Manufacturing" <> '') THEN
                    EXIT(recUserSetup."Site Manufacturing");  //LANNACH/WIEN
            'USER_SALES_RESPONSIBILITY':
                IF recUserSetup.GET(Wert) AND (recUserSetup."Sales Resp. Ctr. Filter" <> '') THEN
                    EXIT(recUserSetup."Sales Resp. Ctr. Filter");  //EXPORT/INLAND/LOHN/MUSTER
            'USER_PURCHASE_RESPONSIBILITY':
                IF recUserSetup.GET(Wert) AND (recUserSetup."Purchase Resp. Ctr. Filter" <> '') THEN
                    EXIT(recUserSetup."Purchase Resp. Ctr. Filter");  //EK-LANNACH/EK-WIEN
            'USER_SERVICE_RESPONSIBILITY':
                IF recUserSetup.GET(Wert) AND (recUserSetup."Service Resp. Ctr. Filter" <> '') THEN
                    EXIT(recUserSetup."Service Resp. Ctr. Filter");  //
        END;
        //-GL002
        //+GL003
        /*
        CASE Datenfeld OF
            'LOCATION_SITE_MANUFACTURING':
                IF recLocation.GET(Wert) AND (recLocation."Site Manufacturing" <> '') THEN
                    EXIT(recLocation."Site Manufacturing");  //LANNACH/WIEN
            'LOCATION_MANUFACTURING_AREA':
                IF recLocation.GET(Wert) AND (recLocation."Manufacturing Area" <> '') THEN
                    EXIT(recLocation."Manufacturing Area");  //KONF/...
            'LOCATION_CITY':
                IF recLocation.GET(Wert) AND (recLocation.City <> '') THEN
                    EXIT(recLocation.City);  //Wien/Lannach/...
        END;
       
        //-GL003
        //+GL004
        CASE Datenfeld OF
            'PROD_ORDER_SITE_MANUFACTURING':
                BEGIN
                    recProductionOrder.SETFILTER("No.", Wert);
                    IF recProductionOrder.FINDLAST AND (recProductionOrder."Site Manufacturing" <> '') THEN
                        EXIT(recProductionOrder."Site Manufacturing");  //LANNACH/WIEN
                END;
            'PROD_ORDER_MANUFACTURING_AREA':
                BEGIN
                    recProductionOrder.SETFILTER("No.", Wert);
                    IF recProductionOrder.FINDLAST AND (recProductionOrder."Manufacturing Area" <> '') THEN
                        EXIT(recProductionOrder."Manufacturing Area");  //KONF/...
                END;
        END;
        //-GL004
        */
        IF Datenfeld = 'USER' THEN BEGIN
            recUserSetup.SETFILTER("User ID", UPPERCASE(Wert));
            IF recUserSetup.FINDFIRST THEN
                EXIT(recUserSetup."Site Manufacturing");
        END;

        IF Datenfeld = 'ITEM' THEN
            IF recItem.GET(Wert) THEN BEGIN
                IF recItem."Item Tracking Code" = 'CHARGEALLE' THEN
                    EXIT('LANNACH');
                IF recItem."Item Tracking Code" = 'CHARGEWIEN' THEN  //UPDATE2013
                    EXIT('WIEN');
            END;

        //-GL006
        IF Datenfeld = 'SCHULUNG_USER' THEN BEGIN
            recUserSetup.SETFILTER("User ID", UPPERCASE(Wert));
            IF recUserSetup.FINDFIRST THEN
                EXIT(recUserSetup.Schulung_Zuordnung)
            ELSE
                EXIT('');  //Wenn kein Benutzer gefunden wurde -> keine Einschränkung
        END;
        //+GL006


        EXIT('LANNACH'); //Fallback
    end;



    procedure LagerStandFreiVorOrt(artikelnummer: Code[20]) mengefrei: Decimal
    var
        chargenstamm: Record "6505";
        artikel: Record "27";
        nGesamt: Decimal;
        nFrei: Decimal;
        recManufacturingSetup: Record "99000765";
        recItemLedgerEntry: Record "32";
    begin

        mengefrei := 0;

        IF artikel.GET(artikelnummer) THEN;
        IF recManufacturingSetup.GET(artikel."Site Manufacturing") THEN;

        CLEAR(recItemLedgerEntry);
        recItemLedgerEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
        recItemLedgerEntry.SETFILTER("Item No.", artikelnummer);
        recItemLedgerEntry.SETFILTER("Location Code", recManufacturingSetup."Lagerbestand vor Ort Filter");
        recItemLedgerEntry.SETRANGE(Open, TRUE);
        IF recItemLedgerEntry.FIND('-') THEN
            REPEAT

                //Prüfen ob die Charge frei ist
                chargenstamm.SETCURRENTKEY(Status, "Item No.", "Lot No.");
                chargenstamm.SETFILTER(Status, 'Frei');
                chargenstamm.SETFILTER("Item No.", artikelnummer);
                chargenstamm.SETFILTER("Lot No.", recItemLedgerEntry."Lot No.");
                IF chargenstamm.FINDSET THEN BEGIN
                    //Menge nur dazugeben wenn die Charge auch frei ist
                    mengefrei += recItemLedgerEntry."Remaining Quantity";
                END;

            UNTIL recItemLedgerEntry.NEXT = 0;
    end;
    /* TODPBA
    procedure IsTestEnvironment() bResult: Boolean
    var
        nPos: Integer;
        cServername: Text[100];
        cDatabasename: Text[100];
        recDatabase: Record "2000000048";
        ActiveSession: Record "2000000110";
    begin
        bResult := FALSE;
    

      

        ActiveSession.SETRANGE("Server Instance ID", SERVICEINSTANCEID);
        ActiveSession.SETRANGE("Session ID", SESSIONID);
        ActiveSession.FINDFIRST;
        cDatabasename := ActiveSession."Database Name";


        //recServer.SETRANGE("My Server",TRUE);     //also not supported in 2013R2 !!!!!!!!!!!!!!
        //recServer.FINDFIRST;
        //cServername := recServer."Server Name";

        //-GL012 Änderung schnell ohne Serverabfrage damit Echt funktioniert
        // IF (UPPERCASE(cServername) <> 'NAVISIONSQL') OR (UPPERCASE(cDatabasename) <> 'GL-PHARMA') THEN
        IF (UPPERCASE(cDatabasename) <> 'GL-PHARMA') THEN
            //-GL012
            EXIT(TRUE);

       

    end;
    
    procedure GetDatabaseName() tDBName: Text[50]
    var
        recDatabase: Record "2000000048";
    begin
        //-UPDATE2013
        tDBName := '';

        //Datenbankname für SQL Zugriff ermitteln
        recDatabase.SETRANGE("My Database", TRUE);
        recDatabase.FINDFIRST;
        tDBName := recDatabase."Database Name";

        //tDBName := 'gl-pharma-vortagessicherung2013R2';  //Datenbankname für Tests in Vortagessicherung
        //+UPDATE2013
    end;

    procedure GetUserName() sReturn: Text[30]
    var
        recUser: Record "2000000120";
    begin
        //-UPDATE2013
        sReturn := USERID; //Defaultname
        recUser.SETRANGE("User Name", USERID);
        IF recUser.FINDFIRST THEN
            sReturn := recUser."Full Name";  //Vollständiger Name (definierbarer Name aus User Einrichtung)
        //+UPDATE2013
    end;
    */
    procedure GetClientartWeb() bWebClient: Boolean
    var
        recActiveSession: Record "2000000110";
    begin
        //-UPDATE2013
        bWebClient := FALSE;
        CLEAR(recActiveSession);
        recActiveSession.SETRANGE("User ID", USERID);
        recActiveSession.SETRANGE("Session ID", SESSIONID);
        IF recActiveSession.FINDFIRST THEN BEGIN
            IF recActiveSession."Client Type" = recActiveSession."Client Type"::"Web Client" THEN
                bWebClient := TRUE;
        END;
        //-UPDATE2013
    end;


    procedure GetArtikelMarketingLinie(cItemNo: Code[20]) cReturn: Code[20]
    var
        recItem: Record "27";
        recStatCode: Record Statistikcode2;
    begin
        //-GL017
        //Rückgabewert muss HKL,ZNS,SOU,... sein -> Text in Tabelle umbenennen?
        cReturn := '';
        IF recItem.GET(cItemNo) THEN
            IF STRLEN(recItem."Statistikcode III") > 0 THEN
                IF recStatCode.GET(recItem."Statistikcode III", 3) THEN
                    IF STRLEN(recStatCode.Marketinglinie) > 0 THEN
                        cReturn := recStatCode.Marketinglinie;
        //+GL017
    end;
    /*TODOPBA
    procedure GetCMRVorhanden(cAuftragNr: Code[20]) bReturn: Boolean
    var
        varArr: array[100, 4] of Text[1024];
        "Count": Integer;
        cuWindr: Codeunit "1043880";
        [RunOnClient]
        SearchCondition: DotNet SearchCondition;
        [RunOnClient]
        SearchConditionList: DotNet List_Of_T;
        [RunOnClient]
        ColumnsList: DotNet List_Of_T;
        [RunOnClient]
        SearchOperator: DotNet SearchOperator;
        [RunOnClient]
        SearchResultList: DotNet IList_Of_T;
        [RunOnClient]
        PnWDLink: DotNet Link;
        WDSetup: Record "1043881";
        iParameteranzahl: Integer;
        i: Integer;
    begin
        //-GL023
        bReturn := FALSE;

        //Variablen initialisieren
        WDSetup.GET;
        WDSetup.TESTFIELD("Job Extender INI Path");
        PnWDLink := PnWDLink.Link();
        PnWDLink.Init(WDSetup."Job Extender INI Path", 'NAV');
        SearchConditionList := SearchConditionList.List();
        ColumnsList := ColumnsList.List();
        ColumnsList.Add('Dokument-ID');
        ColumnsList.Add('##ObjectTypeName##');
        ColumnsList.Add('##ObjectPath##');

        iParameteranzahl := 2;

        //varArr[1,1] := 'Belegnummer';
        varArr[1, 1] := 'Ursprungsbelegnr';
        varArr[1, 2] := cAuftragNr;  //'AN1818072';

        varArr[2, 1] := 'szLongName';
        //varArr[2,2] := 'cmr_'+cAuftragNr+'.pdf';   //Groß/Kleinschreibung ist egal
        varArr[2, 2] := 'Liefernachweis*';   //Groß/Kleinschreibung ist egal

        FOR i := 1 TO iParameteranzahl DO BEGIN
            SearchCondition := SearchCondition.SearchCondition;
            SearchCondition.FieldName := varArr[i, 1];
            SearchCondition.Value := varArr[i, 2];
            //SearchCondition.Operator := SearchOperator.StringLike;
            IF STRPOS(varArr[i, 2], '*') > 0 THEN
                SearchCondition.Operator := SearchOperator.StringLike
            ELSE
                SearchCondition.Operator := SearchOperator.Equal;

            SearchConditionList.Add(SearchCondition);
            ColumnsList.Add(varArr[i, 1]);
        END;

        SearchResultList := PnWDLink.Search('Ausgangsbeleg', SearchConditionList, FALSE, ColumnsList);
        IF ISNULL(SearchResultList) THEN
            EXIT;
        IF SearchResultList.Count > 0 THEN
            bReturn := TRUE;

        //+GL023
    end;

    procedure GetCMRVorhandenServer(cAuftragNr: Code[20]) bReturn: Boolean
    var
        varArr: array[100, 4] of Text[1024];
        "Count": Integer;
        cuWindr: Codeunit "1043880";
        SearchCondition: DotNet SearchCondition;
        SearchConditionList: DotNet List_Of_T;
        ColumnsList: DotNet List_Of_T;
        SearchOperator: DotNet SearchOperator;
        SearchResultList: DotNet IList_Of_T;
        PnWDLink: DotNet Link;
        WDSetup: Record "1043881";
        iParameteranzahl: Integer;
        i: Integer;
    begin
        //-GL023
        //MFU 08.08.2018:   Eigene Funktion, wo dll Variablem mit RunOnClient = No
        bReturn := FALSE;

        //Variablen initialisieren
        WDSetup.GET;
        WDSetup.TESTFIELD("Job Extender INI Path");
        PnWDLink := PnWDLink.Link();
        PnWDLink.Init(WDSetup."Job Extender INI Path", 'NAV');
        SearchConditionList := SearchConditionList.List();
        ColumnsList := ColumnsList.List();
        ColumnsList.Add('Dokument-ID');
        ColumnsList.Add('##ObjectTypeName##');
        ColumnsList.Add('##ObjectPath##');

        iParameteranzahl := 2;

        //varArr[1,1] := 'Belegnummer';
        varArr[1, 1] := 'Ursprungsbelegnr';
        varArr[1, 2] := cAuftragNr;  //'AN1818072';

        varArr[2, 1] := 'szLongName';
        //varArr[2,2] := 'cmr_'+cAuftragNr+'.pdf';   //Groß/Kleinschreibung ist egal
        varArr[2, 2] := 'Liefernachweis*';   //Groß/Kleinschreibung ist egal

        FOR i := 1 TO iParameteranzahl DO BEGIN
            SearchCondition := SearchCondition.SearchCondition;
            SearchCondition.FieldName := varArr[i, 1];
            SearchCondition.Value := varArr[i, 2];
            //SearchCondition.Operator := SearchOperator.StringLike;
            IF STRPOS(varArr[i, 2], '*') > 0 THEN
                SearchCondition.Operator := SearchOperator.StringLike
            ELSE
                SearchCondition.Operator := SearchOperator.Equal;

            SearchConditionList.Add(SearchCondition);
            ColumnsList.Add(varArr[i, 1]);
        END;

        SearchResultList := PnWDLink.Search('Ausgangsbeleg', SearchConditionList, FALSE, ColumnsList);
        IF ISNULL(SearchResultList) THEN
            EXIT;
        IF SearchResultList.Count > 0 THEN
            bReturn := TRUE;

        //+GL023
    end;

    procedure GetSpecificCMRVorhanden(cAuftragNr: Code[20]; tFilenamePrefix: Text[50]) bReturn: Boolean
    var
        varArr: array[100, 4] of Text[1024];
        "Count": Integer;
        cuWindr: Codeunit "1043880";
        [RunOnClient]
        SearchCondition: DotNet SearchCondition;
        [RunOnClient]
        SearchConditionList: DotNet List_Of_T;
        [RunOnClient]
        ColumnsList: DotNet List_Of_T;
        [RunOnClient]
        SearchOperator: DotNet SearchOperator;
        [RunOnClient]
        SearchResultList: DotNet IList_Of_T;
        [RunOnClient]
        PnWDLink: DotNet Link;
        WDSetup: Record "1043881";
        iParameteranzahl: Integer;
        i: Integer;
    begin
        //-GL023
        bReturn := FALSE;
        IF tFilenamePrefix = '' THEN
            tFilenamePrefix := 'Liefernachweis';

        //Variablen initialisieren
        WDSetup.GET;
        WDSetup.TESTFIELD("Job Extender INI Path");
        PnWDLink := PnWDLink.Link();
        PnWDLink.Init(WDSetup."Job Extender INI Path", 'NAV');
        SearchConditionList := SearchConditionList.List();
        ColumnsList := ColumnsList.List();
        ColumnsList.Add('Dokument-ID');
        ColumnsList.Add('##ObjectTypeName##');
        ColumnsList.Add('##ObjectPath##');

        iParameteranzahl := 2;

        //varArr[1,1] := 'Belegnummer';
        varArr[1, 1] := 'Ursprungsbelegnr';
        varArr[1, 2] := cAuftragNr;  //'AN1818072';

        varArr[2, 1] := 'szLongName';
        //varArr[2,2] := 'cmr_'+cAuftragNr+'.pdf';   //Groß/Kleinschreibung ist egal
        varArr[2, 2] := tFilenamePrefix + '*';   //Groß/Kleinschreibung ist egal

        FOR i := 1 TO iParameteranzahl DO BEGIN
            SearchCondition := SearchCondition.SearchCondition;
            SearchCondition.FieldName := varArr[i, 1];
            SearchCondition.Value := varArr[i, 2];
            //SearchCondition.Operator := SearchOperator.StringLike;
            IF STRPOS(varArr[i, 2], '*') > 0 THEN
                SearchCondition.Operator := SearchOperator.StringLike
            ELSE
                SearchCondition.Operator := SearchOperator.Equal;

            SearchConditionList.Add(SearchCondition);
            ColumnsList.Add(varArr[i, 1]);
        END;

        SearchResultList := PnWDLink.Search('Ausgangsbeleg', SearchConditionList, FALSE, ColumnsList);
        IF ISNULL(SearchResultList) THEN
            EXIT;
        IF SearchResultList.Count > 0 THEN
            bReturn := TRUE;

        //+GL023
    end;
    */


    procedure GetLastShipmentDate(CustomerNo: Code[20]) dtLastShipment: Date
    var
        recSSH: Record "110";
    begin
        IF CustomerNo <> '' THEN BEGIN
            recSSH.SETRANGE("Sell-to Customer No.", CustomerNo);
            IF recSSH.FINDLAST THEN
                dtLastShipment := recSSH."Shipment Date";
        END;
    end;

    procedure GetArtikelAufLagerplatz(cLagerort: Code[10]; cLagerplatz: Code[100]; var recTmpILE: Record "32")
    var
        recILE: Record "32";
        nCount: Integer;
        recBin: Record "7302";
        recLocation: Record "14";
    begin
        //Artikel auf Lagerort/Lagerplatz finden und in Tmp-Tabelle schreiben

        IF cLagerort = '' THEN ERROR('Ein Lagerort muss angegeben sein!');
        IF recLocation.GET(cLagerort) THEN
            IF recLocation."Bin Mandatory" = TRUE THEN
                IF cLagerplatz = '' THEN ERROR('Ein Lagerplatz muss bei Lagerorten mit Lagerplatzpflicht angegeben sein!');

        nCount := 1;


        IF cLagerplatz > '' THEN BEGIN

            //Lagerplatz finden
            recBin.SETRANGE("Location Code", cLagerort);
            //recBin.SETRANGE("Item No.", recILE."Item No.");
            //recBin.SETRANGE("Lot No.", recILE."Lot No.");
            recBin.SETFILTER(Quantity, '>0');
            recBin.SETFILTER("Bin Code", cLagerplatz);
            IF recBin.FINDFIRST THEN
                REPEAT

                    recBin.CALCFIELDS(Quantity, "Quantity (Base)");
                    IF recBin."Quantity (Base)" > 0 THEN BEGIN
                        CLEAR(recTmpILE);
                        recTmpILE."Item No." := recBin."Item No.";
                        //GLDE recTmpILE."Lot No." := recBin."Lot No.";
                        recTmpILE."Remaining Quantity" += recBin."Quantity (Base)";
                        recTmpILE.Lagerplatzhilfsfeld := recBin."Bin Code";
                        recTmpILE."Entry No." := nCount;
                        nCount += 1;
                        recTmpILE.INSERT;
                    END;

                UNTIL (recBin.NEXT = 0);

        END ELSE BEGIN

            CLEAR(recILE);
            recILE.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
            recILE.SETRANGE("Location Code", cLagerort);
            recILE.SETRANGE(Open, TRUE);
            recILE.SETFILTER("Remaining Quantity", '>0');
            IF recILE.FINDSET THEN
                REPEAT

                    //Nur Lagerort ohne Lagerplätze
                    CLEAR(recTmpILE);
                    recTmpILE."Item No." := recILE."Item No.";
                    recTmpILE."Lot No." := recILE."Lot No.";
                    recTmpILE.Lagerplatzhilfsfeld := '';
                    recTmpILE."Remaining Quantity" := recILE."Remaining Quantity";
                    recTmpILE."Entry No." := nCount;
                    nCount += 1;
                    recTmpILE.INSERT;

                UNTIL (recILE.NEXT = 0);

        END;
    end;
    /*TODOPBA
    procedure CheckInstances() LoginOK: Boolean
    var
        recActSess: Record "2000000110";
        [RunOnClient]
        env: DotNet Environment;
        recAC: Record "2000000053";
    begin
        //-GL034
        recAC.SETRANGE("User Name", USERID);
        recAC.SETRANGE("Role ID", 'SUPER');
        IF NOT recAC.ISEMPTY THEN
            EXIT(TRUE);

        recActSess.SETRANGE("User ID", USERID);
        recActSess.SETRANGE("Client Type", recActSess."Client Type"::"Windows Client");
        recActSess.SETFILTER("Client Computer Name", '%1', env.GetEnvironmentVariable('COMPUTERNAME') + '*');
        IF recActSess.COUNT > 1 THEN
            EXIT(FALSE)
        ELSE
            EXIT(TRUE);
        //+GL034
    end;
    */
    procedure CheckLagerstandAeltereChargeAufLagerort(cItemNo: Code[20]; cLotNo: Code[20]; cLocationCode: Code[20]) bVorhanden: Boolean
    var
        recLot: Record "6505";
        recLotVergleich: Record "6505";
        recBin: Record "7302";
    begin
        //-GL036
        bVorhanden := FALSE;
        IF recLot.GET(cItemNo, '', cLotNo) THEN BEGIN
            //Gibt es andere Chargen am Prüflagerort?
            recLotVergleich.SETRANGE("Item No.", cItemNo);
            recLotVergleich.SETFILTER("Location Filter", cLocationCode);
            recLotVergleich.SETFILTER(Inventory, '>0');
            IF recLotVergleich.FINDFIRST THEN
                REPEAT
                    IF recLotVergleich.Status = recLotVergleich.Status::Frei THEN  //Nur freie Chargen
                        IF recLot."Expiration Date" > recLotVergleich."Expiration Date" THEN BEGIN

                            //Differenz Lagerplatz ausnehmen
                            recBin.SETRANGE("Location Code", cLocationCode);
                            recBin.SETRANGE("Item No.", cItemNo);
                            //GLDE recBin.SETRANGE("Lot No.", recLotVergleich."Lot No.");
                            recBin.SETFILTER(Quantity, '>0');
                            recBin.SETFILTER("Bin Code", 'DIFFERENZ|BRUCH');
                            IF recBin.FINDFIRST = FALSE THEN
                                bVorhanden := TRUE;
                        END;
                UNTIL (recLotVergleich.NEXT = 0) OR (bVorhanden = TRUE);
        END;
        //+GL036
    end;

    procedure GetErsatzartikel(sItemNo: Code[20]) cItemNoReturn: Code[20]
    var
        recItem_: Record "27";
        recItemSubstitution: Record "5715";
    begin

        // >> 176.01
        cItemNoReturn := '';
        IF recItem_.GET(sItemNo) THEN BEGIN

            recItem_.CALCFIELDS("Substitutes Exist");
            IF recItem_."Substitutes Exist" = TRUE THEN BEGIN
                recItemSubstitution.SETRANGE("No.", recItem_."No.");
                IF recItemSubstitution.FINDFIRST THEN
                    cItemNoReturn := recItemSubstitution."Substitute No.";
            END;

        END;
        // << 176.01
    end;

    procedure IsItemRestrictionRelevant(ItemNo: Code[20]): Boolean
    var
        recItem: Record "27";
    begin
        // >> CCU507.03
        //Zusätzliche Kriterien einbauen? SKU mit Beschaffung <> Prod. Auftrag? Standort Herstellung leer?
        IF NOT recItem.GET(ItemNo) THEN
            EXIT(FALSE);

        //Artikelart muss "Rohstoff", "Fertigware" oder "Halbfabrikat" sein
        CASE recItem.Artikelart OF
            recItem.Artikelart::" ",
          recItem.Artikelart::Verpackungsstoff,
          recItem.Artikelart::Arbeitsschritt:
                EXIT(FALSE);
        END;

        // Wirkstoff, Hilfsstoff oder Restr-Dummy Item
        IF (recItem."Statistikcode I" <> '115') AND
           (recItem."Statistikcode I" <> '110') THEN //AND
                                                     //(NOT IsRestrDummyItem(recItem."No.")) THEN
            EXIT(FALSE);

        //Wenn Hilfsstoff dann nur wenn Leerkapsel
        IF recItem."Statistikcode I" = '110' THEN BEGIN
            IF recItem."Statistikcode II" <> '2060' THEN
                EXIT(FALSE);
        END;

        //Beigestelte Ware auch nicht
        IF recItem."Statistikcode II" = '9000' THEN //Beigestellte Ware
            EXIT(FALSE);

        EXIT(TRUE);
        // << CCU507.03
    end;

    procedure GetUserName(): Text
    var
        sReturn: Text[30];
        recUser: Record User;
    begin

        sReturn := USERID; //Defaultname
        recUser.SETRANGE("User Name", USERID);
        IF recUser.FINDFIRST THEN
            sReturn := recUser."Full Name";  //Vollständiger Name (definierbarer Name aus User Einrichtung)
    end;
}

