tableextension 50049 T5600FixedAsset extends "Fixed Asset"
{

    // LAN001 02.12.09 ACPSS LAN1.00
    //   New Field: ID 50005
    // 
    // Pranter: Neue Keys:
    // FA Class Code,FA Subclass Code,Kontonr.
    // 
    // Petsch: Neue Keys:
    // FA Class Code,FA Subclass Code,No.
    // Kontonr.
    // Global Dimension 1 Code,FA Class Code,FA Subclass Code,No.
    // Bugfix: bei den 11000er Feldern war keine DEA Beschreibung
    // 
    // 1.3.2006, Petsch: Feld Förderung
    // 
    // ------------------------------------------------------------------------------------------------------------------------------------
    // Datum      | Autor   | Status     | Beschreibung
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2009-12-29 | MFU     | ok         | Update 2009
    // 1) Tabellenspalten Übernahme
    // 2) Übernahme Source 001 - Kontonummer aus der Anlagennr. herausschneiden
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-04-14 | MFU     | ok         | "Start of use Date auf Editable=TRUE gesetzt (Soll änderbar bei Anlage sein)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-04-13 | MFU     | ok         | Spalte "Raumbuchnr." eingefügt
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2011-10-25 | MFU     | ok         | Spalte "Raumnr." eingefügt
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2012-02-15 | MFU     | ok         | Spalte "Anschaffungskosten Steuerlich" eingefügt
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2013-04-03 | MFU     | ok         | Spalte "FA Posting Group Line" eingefügt (Flowfield mit Verweiß in Zeilen)
    // ------------------------------------------------------------------------------------------------------------------------------------

    fields
    {
        MODIFY("No.")
        {
            trigger OnAfterValidate()
            var
                FASetup: Record "FA Setup";
            begin
                //-001
                FASetup.GET();
                IF FASetup.KontoNrLogik = FASetup.KontoNrLogik::"5 Stellen der Anlagenr" THEN
                    "Kontonr." := COPYSTR("No.", 1, 5);
                //+001
            END;
        }
        field(50001; Menge; Decimal)
        {
            Description = 'Petsch';
        }
        field(50002; "Kontonr."; Text[10])
        {
            Description = 'Petsch';
        }
        field(50005; Miete; Boolean)
        {
            Caption = 'Miete';
            Description = 'LAN1.00';
        }
        field(50006; "Förderung"; Text[30])
        {
            Description = 'Petsch';
        }
        field(50007; "Raumbuchnr."; Text[30])
        {
        }
        field(50008; "Raumnr."; Text[30])
        {
        }
        field(50009; "Anschaffungskosten Steuerlich"; Decimal)
        {
            CalcFormula = Sum("FA Ledger Entry".Amount WHERE("FA Posting Type" = const("Acquisition Cost"),
                                                              "FA No." = FIELD("No."),
                                                              "Depreciation Book Code" = const('STEUERLICH')));
            FieldClass = FlowField;
        }
        field(50010; "Anschaffungskosten Betrieb"; Decimal)
        {
            CalcFormula = Sum("FA Ledger Entry".Amount WHERE("FA Posting Type" = CONST("Acquisition Cost"),
                                                               "FA No." = FIELD("No."),
                                                              "Depreciation Book Code" = CONST('BETRIEB')));
            FieldClass = FlowField;
        }
        field(50011; "Nutzungsdauer Steuerlich"; Decimal)
        {
            CalcFormula = Lookup("FA Depreciation Book"."No. of Depreciation Years" WHERE("FA No." = FIELD("No."),
                                                              "Depreciation Book Code" = CONST('STEUERLICH')));
            FieldClass = FlowField;
        }
        field(50012; "Nutzungsdauer Betrieb"; Decimal)
        {
            CalcFormula = Lookup("FA Depreciation Book"."No. of Depreciation Years" WHERE("FA No." = FIELD("No."),
                                                              "Depreciation Book Code" = CONST('BETRIEB')));
            FieldClass = FlowField;
        }
        field(50013; "FA Posting Group Line"; Code[20])
        {
            CalcFormula = Lookup("FA Depreciation Book"."FA Posting Group" WHERE("FA No." = FIELD("No.")));
            Caption = 'Anlagenbuchungsgruppe';
            FieldClass = FlowField;
        }
    }
}
