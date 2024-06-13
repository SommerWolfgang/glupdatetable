tableextension 50019 T110SalesShipmentHeader extends "Sales Shipment Header"
{
    // version NAVW114.45,TODOPBA

    // -----------------------------------------------------
    // (c) gbedv, OPplus, All rights reserved
    // 
    // No.  Date       changed
    // -----------------------------------------------------
    // OPP  01.05.12   OPplus Granules
    //                 - New Field added
    // -----------------------------------------------------
    // 
    // 
    // LAN001 12.11.09 ACPSS LAN1.00
    //   New Fields: ID 50501, 50601, 52000
    // 
    // GL001 Belegwahl je nach Einstellung im Bericht
    //       Feld Firmenkopf
    // 
    // Datum      | Autor   | Status     | Beschreibung
    // --------------------------------------------------------------------------------------------------------
    // 2010-02-09 | Petsch  | ok         | Update von 3.60
    // ---------------------------------------------------------------------------------------------------------
    // 2012-05-29 | MFU     | ok         | Feld 50015 angelegt für übernehmen des Lieferkunden in die gebuchten Lieferungen
    // ---------------------------------------------------------------------------------------------------------
    // 2015-01-07 | MFU     | ok         | "Your Reference" von 35 auf 50 Zeichen erweitert
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-12-05 | MFU     | ok         | EinAusFuhrBewilligungsNr Spalte eingebaut
    // --------------------------------------------------------------------------------------------------------
    // 2017-01-12 | MFU     | ok         | Lieferungstext * Spalten eingebaut
    // --------------------------------------------------------------------------------------------------------
    // 2017-12-14 | MFU     | ok         | Lieferungstext Spalten auf 80 Zeichen erweitert
    // --------------------------------------------------------------------------------------------------------
    // 2018-05-07 | MFU     | ok         | WindreamPDF für Windream PDF erstellung (Anzahl Kopien) eingebaut
    // --------------------------------------------------------------------------------------------------------
    // 2018-07-16 | MFU     | ok         | StornoMitLiefNr eingebaut (für SG-Abrechnung)
    // --------------------------------------------------------------------------------------------------------
    // 2018-11-07 | MFU     | ok         | Feld Address 3 eingebaut
    // --------------------------------------------------------------------------------------------------------
    // 2019-01-09 | MFU     | ok         | GL045 -> Ein / Ausfuhrbew. Nr erweitert
    // --------------------------------------------------------------------------------------------------------
    // 2019-12-20 | MFU     | ok         | Betriebsnummern für SG-Abrechnung mitspeichern
    // --------------------------------------------------------------------------------------------------------
    fields
    {
        /*
        field(50005; Firmenkopf; Code[10])
        {
            Description = 'Fuerbass';
        }
        field(50012; Paketgewicht; Decimal)
        {
            Description = 'Petsch';
        }
        */
        field(50015; "Ship-to Customer No."; Code[20])
        {
            Caption = 'Lief. an Deb.-Nr.';
        }
        /*
        field(50016; "Customer_Search Name"; Code[250])
        {
            CalcFormula = Lookup(Customer."Search Name" WHERE("No." = FIELD("Sell-to Customer No.")));
            FieldClass = FlowField;
        }
        field(50019; "Lieferungstext 1"; Text[80])
        {
            Description = 'MFU';
        }
        field(50020; "Lieferungstext 2"; Text[80])
        {
            Description = 'MFU';
        }
        field(50021; WindreamPDF; Boolean)
        {
        }
        */
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
        /*
        field(50026; KundenBetriebsnummer; Code[10])
        {
            Description = 'MFU';
        }
        field(50027; GLBetriebsnummer; Code[10])
        {
            Description = 'MFU';
        }
        field(50028; KundenBetriebsnummerGH; Code[10])
        {
            Description = 'MFU';
        }
        field(50501; "Bill-to Code"; Code[10])
        {
            Caption = 'Bill-to Code';
            Description = 'LAN1.00';
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Bill-to Customer No."));
        }
        field(50504; StornoMitLiefNr; Code[150])
        {
        }
        field(50506; EinFuhrBewilligungsNr; Text[150])
        {
            Description = 'MFU';
        }
        field(50507; AusFuhrBewilligungsNr; Text[150])
        {
            Description = 'MFU';
        }
        field(50601; Sammelrechnungstyp; Option)
        {
            Description = 'LAN1.00';
            OptionMembers = "Pro Auftrag","Pro Tag",ProWoche,"Pro Monat";
        }
        field(52000; Musterlieferung; Boolean)
        {
            Description = 'LAN1.00';
        }
        */
    }
}
