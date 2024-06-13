tableextension 50041 T279ExtendedTextHeader extends "Extended Text Header"
{// GL001 Felder: Transfer Order
    //       Feld "Table Name" um Option Purchase Text erweitert (für $Einkaufstexte)
    //       Form: drill down form gesetzt, flow-field: TextLines
    // GL002 Last Date Modified, modified by (weil ja alle Firmenbereiche auf die Textbausteine zugreifen)
    // 
    // Datum      | Autor   | Status     | Beschreibung
    // --------------------------------------------------------------------------------------------------------
    // 2010-01-26 | Petsch  | ok         | Update von 3.60
    // --------------------------------------------------------------------------------------------------------
    // 2016-07-25 | MFU     | ok         | Option in Spalte "Table Name" um "Purchase Text" erweitert
    // --------------------------------------------------------------------------------------------------------
    fields
    {
        field(50000; "Transfer Order"; Boolean)
        {
            Caption = 'Transfer Order';
            Description = 'Petsch';
        }
        field(50001; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Description = 'Petsch';
            Editable = false;
        }
        field(50002; "Modified by"; Text[20])
        {
            Description = 'Petsch';
            Editable = false;
        }
        field(50003; TextLines; Integer)
        {
            CalcFormula = Count("Extended Text Line" WHERE("Table Name" = FIELD("Table Name"),
                                                            "No." = FIELD("No."),
                                                            "Language Code" = FIELD("Language Code"),
                                                            "Text No." = FIELD("Text No.")));
            Description = 'Petsch';
            FieldClass = FlowField;
        }
        field(50004; Musterzugbemerkung; Boolean)
        {
            Description = 'Pranter';
            InitValue = false;
        }
    }
}
