tableextension 50018 T98GeneralLedgerSetup extends "General Ledger Setup"
{
    // version NAVW114.45,NAVDACH14.45,TODOPBA

    // GL001 Felder bIncJnlBatchName, AllowNegativPurchInvoices
    //       "URL Latest Rates" (URL neueste Kurse) angelegt. Definiert die URL, wo das XML File
    //       für die Währungskurse downgeloadet werden kann.
    // 
    // ------------------------------------------------------------------------------------------------------------------------------------
    // Datum      | Autor   | Status     | Beschreibung
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-02-05 | Petsch  | ok         | Update von 3.60
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2013-08-01 | MFU     | ok         | Felder für PDF Zuestelladressen eingebaut
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-07-12 | MFU     | ok         | PDFPfadExport für eigenen Speicherort der Export PDF-Belege eingebaut
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-08-01 | MFU     | ok         | GL002 - Buchungszeitraum mit Kore-Buchungszeitraum synchronisieren  (OswaldH)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-09-14 | MFU     | ok         | ProjektRessBuchAb für Projektbuchungen vor Fibu Buchungszeitraum (OswaldH)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2017-02-08 | MFU     | ok         | PDFPfadAvis eingebaut
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2018-04-23 | DKO     | ok         | PDFPfadEK eingebaut für EK Bestellungen
    // ------------------------------------------------------------------------------------------------------------------------------------

    fields
    {
        field(50000; "URL Latest Rates"; Text[250])
        {
            Caption = 'URL Latest Rates';
            Description = 'Rieder';
        }
        field(50500; ArtikelBuchDatGrenze; Boolean)
        {
            Description = 'Petsch';
        }
        field(50501; IncJnlBatchName; Boolean)
        {
            Caption = 'Incr. no. in jnl. batch name';
            Description = 'Rieder';
        }
        field(50502; AllowNegativePurchInvoices; Boolean)
        {
            Description = 'Petsch';
        }
        field(50504; PDFPfad; Text[250])
        {
        }
        field(50505; PDFPfadGHBestellung; Text[250])
        {
        }
        field(50506; PDFPfadExport; Text[250])
        {
        }
        field(50507; ProjektRessBuchAb; DateFormula)
        {
            Description = 'MFU';
        }
        field(50508; PDFPfadAvis; Text[250])
        {
            Description = 'MFU';
        }
        field(50509; PDFPfadEK; Text[250])
        {
            Description = 'DKO';
        }
    }
}
