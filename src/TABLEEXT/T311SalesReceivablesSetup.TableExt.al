tableextension 50044 T311SalesReceivablesSetup extends "Sales & Receivables Setup"
{
    // LAN001 25.11.09 ACPSS LAN1.00
    //   New Fields: ID 50001 - 50003
    // 
    // 001 15.11.06 ACPWF
    //   New Fields: "Due Date Calculation", "Discount Date Calculation", "Reminder Terms Code"
    // #DOKU#
    // 
    // Pkt 001 nur wenn Sald.AbstimmGutschriftAktiv = true
    // 
    // GL001 Vorauswahl Auftrag-Buchen-Dialogbox
    // GL002 Feld StockoutWarningSales
    // 
    // 
    // Datum      | Autor   | Status     | Beschreibung
    // --------------------------------------------------------------------------------------------------------
    // 2010-02-05 | Petsch  | ok         | Update von 3.60
    // --------------------------------------------------------------------------------------------------------
    // 2014-02-26 | MFU     | ok         | GL003 - Spalte "EinzelrechnungMailAdressen" eingefügt für PDF-Rechnung Versenden
    // --------------------------------------------------------------------------------------------------------
    // 2018-02-05 | MFU     | ok         | GL004 - Spalte "EinzelrechnungMailAdressen2" eingefügt für PDF-Rechnung Versenden (250 Zeichen zu wenig)
    // --------------------------------------------------------------------------------------------------------
    fields
    {
        field(50000; VorauswahlAuftragBuchen; Option)
        {
            Description = 'Petsch';
            OptionMembers = " ",Liefern,Fakturieren,"Liefern und Fakturieren";
        }
        field(50001; "Due Date Calculation"; DateFormula)
        {
            Caption = 'Due Date Calculation';
            Description = 'LAN1.00';
        }
        field(50002; "Discount Date Calculation"; DateFormula)
        {
            Caption = 'Discount Date Calculation';
            Description = 'LAN1.00';
        }
        field(50003; "Reminder Terms Code"; Code[10])
        {
            Caption = 'Reminder Terms Code';
            Description = 'LAN1.00';
            TableRelation = "Reminder Terms";
        }
        field(50004; "Sald.AbstimmungGutschriftAktiv"; Boolean)
        {
            Description = 'Petsch';
        }
        field(50005; StockoutWarningOnlySales; Boolean)
        {
            Description = 'Petsch';
        }
        field(50006; EinzelrechnungMailAdressen; Text[250])
        {
            Description = 'MFU';
        }
        field(50007; EinzelrechnungMailAdressen2; Text[250])
        {
            Description = 'MFU';
        }
        field(50008; EinzelrechnungMailAdressen3; Text[250])
        {
            Description = 'MFU';
        }
    }
}
