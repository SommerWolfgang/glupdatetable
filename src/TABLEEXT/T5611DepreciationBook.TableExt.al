tableextension 50051 T5611DepreciationBook extends "Depreciation Book"
{
    // Petsch: Feld "Afa vom Wiederbeschaffungswert rechnen" -> für kalkulatorische AfA
    // 22.3.2005 Indexierung unter Null zulassen
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 
    // 
    // 1) Tabellenspalten übernommen
    // 2) Feld "KORE Integration Depreciation" hinzugefügt (KORE integration)
    // 3) Feld "Blocked" hinzugefügt -> Wenn gesetzt bei der übernahme zu einer Anlage sperren
    // 
    // ------------------------------------------------------------------------------------------------------------------------------------
    // Datum      | Autor   | Status     | Beschreibung
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-02-19 | MFU     | ok         | Update von 360
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-09-14 | MFU     | ok         | Feld "Afa bis doppelte Nutzungsdauer" eingebaut (Reisenhofer)
    // ------------------------------------------------------------------------------------------------------------------------------------
    fields
    {
        field(50000; "Afa von Wiederbeschaffungswert"; Boolean)
        {
            Description = 'Petsch';
        }
        field(50001; "Indexierung unter 0 zulassen"; Boolean)
        {
            Description = 'Petsch';
        }
        field(50002; "Force AFA below Zero"; Boolean)
        {
            Description = 'Petsch';
        }
        field(50003; "KORE Integration Depreciation"; Boolean)
        {
            Caption = 'G/L Integration - Depreciation';
            Description = 'MFU';
        }
        field(50004; Blocked; Boolean)
        {
            Caption = 'Gesperrt';
            Description = 'MFU';
        }
        field(50005; "Afa bis doppelte Nutzungsdauer"; Boolean)
        {
            Description = 'MFU';
        }
    }
}
