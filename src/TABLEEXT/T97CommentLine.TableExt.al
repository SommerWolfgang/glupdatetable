tableextension 50059 T97CommentLine extends "Comment Line"
{
    fields
    {
        // Meldung bei EK-Lieferung
        field(50000; "Meldung bei EK-Lieferung"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Petsch';
        }
        // Meldung in VK-Auftrag anzeigen
        field(50001; "Meldung in VK-Auftrag anzeigen"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'rieder';
        }
        // Meldung in Debitorenposten anzeigen
        field(50002; "Meldung in Debitorenposten anz"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'MFU';
        }
        // Meldung in Einkauf Rechnung anzeigen
        field(50003; "Meldung in Einkauf Rechnung an"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'MFU';
        }
        // Meldung in FA anzeigen
        field(50004; "Meldung in FA anzeigen"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'MFU';
        }
        // Meldung in Bestellung anzeigen
        field(50500; "Meldung in Bestellung anzeigen"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'LAN1.00';
        }
        // Meldung bei Umlagerung
        field(50501; "Meldung bei Umlagerung"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRA';
        }
    }
}
