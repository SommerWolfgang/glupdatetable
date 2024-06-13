table 50011 "Rechnung Mailversand"
{
    Caption = 'Rechnung Mailversand';
    DataClassification = SystemMetadata;

    // version TODOPBA

    // 
    // Datum      | Autor   | Status     | Beschreibung
    // --------------------------------------------------------------------------------------------------------
    // 2013-03-21 | MFU     | Erstellt   |
    // ---------------------------------------------------------------------------------------------------------
    // 2016-06-29 | MFU     | OK         | Spalte "Responsibility Center" für Trennung Export / Inland eingebaut
    // ---------------------------------------------------------------------------------------------------------


    fields
    {
        field(1; "Invoice No"; Code[20])
        {
            Caption = 'Rechnungs Nr';
        }
        field(2; EMailEmpfaenger; Text[80])
        {
            Caption = 'EMail Empfaenger';
        }
        field(4; SendeDatum; DateTime)
        {
            Caption = 'Sende Datum';
        }
        field(5; Versendet; Boolean)
        {
            Caption = 'Versendet';
        }
        field(6; Buchungsdatum; Date)
        {
            Caption = 'Buchungsdatum';
        }
        field(7; RechKdnNr; Code[20])
        {
            CalcFormula = Lookup("Sales Invoice Header"."Bill-to Customer No." WHERE("No." = FIELD("Invoice No")));
            Caption = 'Rechnungs Kunden Nr';
            FieldClass = FlowField;
        }
        field(8; "Responsibility Center"; Code[10])
        {
            CalcFormula = Lookup("Sales Invoice Header"."Responsibility Center" WHERE("No." = FIELD("Invoice No")));
            Caption = 'Zuständigkeitseinheitencode';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Invoice No")
        {
        }
        key(Key2; EMailEmpfaenger, "Invoice No")
        {
        }
    }

    fieldgroups
    {
    }
}
