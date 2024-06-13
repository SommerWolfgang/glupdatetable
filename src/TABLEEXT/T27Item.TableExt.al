tableextension 50009 "T27 Item" extends Item
{// version NAVW114.44,TODOPBA

    // LAN001 12.11.09 ACPSS LAN1.00
    //   New Fields: ID 50500 - 50514, 50516, 50517, 50535, 65800, 65801
    //   New Key: "Statistikcode I,Statistikcode II,Statistikcode III,No."
    //   Fields ID 3, 4: Length 30 -> 40
    //   Div. Anpassungen
    // 
    // GL001 LagerstandVorOrt()
    // GL002 Funktionen HK() und FAP() eingefügt
    // GL003 Inventory-OnLookup() -> Anzeige der Posten ohne Lagerorteinschränkung
    //        Lookup-Feld auf Inventory, damit nur Restmengen-Artikelposten gezeigt werden
    // GL004 Namensumbenennung benennt auch Stücklistenzeilennamen mit um
    // GL005 Bei Kopieren eines Artikels die Felder Ablaufdatumsformel nur bei Berechtigung mitkopieren
    //        Beim Satz kopieren die QK Felder ignorieren
    // GL006 Key für R50031 eingefügt (Country/Region Code,No.)
    // 
    // ------------------------------------------------------------------------------------------------------------------------------------
    // Datum      | Autor   | Status  | Beschreibung
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-02-09 | MFU     | ok      | Update von 360
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-04-12 | Petsch  | ok      | Feld Inventory-Onlookup: Neues Umlagerungsinfoform (Änderung GL003)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-06-22 | Rieder  | ok      | Felder eingefügt: Site Assignment, Site Manufacturing, Site Batch Release, Site Analyses,
    //                                                    Site Samples, Site Stabilities, Registration Company
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-07-13 | Rieder  | ok      | Felder umgebaut: Site Assignment, Site Manufacturing, Site Batch Release, Site Analyses,
    //                                                   Site Samples, Site Stabilities, Registration Company
    //                                                   (alle Felder referenzieren auf DropDownContent)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-07-13 | Rieder  | ok      | Feld "Force Concentration". Soll die Eingabe einer Gehaltsangabe im Chargenstamm erzwingen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-07-13 | Petsch  | ok      | Feld Manufacturing Area
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-02-08 | Petsch  | ok      | LagerstandVorOrt() auf Manufacturing Setup umgestellt
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-03-15 | MFU     | ok      | Felder "Beschreibung 1/2 lt. Arzneibuch" auf 150 Zeichen erweitert. Wunsch Engelbogen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-05-07 | Rieder  | ok      | Feld "Als Unterstufe nicht prüfen" eingefügt (log)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-05-31 | MFU     | ok      | Feld "Type Forecast" eingefügt (für Absatzplanung)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-09-14 | MFU     | ok      | Feld "Posten vorhanden" eingefügt (zum erkennen nicht genutzer Artikel)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-10-25 | MFU     | ok      | Felder für Kalkulation Simulation eingefügt
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-11-27 | Rieder  | ok      | Feld "Product Type Code" eingefügt. Für Artikelartkürzel Wien
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2012-02-01 | MFU     | ok      | Key eingefügt für Bericht "Artikel-Verkauf-Kumuliert"
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2012-03-03 | Rieder  | ok      | Feld "Storage Condition" eingefügt. (QS Anforderung Kühlware festzulegen)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2012-05-15 | MFU     | ok      | GL007 - Beim Löschen von Artikeln auch die Absatzplanung mit prüfen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2012-05-29 | Petsch  | ok      | Feld VKChargennr nicht berechnen, löst die alte FWFREMD Automatikunterdrückung bei FA ab
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2012-07-20 | MFU     | ok      | GL008 - Funktion FAP() mit Fremdwährung Berechnung
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2012-08-02 | MFU     | ok      | Feld "Beigestellt Artikel Nr." von Code 10 auf Code 20 erweitert
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2012-11-14 | MFU     | ok      | GL009 - Bei Artikellöschen auch die Historiendaten abfragen
    //                                       Neues Feld "Wirkstoff" eingebaut
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2013-01-14 | MFU     | ok      | Feld "Artikel_Hersteller_Anlegen" eingebaut.
    //                                  Wenn TRUE dann nicht mit dem Bericht "ArtikelHersteller_ItemAnlage" automatisch anlegen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2013-01-24 | MFU     | ok      | Spalte "Bestellmenge aus Rahmen" hinzugefügt
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2013-05-08 | MFU     | ok      | GL010 - Bei Artikel Umbenennen auch die Artikelnummern in der AnalyseDB mit ändern
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2015-01-19 | MFU     | ok      | UPDATE2013 Spalte "ItemKred ShipmentMethodCode" für Einkauf eingebaut
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2015-03-30 | MFU     | ok      | Spalte "Schwund_Beschreibung" für Kaltukation (Schulter) eingefügt
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2015-06-10 | MFU     | ok      | offen: keys bei Bedarf erweitern
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2015-08-20 | MFU     | ok      | Fehlende Objektänderungen aus NAV2009 eingebaut:
    //                                   GL011 - Bei mehreren gültigen FAP's gar keinen zurückgeben (Wunsch Schmer)
    //                                   GL012 - Bei Artikellöschen auf auch Artikelbudgetposten prüfen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2015-08-21 | MFU     | ok      | Table Relation zu "Artikel Statistikgruppe" hinzugefügt
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2015-10-13 | MFU     | ok      | Spalte "Tablettenform" für Kaltukation (Schulter/Zechner) eingefügt
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2015-11-12 | MFU     | ok      | Lookup auf DropDownContent in Spalte "Kalkulationszusatz2" (Wunsch Humpel)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2015-11-24 | MFU     | ok      | Bei Feld "Forecast Type" den Typ Planungsauftrag dazugegeben
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2015-12-21 | MFU     | ok      | GL013 - Funktion FAPDatum für R50078 eingebaut
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-01-22 | Petsch  | ok      | Key: Artikelart, Statistikcode I-III, Blocked eingebaut, weil oft lange Anfragezeiten im SQL-Monitor sichtbar
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-03-07 | MFU     | ok      | GL014 - Funktion HKLosgroesse() eingebaut
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-07-20 | MFU     | ok      | Lookupfeld "KundenArtikelnummer" eingebaut (Anzeige in Artikelliste Detail)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-08-01 | MFU     | ok      | "Mindestrestlaufzeit %" eingebaut (Rieder)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-09-07 | MFU     | ok      | "OhneSchwundBerechnung" eingebaut (Für Produktkalkulation)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-09-19 | MFU     | ok      | GL015 - Funktion GK() eingebaut (Kopie von HK für Produktkalkulation RÄG2015)
    //                                          Feld "MatGemeinkosten%7EP" eingebaut
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-12-20 | MFU     | ok      | Lookup "SerialisierungVorhanden" eingebaut (Filter in Artikelliste)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2017-03-06 | MFU     | ok      | GL016 - Dimension handling
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2017-06-14 | MFU     | ok      | GL017 - Funktion LagerstandProduktionVorOrt() dazu (für FADispoCheck())
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2017-07-04 | MFU     | ok      | GL018 - Suchtgiftrelevante Felder sollen nur mit Spezialrecht bearbeitbar sein
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2017-08-01 | MFU     | ok      | GTIN aus Artikelstamm entfernt (Jetzt in Serialisierungsdaten)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2017-08-07 | MFU     | ok      | Lookupfeld "Kreditorenname" von 40 auf 50 Zeichen erhöht
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2017-09-04 | MFU     | ok      | Nettogewicht auf 6 Kommastellen erweitert
    //                                  Verkehrszweig dazu  (Für Intrastatauswertung)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2017-09-21 | MFU     | ok      | "ItemKred PaymentTermsCode" für Transportversicherung eingebaut -> (Wird an Bestellung übertragen)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2017-09-21 | MFU     | ok      | GL019 - Serialisierungsstammdaten auslesen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2017-10-06 | MFU     | ok      | GL020 - Artikel-Herstellerinfos auslesen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2017-11-14 | MFU     | ok      | "Patentschutz bis" eingebaut (Info kommt dann bei Fertigartikelfreigabe)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2018-12-14 | MFU     | ok      | "KalkFloorPreis" "KalkProzentZuFAP" "KalkProzentZuFertigArtikelFAP" für Produktkalkulation eingebaut
    //                                  "KalkPreisFuerTransport"
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2019-02-28 | DKO     | ok      | GL021 - "Protokoll-Änderung vorgesehen" Spalte auf Wunsch von Mayrhofer hinzugefügt
    //                                        - Bei Umstellung auf NAV BC -> Notizen per SQL übertragen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2019-03-13 | DKO     | ok      | GL022 - "Probendurchlaufzeit" für LIMS
    // ------------------------------------------------------------------------------------------------------------------------------------
    fields
    {
        field(50000; "Schrumpfgröße"; Decimal)
        {
            DecimalPlaces = 0 : 3;
            Description = 'Petsch';
        }
        field(50001; "Jod-gramm"; Decimal)
        {
            Description = 'x';
        }
        field(50002; "Jod-ml"; Decimal)
        {
            Description = 'x';
        }
        field(50003; "Modified by"; Code[50])
        {
            Caption = 'Modified by';
            Description = 'Petsch';
            Editable = false;
        }
        field(50004; Kreditorname; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Vendor No.")));
            Caption = 'Vendor Name';
            Description = 'GL';

        }
        field(50005; Anlieferlager; Code[10])
        {
            Description = 'Petsch';
            TableRelation = Location;
        }
        field(50006; Anlieferlagerplatz; Code[20])
        {
            Description = 'Petsch';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD(Anlieferlager));
        }
        field(50007; "Anzahl je Tray"; Decimal)
        {
            DecimalPlaces = 0 : 3;
            Description = 'Petsch';
        }
        field(50008; "Anzahl je Karton"; Decimal)
        {
            DecimalPlaces = 0 : 3;
            Description = 'Petsch';
        }
        field(50009; Lagerungsart; Code[20])
        {
            Description = 'Petsch';
        }
        field(50010; Logistikbewertung; Code[10])
        {
            Description = 'Petsch';
        }
        field(50011; "Anzahl je Gitterbox"; Decimal)
        {
            DecimalPlaces = 0 : 3;
            Description = 'Petsch';
        }
        field(50012; Betriebskennzeichen; Code[10])
        {
            Description = 'Petsch';
        }
        field(50013; DruckFreigabePflichtig; Boolean)
        {
            Description = 'Petsch';
        }
        field(50014; "ARA-Kennzeichen"; Code[10])
        {
            Description = 'Petsch';
        }
        field(50015; "Beigestellt Artikel Nr."; Code[20])
        {
            Description = 'Rieder';
            TableRelation = "Item" WHERE("No." = FIELD("No."));
        }
        field(50016; "Beigestellt Menge"; Decimal)
        {
            DecimalPlaces = 8 : 8;
            Description = 'Rieder';
        }
        field(50017; length; Decimal)
        {
            Caption = 'Length';
            Description = 'Petsch';
        }
        field(50018; width; Decimal)
        {
            Caption = 'width';
            Description = 'Petsch';
        }
        field(50019; height; Decimal)
        {
            Caption = 'Height';
            Description = 'Petsch';
        }
        field(50020; color; Text[30])
        {
            Caption = 'Color';
            Description = 'Petsch';
        }
        field(50021; "Trayhöhe"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50022; "Länge-Umverpackung"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50023; "Breite-Umverpackung"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50024; "Höhe-Umverpackung"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50025; Ablaufdatumformat; Text[60])
        {
            Description = 'Petsch';
        }
        field(50026; "Einstandspreis (neuester)"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50027; "Klischee Nr."; Text[30])
        {
            Description = 'Petsch';
        }
        field(50028; Fertigungsformat; Code[10])
        {
            Description = 'Rieder';
        }
        field(50029; Kalkulationszusatz1; Text[40])
        {
            Description = 'Petsch';
        }
        field(50030; Kalkulationszusatz1Wert; Decimal)
        {
            DecimalPlaces = 2 : 6;
            Description = 'Petsch';
        }
        field(50031; Kalkulationszusatz2; Text[40])
        {
            Description = 'Petsch';
        }
        field(50032; Kalkulationszusatz2Wert; Decimal)
        {
            DecimalPlaces = 2 : 6;
            Description = 'Petsch';
        }
        field(50033; Kalkulationszusatz3; Text[40])
        {
            Description = 'Petsch';
        }
        field(50034; Kalkulationszusatz3Wert; Decimal)
        {
            DecimalPlaces = 2 : 6;
            Description = 'Petsch';
        }
        field(50035; "Kalkulationszusatz1Übernahme"; Boolean)
        {
            Description = 'Petsch';
        }
        field(50036; KalkIncludeItemItself; Boolean)
        {
            Description = 'Petsch';
        }
        field(50037; "Force Concentration"; Boolean)
        {
            Caption = 'Wirkstoffgehalt notwendig';
            Description = 'Rieder';
        }
        field(50038; PostenAnzahl; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Item Ledger Entry" WHERE("Item No." = FIELD("No.")));
            Description = 'MFU';

        }
        field(50039; "Simulation-Arbeitsplannr."; Code[20])
        {
            TableRelation = "Routing Header";
        }
        field(50040; "Simulation-Stuecklistenr."; Code[20])
        {
            TableRelation = "Production BOM Header";
        }
        field(50041; "Simulation-Lot Size"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(50042; "Simulation-Schwund %"; Decimal)
        {
        }
        field(50043; "VKChargennr nicht berechnen"; Boolean)
        {
        }
        field(50044; Wirkstoff; Text[50])
        {
        }
        field(50045; Artikel_Hersteller_Anlegen; Boolean)
        {
            Description = 'MFU';
        }
        field(50046; "Bestellmenge aus Rahmen"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Line"."Outstanding Qty. (Base)" WHERE("Document Type" = CONST(Order),
                                                                               Type = CONST(Item),
                                                                               "No." = FIELD("No."),
                                                                               "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                               "Location Code" = FIELD("Location Filter"),
                                                                               "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                               "Variant Code" = FIELD("Variant Filter"),
                                                                               "Expected Receipt Date" = FIELD("Date Filter"),
                                                                               "Blanket Order No." = FILTER(> '')));
            Caption = 'Qty. on Purch. Order';
            DecimalPlaces = 0 : 5;
            Editable = false;

        }
        field(50048; Tablettenform; Option)
        {
            OptionMembers = " ",rund,oblong,oval,kapsel,"kapselförmig",eliptisch;
        }
        field(50049; "Mindestrestlaufzeit %"; Integer)
        {
        }
        field(50050; SerialisierungVorhanden; Boolean)
        {
            FieldClass = FlowField;


        }
        field(50051; "Anzahl je Trommel"; Decimal)
        {
            DecimalPlaces = 0 : 3;
            Description = 'DKO';
        }
        field(50052; "Patentschutz bis"; Date)
        {
            Description = 'MFU';
        }
        field(50053; "Vermarktungsexklusivität bis"; Date)
        {
            Description = 'DKO';
        }
        field(50054; "Protokoll-Änderung vorgesehen"; Boolean)
        {
            Description = 'GL021';
        }
        field(50055; Probendurchlaufzeit; DateFormula)
        {
            Description = 'GL022';
        }
        field(50056; Anlagedatum; Date)
        {
        }
        field(50057; InNAVBCUebernommen; Boolean)
        {
            Description = 'MFU';
        }
        field(50075; LIMS_VollerProbenumfang; Boolean)
        {
            Description = 'LIMS';
        }
        field(50200; "Regdat Connection"; Boolean)
        {
            Description = 'Regdat';
        }
        field(50500; "Pharmazentralnr."; Code[20])
        {
            Description = 'LAN1.00';
        }
        field(50501; Haltbarkeitsinfo; Code[4])
        {
            DateFormula = true;
            Description = 'LAN1.00';
        }
        field(50502; "Beschreibung 1 lt. Arzneibuch"; Text[150])
        {
            Description = 'LAN1.00';
        }
        field(50503; "Beschreibung 2 lt. Arzneibuch"; Text[150])
        {
            Description = 'LAN1.00';
        }
        field(50504; Suchtgift; Boolean)
        {
            Description = 'LAN1.00';

            trigger OnValidate()
            begin
                //-LAN001
                IF Suchtgift THEN
                    "Psychotroper Stoff" := FALSE;
                //+LAN001
            end;
        }
        field(50505; "Psychotroper Stoff"; Boolean)
        {
            Description = 'LAN1.00';

            trigger OnValidate()
            begin
                //-LAN001
                IF "Psychotroper Stoff" THEN
                    Suchtgift := FALSE;
                //+LAN001
            end;
        }
        field(50506; "Artikel Statistikgruppe"; Code[10])
        {
            Description = 'LAN1.00';

        }
        field(50507; "Statistikcode I"; Code[10])
        {
            Description = 'LAN1.00';
            TableRelation = Statistikcode2.Code WHERE(Ebene = CONST(1));
            //TableRelation = Statistikcode2;
            //ValidateTableRelation = false;
        }
        field(50508; "Statistikcode II"; Code[10])
        {
            Description = 'LAN1.00';
            TableRelation = Statistikcode2.Code WHERE(Ebene = CONST(2));
        }
        field(50509; "Statistikcode III"; Code[10])
        {
            Description = 'LAN1.00';
            TableRelation = Statistikcode2.Code WHERE(Ebene = CONST(3));

            trigger OnValidate()
            begin
                /*
                //-LAN001
                IF Sonderkonditionengruppe = '' THEN BEGIN
                  IF NOT Gruppe.GET(Gruppe.Typ::"SK-Gruppe","Statistikcode III") THEN BEGIN
                    Gruppe.Typ := Gruppe.Typ::"SK-Gruppe";
                    Gruppe.Gruppe := "Statistikcode III";
                    Gruppe.INSERT;
                  END;
                  Sonderkonditionengruppe := "Statistikcode III";
                END;
                //+LAN001
                 */

            end;
        }
        field(50510; Inventurbewertung; Decimal)
        {
            Description = 'LAN1.00';
        }
        field(50511; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            Description = 'LAN1.00';
            TableRelation = "Country/Region";
        }
        field(50512; "Packungsgröße"; Text[10])
        {
            Caption = 'Packing size';
            Description = 'LAN1.00';
        }
        field(50513; "EAN Code"; Text[13])
        {
            Description = 'LAN1.00';
        }
        field(50514; "Laetus-Code"; Text[10])
        {
            Description = 'LAN1.00';
        }
        field(50515; Schwund_Beschreibung; Text[50])
        {
            Caption = 'Schwund Beschreibung';
            Description = 'MFU';
        }
        field(50516; Artikelart; Option)
        {
            Caption = 'Item type';
            Description = 'LAN1.00';
            OptionCaption = ' ,Rohstoff,Halbfabrikat,Fertigprodukt,Verpackungsstoff,Arbeitsschritt';
            OptionMembers = " ",Rohstoff,Halbfabrikat,Fertigprodukt,Verpackungsstoff,Arbeitsschritt;

            trigger OnValidate()
            var
                Text50000: Label 'Achtung!\Die Artikelart hat Auswirkung auf Chargenerstellung und Kommissionierung!\Ist die Festlegung von Artikelart %1 korrekt?';
            begin
                //-LAN001
                IF xRec.Artikelart = Artikelart THEN
                    EXIT;

                IF NOT CONFIRM(Text50000, FALSE, Artikelart) THEN
                    Artikelart := xRec.Artikelart;
                //+LAN001
            end;
        }
        field(50517; Sonderkonditionengruppe; Code[10])
        {
            Description = 'LAN1.00';
        }
        field(50518; "ItemKred ShipmentMethodCode"; Code[10])
        {
            Description = 'MFU';
            TableRelation = "Shipment Method";
        }
        field(50520; "MatGemeinkosten%7EP"; Decimal)
        {
        }
        field(50521; "ItemKred PaymentTermsCode"; Code[10])
        {
            Description = 'MFU';
            TableRelation = "Payment Terms";
        }
        field(50522; Vollkosten; Decimal)
        {
            Description = 'Petsch';
        }
        field(50523; "Menge in Rahmenbestellung"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Line"."Outstanding Qty. (Base)" WHERE("Document Type" = CONST("Blanket Order"),
                                                                               Type = CONST(Item),
                                                                               "No." = FIELD("No."),
                                                                               "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter")));
            Description = 'GL';

        }
        field(50524; "Vollkosten 2000"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50525; "Suchtgiftnr."; Code[20])
        {
            Description = 'Petsch';
        }
        field(50526; Suchtgiftgehalt; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Petsch';
        }
        field(50527; Suchtgiftbase; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Petsch';
        }
        field(50528; "Mat.-Gemeinkosten %"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Petsch';
        }
        field(50529; "Preis f. Kalkulation"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50530; "Lösungsmittel"; Boolean)
        {
            Description = 'Petsch';
        }
        field(50531; Durchschnittsgehalt; Decimal)
        {
            Description = 'Petsch';
        }
        field(50532; "Schwund %"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Petsch';
        }
        field(50533; "Güterlistencode"; Code[20])
        {
            Description = 'Petsch';
        }
        field(50534; "Mat.-Gemeinkosten % 2"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Petsch';
        }
        field(50535; "Nicht prüfpflichtig"; Boolean)
        {
            Description = 'LAN1.00';
        }
        field(50536; "Überfüllung %"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50537; "Als Unterstufe nicht prüfen"; Boolean)
        {
            Description = 'Rieder';
        }
        field(50538; KalkFloorPreis; Decimal)
        {
            Description = 'MFU';
        }
        field(50539; KalkProzentZuFAP; Decimal)
        {
            Description = 'MFU';
        }
        field(50540; "Item Type"; Code[15])
        {
            Description = 'Rieder';

        }
        field(50541; "Number of Units"; Integer)
        {
            Description = 'Petsch';
        }
        field(50542; "Contents of Unit"; Integer)
        {
            Description = 'Petsch';
        }
        field(50543; "Measure of Contents"; Code[10])
        {
            Description = 'Petsch';
            TableRelation = "Unit of Measure".Code;
        }
        field(50544; Concentration; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Petsch';
        }
        field(50545; "Measure of Concentration"; Code[10])
        {
            Description = 'Petsch';
            TableRelation = "Unit of Measure".Code;
        }
        field(50546; Shape; Code[10])
        {
            Description = 'Petsch';

        }
        field(50547; KalkProzentZuFertigArtikelFAP; Decimal)
        {
            Description = 'MFU';
        }
        field(50549; "Product Type Code"; Code[15])
        {
            Caption = 'Produktart Code';
            Description = 'Rieder';

        }
        field(50550; "Gewicht VP Karton"; Decimal)
        {
            DecimalPlaces = 5 : 5;
            Description = 'Petsch';
        }
        field(50551; "Gewicht VP Kunststoffhohlk."; Decimal)
        {
            DecimalPlaces = 5 : 5;
            Description = 'Petsch';
        }
        field(50552; "Gewicht VP Kunststofffolie"; Decimal)
        {
            DecimalPlaces = 5 : 5;
            Description = 'Petsch';
        }
        field(50553; "Gewicht VP Metall"; Decimal)
        {
            DecimalPlaces = 5 : 5;
            Description = 'Petsch';
        }
        field(50554; "Sales (Qty.) Deb Filter"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - Sum("Item Ledger Entry"."Invoiced Quantity" WHERE("Entry Type" = CONST(Sale),
                                                                              "Item No." = FIELD("No."),
                                                                              "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                              "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                              "Location Code" = FIELD("Location Filter"),
                                                                              "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                              "Variant Code" = FIELD("Variant Filter"),
                                                                              "Posting Date" = FIELD("Date Filter"),
                                                                              "Lot No." = FIELD("Lot No. Filter"),
                                                                              "Serial No." = FIELD("Serial No. Filter"),
                                                                              "Source No." = FILTER(< 50004)));
            Caption = 'Verkauf (Menge) Kunden Filter';
            Description = 'GL';

        }
        field(50555; "Sales (LCY) Deb Filter"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Value Entry"."Sales Amount (Actual)" WHERE("Item Ledger Entry Type" = CONST(Sale),
                                                                           "Item No." = FIELD("No."),
                                                                           "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                           "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                           "Location Code" = FIELD("Location Filter"),
                                                                            "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                            "Variant Code" = FIELD("Variant Filter"),
                                                                            "Posting Date" = FIELD("Date Filter"),
                                                                            "Source No." = FILTER(< 50004)));
            Caption = 'Verkauf (MW) Kunden Filter';
            Description = 'GL';

        }
        field(50556; KalkPreisFuerTransport; Decimal)
        {
            Description = 'MFU';
        }
        field(50559; "Site Assignment"; Code[20])
        {
            Caption = 'Standort Zuordnung';
            Description = 'Rieder';

        }
        field(50560; "Manufacturing Area"; Code[20])
        {
            Caption = 'Herstellungsbereich';
            Description = 'Rieder';

        }
        field(50561; "Site Manufacturing"; Code[20])
        {
            Caption = 'Standort Herstellung';
            Description = 'Rieder';

        }
        field(50562; "Site Batch Release"; Code[20])
        {
            Caption = 'Standort Freigabe';
            Description = 'Rieder';

        }
        field(50563; "Site Analyses"; Code[20])
        {
            Caption = 'Standort Analysen';
            Description = 'Rieder';

        }
        field(50564; "Site Samples"; Code[20])
        {
            Caption = 'Standort Rückstellmuster';
            Description = 'Rieder';

        }
        field(50565; "Site Stabilities"; Code[20])
        {
            Caption = 'Standort Stabilitäten';
            Description = 'Rieder';

        }
        field(50566; "Registration Company"; Code[20])
        {
            Caption = 'Zulassungsinhaber';
            Description = 'Rieder';

        }
        field(50567; "Manufacturing For"; Code[20])
        {
            Caption = 'Contract Manufacturing for';
            Description = 'GL';

        }
        field(50568; "Type Forecast"; Option)
        {
            FieldClass = FlowFilter;
            OptionMembers = " ",Verkauf,Kolo,Muster,Planungsauftrag,Forecast;
        }
        field(50569; "Storage Condition"; Option)
        {
            Caption = 'Lagerbedingung';
            Description = 'Rieder';
            OptionMembers = " ",Raum,"Kühl";
        }
        field(50570; OhneSchwundBerechnung; Boolean)
        {
        }
        field(50571; Verkehrszweig; Code[10])
        {
            Description = 'MFU';
            TableRelation = "Transport Method".Code;
        }

        field(65800; "Übertrag Suchtgiftliste"; Decimal)
        {
            Description = 'LAN1.00';
            Editable = false;
        }
        field(65801; "Seite Suchtgiftliste"; Integer)
        {
            Description = 'LAN1.00';
            Editable = false;
        }
    }
    keys
    {
        key(Key17; "Pharmazentralnr.")
        {
        }
        key(Key18; Artikelart, "Statistikcode I", "Statistikcode II", "Statistikcode III")
        {
        }
    }
    protected var

        Text50001: Label 'Die Beschreibung in den Stücklistenzeilen mitumbenennen?';
        Text50002: Label 'You cannot delete %1 %2 because there is at least one %3 that includes this item.';
        Text50003: Label 'You cannot delete %1 %2 because there is at least one %3 that includes this item.';


    procedure LagerstandVorOrt(itemno: Code[20]) lagerstand: Decimal
    var
        recitem: Record "27";
        recManufacturingSetup: Record "99000765";
    begin
        //-GL001
        IF recitem.GET(itemno) THEN BEGIN
            IF recManufacturingSetup.GET(recitem."Site Manufacturing") THEN;
            recitem.SETFILTER("Location Filter", recManufacturingSetup."Lagerbestand vor Ort Filter");
            recitem.CALCFIELDS(recitem.Inventory);
            lagerstand := recitem.Inventory;
        END;
        //+GL001
    end;

    procedure LagerstandLannach(itemno: Code[20]) lagerstand: Decimal
    var
        recitem: Record "27";
        recManufacturingSetup: Record "99000765";
    begin
        //-GL001
        IF recitem.GET(itemno) THEN BEGIN
            IF recManufacturingSetup.GET('LANNACH') THEN;
            recitem.SETFILTER("Location Filter", recManufacturingSetup."Lagerbestand vor Ort Filter");
            recitem.CALCFIELDS(recitem.Inventory);
            lagerstand := recitem.Inventory;
        END;
        //+GL001
    end;

    procedure LagerstandWien(itemno: Code[20]) lagerstand: Decimal
    var
        recitem: Record "27";
        recManufacturingSetup: Record "99000765";
    begin
        //-GL001
        IF recitem.GET(itemno) THEN BEGIN
            IF recManufacturingSetup.GET('WIEN') THEN;
            recitem.SETFILTER("Location Filter", recManufacturingSetup."Lagerbestand vor Ort Filter");
            recitem.CALCFIELDS(recitem.Inventory);
            lagerstand := recitem.Inventory;
        END;
        //+GL001
    end;

    procedure HK(artikelnummer: Code[20]) hk: Decimal
    var
        ArtVKPreis: Record "7002";
    begin
        //-GL002
        hk := 0;
        CLEAR(ArtVKPreis);
        WITH ArtVKPreis DO BEGIN
            SETFILTER("Item No.", artikelnummer);
            SETRANGE("Sales Type", ArtVKPreis."Sales Type"::"Customer Price Group");
            SETFILTER("Sales Code", '9HK');
            SETRANGE("Currency Code", '');
            IF FIND('+') THEN BEGIN
                hk := "Unit Price";
            END ELSE BEGIN
                SETRANGE("Currency Code", 'ATS');
                IF FIND('+') THEN
                    hk := ROUND("Unit Price" / 13.7603, 0.00001);
            END;
        END;
        //+GL002
    end;

    procedure FAP(artikelnummer: Code[20]) fap: Decimal
    var
        ArtVKPreis: Record "7002";
        recCurrencyExchangeRate: Record "330";
    begin
        //-GL002
        fap := 0;
        CLEAR(ArtVKPreis);
        WITH ArtVKPreis DO BEGIN
            SETFILTER("Item No.", artikelnummer);
            SETRANGE("Sales Type", ArtVKPreis."Sales Type"::"Customer Price Group");
            SETFILTER("Sales Code", '1FAP');

            //-GL011
            SETFILTER("Starting Date", '..' + FORMAT(TODAY));
            SETFILTER("Ending Date", '(' + FORMAT(TODAY) + '..)|''''');
            //+GL011

            //SETRANGE("Currency Code",'');  //GL008
            IF FIND('+') THEN

                //Sind mehrere Preise aktiv (gleiche Startdatum wie letzter aktiver Preis)?
                SETRANGE("Starting Date", "Starting Date");
            IF FIND('+') THEN BEGIN
                IF COUNT = 1 THEN BEGIN   //GL011 Nur Wert liefern, wenn nur ein Preis aktiv ist
                    fap := "Unit Price";
                    //-GL008
                    IF "Currency Code" <> '' THEN BEGIN
                        CLEAR(recCurrencyExchangeRate);
                        recCurrencyExchangeRate.SETRANGE("Currency Code", "Currency Code");
                        IF recCurrencyExchangeRate.FINDLAST THEN
                            fap := ROUND("Unit Price" / recCurrencyExchangeRate."Exchange Rate Amount", 0.00001);  //Mit Tageskurs in EUR umrechnen
                    END;
                    //+GL008
                END;
            END;
        END;
        //+GL002
    end;

    procedure HoleStatCode(CodeEbene: Integer) cText: Text[30]
    var
        statistikcodes: Record Statistikcode2;
    begin
        //-100
        cText := '';
        CASE CodeEbene OF
            1:
                IF statistikcodes.GET("Statistikcode I", 1) THEN
                    cText := statistikcodes.Bezeichnung;
            2:
                IF statistikcodes.GET("Statistikcode II", 2) THEN
                    cText := statistikcodes.Bezeichnung;
            3:
                IF statistikcodes.GET("Statistikcode III", 3) THEN
                    cText := statistikcodes.Bezeichnung;
        END;
        //+100
    end;

    procedure HKDatum(artikelnummer: Code[20]; KalkDatum: Date) hk: Decimal
    var
        ArtVKPreis: Record "7002";
    begin
        //-100
        hk := 0;
        CLEAR(ArtVKPreis);
        WITH ArtVKPreis DO BEGIN
            SETFILTER("Item No.", artikelnummer);
            SETRANGE("Sales Type", ArtVKPreis."Sales Type"::"Customer Price Group");
            SETFILTER("Sales Code", '9HK');
            SETFILTER("Starting Date", '<' + FORMAT(KalkDatum));
            SETRANGE("Currency Code", '');
            IF FIND('+') THEN BEGIN
                hk := "Unit Price";
            END ELSE BEGIN
                SETRANGE("Currency Code", 'ATS');
                IF FIND('+') THEN
                    hk := ROUND("Unit Price" / 13.7603, 0.00001);
            END;
        END;
        //+100
    end;

    procedure FAPWaehrung(artikelnummer: Code[20]; var cWaehrung: Code[10]) fap: Decimal
    var
        ArtVKPreis: Record "7002";
        recCurrencyExchangeRate: Record "330";
    begin

        //-GL008
        //Denn aktuellen FAP mit Währung zurückgeben (Währung egal)
        cWaehrung := '';
        fap := 0;
        CLEAR(ArtVKPreis);
        WITH ArtVKPreis DO BEGIN
            SETFILTER("Item No.", artikelnummer);
            SETRANGE("Sales Type", ArtVKPreis."Sales Type"::"Customer Price Group");
            SETFILTER("Sales Code", '1FAP');

            //-GL011
            SETFILTER("Starting Date", '..' + FORMAT(TODAY));
            SETFILTER("Ending Date", '(' + FORMAT(TODAY) + '..)|''''');
            //+GL011

            IF FINDLAST THEN BEGIN
                //Sind mehrere Preise aktiv (gleiche Startdatum wie letzter aktiver Preis)?
                SETRANGE("Starting Date", "Starting Date");
                IF FINDLAST THEN
                    IF COUNT = 1 THEN BEGIN   //GL011  Nur Wert liefern, wenn nur ein Preis aktiv ist
                        fap := "Unit Price";
                        cWaehrung := "Currency Code";
                    END;
            END;
        END;
        //+GL008
    end;

    procedure FAPDatum(artikelnummer: Code[20]; KalkDatum: Date) dFAP: Decimal
    var
        ArtVKPreis: Record "7002";
        recCurrencyExchangeRate: Record "330";
    begin
        //-GL013

        dFAP := 0;
        CLEAR(ArtVKPreis);
        WITH ArtVKPreis DO BEGIN

            SETFILTER("Item No.", artikelnummer);
            SETRANGE("Sales Type", ArtVKPreis."Sales Type"::"Customer Price Group");
            SETFILTER("Sales Code", '1FAP');
            SETFILTER("Starting Date", '..' + FORMAT(KalkDatum));
            IF FINDLAST THEN
                dFAP := "Unit Price"   //aktiven Preis zum Datum gefunden
            ELSE BEGIN
                //Keinen Preis gefunden, alternativ den ältesten nehmen
                SETRANGE("Starting Date");
                IF FINDFIRST THEN
                    dFAP := "Unit Price"
            END;

            IF COUNT > 0 THEN BEGIN
                IF "Currency Code" <> '' THEN BEGIN
                    CLEAR(recCurrencyExchangeRate);
                    recCurrencyExchangeRate.SETRANGE("Currency Code", "Currency Code");
                    recCurrencyExchangeRate.SETFILTER("Starting Date", '..' + FORMAT(KalkDatum));
                    IF recCurrencyExchangeRate.FINDLAST THEN
                        dFAP := ROUND("Unit Price" / recCurrencyExchangeRate."Exchange Rate Amount", 0.00001);  //Mit Tageskurs des Kalkulationsdatums in EUR umrechnen
                END;
            END;

        END;

        //+GL013
    end;

    procedure HKLosgroesse(artikelnummer: Code[20]) Losgroesse: Decimal
    var
        ArtVKPreis: Record "7002";
    begin
        //-GL014
        Losgroesse := 0;
        CLEAR(ArtVKPreis);
        WITH ArtVKPreis DO BEGIN
            SETFILTER("Item No.", artikelnummer);
            SETRANGE("Sales Type", ArtVKPreis."Sales Type"::"Customer Price Group");
            SETFILTER("Sales Code", '9HK');
            IF FINDLAST THEN BEGIN
                Losgroesse := "Minimum Quantity";  //Mindestmenge bei 9HK als Losgrößenfeld benutzen
            END;
        END;
        //+GL014
    end;

    procedure GK(artikelnummer: Code[20]) hk: Decimal
    var
        ArtVKPreis: Record "7002";
    begin
        //-GL015
        hk := 0;
        CLEAR(ArtVKPreis);
        WITH ArtVKPreis DO BEGIN
            SETFILTER("Item No.", artikelnummer);
            SETRANGE("Sales Type", ArtVKPreis."Sales Type"::"Customer Price Group");
            SETFILTER("Sales Code", '8GK');
            SETRANGE("Currency Code", '');
            IF FIND('+') THEN
                hk := "Unit Price";

            //ATS umrechnung nicht mehr notwendig
            /*
            END ELSE BEGIN
              SETRANGE("Currency Code",'ATS');
              IF FIND('+') THEN
                hk := ROUND("Unit Price" / 13.7603,0.00001);
            END;
            */

        END;
        //+GL015

    end;

    procedure CreateDim(cNo: Code[20])
    var
        recVorgabeDim: Record "352";
        recDim: Record "349";
    begin

        //-GL016
        //Dimension  zuweisen      (Dimension muss vorhanden sein!)
        IF COMPANYNAME = 'GL-PHARMA' THEN BEGIN
            CLEAR(recVorgabeDim);
            recVorgabeDim.SETRANGE("Table ID", 27);
            recVorgabeDim.SETRANGE("No.", cNo);
            recVorgabeDim.SETRANGE("Dimension Code", 'TYP');
            recVorgabeDim.SETRANGE("Dimension Value Code", 'ARTIKEL');
            IF NOT recVorgabeDim.FINDFIRST THEN BEGIN
                //Noch keine zuweisung Vorhanden
                CLEAR(recVorgabeDim);
                recVorgabeDim.INIT;
                recVorgabeDim."Table ID" := 27;
                recVorgabeDim."No." := cNo;
                recVorgabeDim."Dimension Code" := 'TYP';
                recVorgabeDim."Dimension Value Code" := 'ARTIKEL';
                IF recVorgabeDim.INSERT(TRUE) = FALSE THEN
                    MESSAGE('Dimension Zuweisung %1 konnte nicht angelegt werden!', cNo);
            END;
        END;
        //+GL016
    end;

    procedure DeleteDim(cNo: Code[20])
    var
        recVorgabeDim: Record "352";
        recDim: Record "349";
    begin

        //-GL016
        //Dimension löschen
        IF COMPANYNAME = 'GL-PHARMA' THEN BEGIN
            CLEAR(recVorgabeDim);
            recVorgabeDim.SETRANGE("Table ID", 27);
            recVorgabeDim.SETRANGE("No.", cNo);
            recVorgabeDim.SETRANGE("Dimension Code", 'TYP');
            recVorgabeDim.SETRANGE("Dimension Value Code", 'ARTIKEL');
            IF recVorgabeDim.FINDFIRST THEN BEGIN
                IF recVorgabeDim.DELETE = FALSE THEN
                    MESSAGE('Dimension Zuweisung %1 konnte nicht gelöscht werden!', cNo);
            END;
        END;
        //+GL016
    end;

    procedure LagerstandProduktionVorOrt(itemno: Code[20]) lagerstand: Decimal
    var
        recitem: Record "27";
        recManufacturingSetup: Record "99000765";
    begin
        //-GL017
        IF recitem.GET(itemno) THEN BEGIN
            IF recManufacturingSetup.GET(recitem."Site Manufacturing") THEN;
            recitem.SETFILTER("Location Filter", recManufacturingSetup.LagerbestandProduktionVorOrt);
            recitem.CALCFIELDS(recitem.Inventory);
            lagerstand := recitem.Inventory;
        END;
        //+GL017
    end;

    /*procedure GetSerialisierungsdaten(var bSerialization: Boolean; var bDM2dCode: Boolean; var bPrint: Boolean)
    var
        recSeri: Record "50025";
        recBOMLine: Record "99000772";
        recBOMHeader: Record "99000771";
        recItem: Record "27";
        bBreak: Boolean;
    begin
        //-GL019
        //Ermitteln von Serialisierungsdaten zu Fertigartikel und Stücklistenartikeln

        CLEAR(recSeri);


        //Defaultwerte
        bSerialization := FALSE;
        bDM2dCode := FALSE;
        bPrint := FALSE;
        bBreak := FALSE;


        //Fertigartikel
        IF Artikelart = Artikelart::Fertigprodukt THEN
            IF recSeri.GET("No.") THEN
                IF recSeri.Status = recSeri.Status::Zertifiziert THEN BEGIN
                    bSerialization := recSeri.serialization;
                    bDM2dCode := recSeri."2d";
                    bPrint := recSeri.print;
                END;


        //Faltschachteln
        IF (Artikelart = Artikelart::Verpackungsstoff) AND ("Statistikcode II" = '1040') THEN BEGIN
            //Zertifizierte Stücklisten mit dieser FS suchen
            CLEAR(recBOMLine);
            CLEAR(recBOMHeader);
            recBOMLine.SETRANGE(Type, recBOMLine.Type::Item);
            recBOMLine.SETRANGE("No.", Rec."No.");
            IF recBOMLine.FINDFIRST THEN
                REPEAT
                    IF recBOMHeader.GET(recBOMLine."Production BOM No.") THEN
                        IF recBOMHeader.Status = recBOMHeader.Status::Certified THEN BEGIN
                            //Artikeln mit dieser Stückliste suchen
                            recItem.SETRANGE("Production BOM No.", recBOMHeader."No.");
                            recItem.SETRANGE(Blocked, FALSE);
                            IF recItem.FINDFIRST THEN
                                REPEAT
                                    IF recSeri.GET(recItem."No.") THEN
                                        IF recSeri.Status = recSeri.Status::Zertifiziert THEN BEGIN
                                            //Wenn schon einmal ein Typ gesetzt ist, nicht mehr abhaken lassen (Bei mehreren Artikeln reicht z.B. wenn einer Serialisiert wird)
                                            IF recSeri.serialization = TRUE THEN bSerialization := recSeri.serialization;
                                            IF recSeri."2d" = TRUE THEN bDM2dCode := recSeri."2d";
                                            IF recSeri.print = TRUE THEN bPrint := recSeri.print;
                                            IF bSerialization AND bDM2dCode AND bPrint THEN bBreak := TRUE;  //Mehr gesetzt kann nicht werden
                                        END;
                                UNTIL (recItem.NEXT = 0) OR (bBreak = TRUE);
                        END;
                UNTIL (recBOMLine.NEXT = 0) OR (bBreak = TRUE);
        END;

        //+GL019
    end;

   
    procedure GetArtikelHersteller() tReturnHersteller: Text
    var
        recAHK: Record "50093";
        tHelp: Text;
        cuCodesammlung: Codeunit "50500";
    begin
        //-GL020
        //Hersteller in der Artikel/Herstellerkarte in einen Text zusammensetzen und zurückliefern
        tReturnHersteller := '';
        tHelp := '';


        CLEAR(recAHK);
        recAHK.SETRANGE(Artikelnr, Rec."No.");
        recAHK.SETRANGE(Status, recAHK.Status::Frei);
        IF recAHK.FINDFIRST THEN
            REPEAT
                IF recAHK.HerstellerNr > '' THEN
                    IF cuCodesammlung.IsTextInTextTeil(tHelp, ';', recAHK.HerstellerNr) = FALSE THEN BEGIN   //Hersteller nicht doppelt eintragen
                        tReturnHersteller += recAHK.HerstellerNr + ', ';
                        tHelp += recAHK.HerstellerNr + ';';
                    END;
            UNTIL recAHK.NEXT = 0;

        IF STRLEN(tReturnHersteller) > 0 THEN
            tReturnHersteller := COPYSTR(tReturnHersteller, 1, STRLEN(tReturnHersteller) - 2);
        //+GL020
    end;
    */


}

