tableextension 50000 CustomerExtension extends Customer
{
    // GL001 Neuer Key: City, Name
    // GL002 Änderungsdatum+Benutzer mitschreiben, auch bei Insert
    // GL003 Funktion Ara-Infotext(), um auf Belegen die Entpflichtung anzudrucken j/n
    // 
    // ------------------------------------------------------------------------------------------------------------------------------------
    // Datum      | Autor   | Status     | Beschreibung
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-01-25 | MFU     | ok         | Update von 3.60
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-05-10 | MFU     | ok         | Feld "Verkäufercode 3" eingefügt
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2012-01-23 | MFU     | ok         | Feld "Betriebsnummer" eingefügt (Wunsch Wieser für Suchtgiftberichte)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2013-03-21 | MFU     | ok         | Feld "PDFRechnung" eingebaut für direkten PDF Versand aus Sammelrechnungsdruck
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2013-04-02 | MFU     | ok         | Feld "Rechnungspreisformat1000" eingefügt (Wunsch Reisenhofer für Exportrechnungen)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2013-05-06 | MFU     | ok         | Feld "Verkäufercode 6" eingefügt  (Wunsch Auinger)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2013-07-04 | MFU     | ok         | GL004 - Postleitzahl nach Lookup von Ort nicht überschreiben
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2013-08-01 | MFU     | ok         | Feld "MailBestellAdresse" für Mailbestellung über Grohändler
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-06-21 | MFU     | ok         | GL005 - ARA Infotext bei Mandant GL-DE leer lassen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-08-08 | PRA     | ok         | Feld "BTM-Nummer eingefügt
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2017-12-14 | MFU     | ok         | Liefertext 1 + 2 von 50 auf 80Zeichen erweiterz
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2018-11-07 | MFU     | ok         | "Adresse 3" hinzugefügt
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2019-02-12 | MFU     | ok         | Neuer ARA Text "Bonus Holsystem"
    // ------------------------------------------------------------------------------------------------------------------------------------

    fields
    {

        field(50001; "Lieferländercode"; Code[10])
        {
            Description = 'LAN1.00';
            TableRelation = "Country/Region";
        }
        field(50002; "Verkäufercode 2"; Code[10])
        {
            Caption = 'Salesperson Code 2';
            Description = 'Pranter';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50003; "SG-Bezug"; Boolean)
        {
            Description = 'Pranter';
        }
        field(50004; "PSY-Bezug"; Boolean)
        {
            Description = 'Pranter';
        }
        field(50005; "Shipment Copies"; Integer)
        {
            Caption = 'Shipment Copies';
            Description = 'Petsch';
        }
        field(50006; "Modified by"; Code[50])
        {
            Caption = 'Korrigiert durch';
            Description = 'Petsch';
            Editable = false;
        }
        field(50007; Association; Code[10])
        {
            Caption = 'Verband';
            Description = 'Rieder';
            TableRelation = DropDownContent.ID WHERE(Tabelle = CONST(18),
                                                      Feld = FILTER('ASSOCIATION'));
        }
        field(50008; InternerDatenaustausch; Boolean)
        {
            Description = 'Petsch';
        }
        field(50009; EDIZielNr; Code[20])
        {
            Description = 'Petsch';
        }
        field(50010; "ARA-entpflichtet"; Boolean)
        {
            Description = 'Petsch';
        }
        field(50011; "No. 2"; Code[20])
        {
            Description = 'Petsch';
        }
        field(50012; "Verkäufercode 3"; Code[10])
        {
            Caption = 'Salesperson Code 3';
            Description = 'MFU';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50013; Betriebsnummer; Code[10])
        {
        }
        field(50014; PDFRechnung; Boolean)
        {
            Description = 'MFU';
        }
        field(50015; Rechnungspreisformat1000; Boolean)
        {
            Description = 'MFU';
        }
        field(50016; "Verkäufercode 4"; Code[10])
        {
            Caption = 'Salesperson Code 3';
            Description = 'MFU';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50017; MailBestellAdresse; Text[50])
        {
            Description = 'MFU';
        }
        field(50018; "Verkäufercode 5"; Code[10])
        {
            Caption = 'Verkäufercode SOU';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50019; "BTM No."; Code[10])
        {
            Caption = 'BtM-Nummer';
            Description = 'PRA';
        }
        field(50023; "Address 3"; Text[50])
        {
            Caption = 'Adresse 3';
            Description = 'MFU';
        }
        field(50024; "SN deaktivieren"; Boolean)
        {
        }
        field(50601; Sammelrechnungstyp; Option)
        {
            Description = 'LAN1.00';
            OptionMembers = "Pro Auftrag","Pro Tag",ProWoche,"Pro Monat";
        }
        field(50602; "Customer Group Code"; Code[10])
        {
            Caption = 'Customer Group Code';
            Description = 'LAN1.00';
            TableRelation = CCUGroups.Gruppe WHERE(Typ = CONST(Debitor));
        }
        field(50603; "Lieferungstext 1"; Text[80])
        {
            Description = 'LAN1.00';
        }
        field(50604; "Lieferungstext 2"; Text[80])
        {
            Description = 'LAN1.00';
        }
        field(50605; "Carry off goods"; Boolean)
        {
            Caption = 'Ware abtragen';
            Description = 'Rieder';
        }
        field(50606; Abstellgenehmigung; Boolean)
        {
            Description = 'Petsch';
        }
        field(50607; Abstellort; Text[30])
        {
            Description = 'Petsch';
        }
    }
    trigger OnInsert()
    begin
        //-GL002
        "Last Date Modified" := TODAY;
        //Get string from USERID
        "Modified by" := CopyStr(USERID, 1, StrLen((USERID)));
        //+GL002
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := TODAY;
        //-GL002
        "Modified by" := CopyStr(USERID, 1, StrLen((USERID)));
        //+GL002
    end;



}
