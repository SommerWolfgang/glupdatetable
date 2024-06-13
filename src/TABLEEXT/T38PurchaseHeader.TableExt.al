tableextension 50014 T38PurchaseHeader extends "Purchase Header"
{// version NAVW114.46,NAVDACH14.46,TODOPBA

    // 
    // LAN001 12.11.09 ACPSS LAN1.00
    //   New Fields: ID 50500 - 50507, 51075
    //   Valutadatum berechnen (teilweise übernommen)
    // LAN002 21.12.09 ACPSS LAN1.00
    //   Externe Rahmennr.
    // LAN003 21.12.09 ACPSS LAN1.00
    //   Bestellstatus prüfen
    // LAN004 21.12.09 ACPSS LAN1.00
    //   Bestelladressen ermitteln
    // LAN005 21.12.09 ACPSS LAN1.00
    //   Ermittlung Lieferwoche
    // 
    // GL001 Vorbelegungen
    //       Einkäufer aus User ermitteln, Einkäufer aus Kreditor nur wenn leer
    // GL002 EK-LiefBemerkung
    // GL003 Key Expected Receipt Date,Buy-from Vendor No.,No.
    // GL004 Feld Status editable=yes, ruft release/open Funktionen auf
    // 
    // FetchInteralEDI ausgebaut
    // DUV/DAV ausgebaut
    // 
    // 
    // Datum      | Autor   | Status     | Beschreibung
    // --------------------------------------------------------------------------------------------------------
    // 2010-02-09 | Petsch  | ok         | Update von 3.60
    // --------------------------------------------------------------------------------------------------------
    // 2015-09-02 | MFU     | ok         | GL005 - Fehlende Valutadatum Zuweisung eingebaut (Wegen Fehler bei Fälligkeitsdatum Berechnen)
    // --------------------------------------------------------------------------------------------------------
    // 2016-03-04 | MFU     | ok         | GL006 - Zu lange Benutzername für Einkäufercode abschneiden  (von 20 auf 10 Zeichen verringern)
    // --------------------------------------------------------------------------------------------------------
    // 2016-07-07 | MFU     | ok         | GL007 - Bemerkungsmeldung bei Bestellanlage zu Kreditor anzeigen
    // --------------------------------------------------------------------------------------------------------
    // 2016-11-29 | MFU     | ok         | EinAusFuhrBewilligungsNr Spalte eingebaut
    // --------------------------------------------------------------------------------------------------------
    // 2016-12-07 | MFU     | ok         | GL008 - Bestellungen in MEPIS löschen
    // --------------------------------------------------------------------------------------------------------
    // 2017-01-23 | MFU     | ok         | SMVerwendungszweck Spalte eingebaut
    // --------------------------------------------------------------------------------------------------------
    // 2017-02-19 | PRA     | ok         | GL009 Filter Zuständigkeitseinheitencode zum wählen einblenden (Fr. Bindeus benötigt Zugriff aus Lannacher Bestellungen)
    // --------------------------------------------------------------------------------------------------------
    // 2017-09-04 | MFU     | ok         | GL010 Felder für Intrastatmeldung vorbelegen
    // --------------------------------------------------------------------------------------------------------
    // 2017-08-25 | MFU     | ok         | GL011 Transportversicherung einbau
    // --------------------------------------------------------------------------------------------------------
    // 2017-10-24 | MFU     | ok         | GL012 Löschen in MEPIS erst nachdem im NAV gelöscht wurde
    // --------------------------------------------------------------------------------------------------------
    // 2017-11-06 | MFU     | ok         | GL013 Fehler zu GL012 Korrigiert  (Leere Rechnungen konnten nicht gelöscht werden)
    // --------------------------------------------------------------------------------------------------------
    // 2018-07-16 | MFU     | ok         | GL014 Lieferung an Schenker
    // --------------------------------------------------------------------------------------------------------
    // 2018-08-07 | MFU     | ok         | GL015 Neue Funktion für gew Lieferwoche ermittlung
    // --------------------------------------------------------------------------------------------------------
    // 2019-01-07 | MFU     | ok         | GL016 Bestellung Abgeschlossen senden auch erst am Ende des Bestellung löschen
    // --------------------------------------------------------------------------------------------------------
    // 
    // 
    // HF21Einbau, 11.8.2015
    // InitDefaultDim() gibt es nicht mehr
    // 
    // WD001 17.05.11 ACPWF WD10.00
    //   New Fields: "Barcode No.", "Applies-to Pool Entry No."
    //   New Textconstant: Text1043880

    fields
    {
        field(50000; PrintSignature; Boolean)
        {
            Caption = 'PrintSignature';
            Description = 'Petsch';
        }
        field(50001; "Auftragsbestätigung"; Date)
        {
            Description = 'Petsch';
        }
        field(50002; "Auftragsbest. andrucken"; Boolean)
        {
            Caption = 'Print order confirmation';
            Description = 'Rieder';
        }
        field(50500; "Externe Rahmennr."; Code[20])
        {
            Description = 'LAN1.00';
        }
        field(50501; Abrufdatum; Date)
        {
            Description = 'LAN1.00';
        }
        field(50502; Valutadatum; Date)
        {
            Description = 'LAN1.00';

            trigger OnValidate()
            begin
                //-LAN001
                VALIDATE("Payment Terms Code");
                //+LAN001
            end;
        }
        field(50503; "KW verwenden"; Boolean)
        {
            Description = 'LAN1.00';
            InitValue = true;
        }
        field(50504; Bestellstatus; Option)
        {
            Description = 'LAN1.00';
            OptionMembers = " ",Versendet,Eingegangen;

            trigger OnValidate()
            var
                PurchLine: Record "39";
                codesammlung: Codeunit "50000";
            begin
                //-GL002
                IF Rec.Bestellstatus = Rec.Bestellstatus::Eingegangen THEN
                    IF xRec.Bestellstatus <> Rec.Bestellstatus THEN
                        codesammlung.EKLiefBemerkungsmeldung(Rec);
                //+GL002
            end;
        }
        field(50505; "Bezogen auf Rechnungsnr."; Code[20])
        {
            Description = 'LAN1.00';
            TableRelation = "Purch. Inv. Header" WHERE("Buy-from Vendor No." = FIELD("Buy-from Vendor No."));
        }
        field(50506; Spediteurcode; Code[10])
        {
            Description = 'LAN1.00';
            TableRelation = "Shipping Agent";
        }
        field(50507; Wertgutschrift; Boolean)
        {
            Description = 'LAN1.00';
        }
        field(50509; EinAusFuhrBewilligungsNr; Text[100])
        {
            Description = 'MFU';
        }
        field(50510; SMVerwendungszweck; Option)
        {
            Description = 'MFU';
            OptionMembers = " ","Import für Inlandsverbrauch","Import für Wiederausfuhr";
        }
        field(50511; Transportversicherung; Boolean)
        {
        }
        field(50512; MengeOffen; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Qty. to Receive" WHERE("Document Type" = FIELD("Document Type"),
                                                                       "Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(51075; "Rücklieferung"; Boolean)
        {
            Description = 'LAN1.00';
        }
        field(51076; Abgeschlossen; Boolean)
        {
            Description = 'Petsch';
        }
        field(51077; Gesperrt; Boolean)
        {
            Description = 'Petsch';
        }
        field(51078; GL; Boolean)
        {
            Description = 'Petsch';
        }
    }
    procedure HoleLieferwoche() Kalenderwoche: Integer
    begin
        //-LAN005
        IF "Expected Receipt Date" <> 0D THEN
            Kalenderwoche := DATE2DWY("Expected Receipt Date", 2);
        //+LAN005
    end;

    procedure SetTransportversicherungHakerl()
    var
        ShipmentMethod: Record "Shipment Method";
    begin

        //-GL011
        /*
        Transportversicherung := FALSE;
        IF Rec."Document Type"=Rec."Document Type"::Order THEN    //Nur bei Bestellungen Vorschlagen
          IF ShipmentMethod.GET("Shipment Method Code") THEN
            IF ShipmentMethod.Transportversicherung = TRUE THEN
              Transportversicherung := TRUE;
        //+GL011
        */
    end;

    procedure HoleGewuenschteLieferwoche() Kalenderwoche: Integer
    begin
        //-GL015
        IF "Requested Receipt Date" <> 0D THEN
            Kalenderwoche := DATE2DWY("Requested Receipt Date", 2);
        //+GL015
    end;

}
