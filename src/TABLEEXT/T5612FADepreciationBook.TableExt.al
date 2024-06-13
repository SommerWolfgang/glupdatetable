tableextension 50052 T5612FADepreciationBook extends "FA Depreciation Book"
{
    // Petsch: FlowField: Kst-Aufteilungen
    // 
    // Datum      | Autor   | Status     | Beschreibung
    // ---------------------------------------------------------------------------------------------------------
    // 2005-11-14 | Petsch  | ok         | Änderung des Startdatums soll nicht Nutzungsdauer, sondern Enddatum mitändern!
    // ---------------------------------------------------------------------------------------------------------
    // 2006-03-06 | Petsch  | ok         | Flowfield Förderung eingebaut
    // ---------------------------------------------------------------------------------------------------------
    // 2006-10-19 | Petsch  | ok         | Flowfield Inbetriebnahmedatum eingebaut
    // ---------------------------------------------------------------------------------------------------------
    // 2009-12-29 | MFU     | ok         | Update 2009
    // 1) Tabellenspalten übernahme
    // 2) Sourcecode 001 - Feld Kontonr der Anlage je nach Auswahl befüllen
    // ---------------------------------------------------------------------------------------------------------
    // 2012-03-06 | MFU     | ok         | Flowfield Kostenstelle eingebaut - Wunsch Knieli
    // ---------------------------------------------------------------------------------------------------------
    fields
    {
        MODIFY("FA Posting Group")
        {
            trigger OnAfterValidate()
            var
                FASetup: Record "FA Setup";
                FixedAsset: Record "Fixed Asset";
            begin
                //-001
                FASetup.GET();
                IF FASetup.KontoNrLogik = FASetup.KontoNrLogik::"Anlagenbuchungsgruppe des Standard Afa-Buches" THEN
                    IF "Depreciation Book Code" = FASetup."Default Depr. Book" THEN BEGIN
                        FixedAsset.GET("FA No.");
                        FixedAsset."Kontonr." := CopyStr("FA Posting Group", 1, 10);
                        FixedAsset.MODIFY();
                    END;
                //+001
            END;
        }
        field(50000; "Kst-Aufteilungen"; Integer)
        {
            /*TODOPBA benötigt?
            CalcFormula = Count(AfaBuchKostenstelle WHERE(Anlagennr.=FIELD(FA No.),
                                                           Afa buchcode=FIELD(Depreciation Book Code)));
            FieldClass = FlowField;
            */
        }
        field(50001; "Förderung"; Text[30])
        {
            CalcFormula = Lookup("Fixed Asset".Förderung WHERE("No." = FIELD("FA No.")));
            FieldClass = FlowField;
        }
        field(50002; Inbetriebnahmedatum; Date)
        {
            /*TODOPBA benötigt?
            CalcFormula = Lookup("Fixed Asset". WHERE (No.=FIELD(FA No.)));
            FieldClass = FlowField;
            */
        }
        field(50003; Anlagenbezeichnung; Text[100])
        {
            CalcFormula = Lookup("Fixed Asset".Description WHERE("No." = FIELD("FA No.")));
            FieldClass = FlowField;
        }
        field(50004; Anlagenkostenstelle; Code[20])
        {
            CalcFormula = Lookup("Fixed Asset"."Global Dimension 1 Code" WHERE("No." = FIELD("FA No.")));
            FieldClass = FlowField;
        }
        field(50005; Gesperrt; Boolean)
        {
            CalcFormula = Lookup("Fixed Asset".Blocked WHERE("No." = FIELD("FA No.")));
            FieldClass = FlowField;
        }
        field(50006; Inaktiv; Boolean)
        {
            CalcFormula = Lookup("Fixed Asset".Inactive WHERE("No." = FIELD("FA No.")));
            FieldClass = FlowField;
        }
    }
}
