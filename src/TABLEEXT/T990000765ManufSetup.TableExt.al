tableextension 50033 T99000765ManufSetup extends "Manufacturing Setup"
{// GL001 Felder
    // Feld "Backend Due Date" eingefügt. Komponentenfälligkeit wird dann der Fälligkeit des zu fertigenden Produkts gleichgesetzt.
    // GL002: Primärschlüssel editable, DataCaption (für Setup-Record je Standort)
    // 
    // Datum      | Autor   | Status     | Beschreibung
    // --------------------------------------------------------------------------------------------------------
    // 2010-01-15 | Petsch  | OK         | Update von 3.60
    // --------------------------------------------------------------------------------------------------------
    // 2010-09-14 | Petsch  | OK         | GL002: Primärschlüssel editable, DataCaption (für Setup-Record je Standort)
    // --------------------------------------------------------------------------------------------------------
    // 2010-10-22 | MFU     | OK         | Spate "dtWartungAngelegt" für Wartungsaufträge erstellen angelegt (Nur 1x pro Tag)
    // --------------------------------------------------------------------------------------------------------
    // 2010-12-03 | Petsch  | OK         | Feld Rohstoffchargennummern, PfadProbenEtiketten
    // --------------------------------------------------------------------------------------------------------
    // 2011-01-28 | Petsch  | OK         | Feld ProbenEtikettenDrucker, Probenetikettenpreview
    // --------------------------------------------------------------------------------------------------------
    // 2011-02-08 | Petsch  | OK         | Feld Lagerbestand vor Ort Filter
    // --------------------------------------------------------------------------------------------------------
    // 2012-04-11 | MFU     | OK         | Spate "dtWartungPruefmittelAngelegt" für Wartungsaufträge erstellen angelegt (Nur 1x pro Tag)
    // --------------------------------------------------------------------------------------------------------
    // 2013-02-05 | MFU     | OK         | Spate "PfadUmpackprotokoll" angelegt (Für eigene FA-Art)
    // --------------------------------------------------------------------------------------------------------
    // 2014-04-23 | Petsch  | ok         | Update von 2009 auf 2013R2
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2015-11-20 | MFU     | ok         | ChargenFreigabeLegende für Legende in Chargenfreigebe
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-09-16 | MFU     | ok         | Spalte "Materialgemeinkosten3_7EPMGK" eingebaut
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2017-04-10 | MFU     | ok         | Spalte "PfadPalettenetiketten" eingebaut
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2017-06-14 | MFU     | ok         | Spalte "LagerbestandProduktionVorOrt" eingebaut
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2018-08-17 | DKO     | ok         | Spalte "CmrLastUpdate" hinzugefügt.
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2019-01-14 | MFU     | ok         | 3 Spalten "var Gemainkosten" dazu.
    // ------------------------------------------------------------------------------------------------------------------------------------
    fields
    {
        field(50010; Vorratslager; Text[30])
        {
        }
        field(50011; Produktionslager; Text[30])
        {
            Description = 'Petsch';
            TableRelation = Location.Code;
        }
        field(50014; Materialgemeinkostensatz; Decimal)
        {
            Description = 'Petsch';
        }
        field(50015; Fertigungsgemeinkostensatz; Decimal)
        {
            Description = 'Petsch';
        }
        field(50016; SchwundBulk; Decimal)
        {
            Description = 'Petsch';
        }
        field(50017; SchwundFertigware; Decimal)
        {
            Description = 'Petsch';
        }
        field(50018; Verpackungsgemeinkosten; Decimal)
        {
            Description = 'Petsch';
        }
        field(50019; PfadHerstellprotokoll; Text[150])
        {
            Description = 'Petsch';
        }
        field(50020; "Belegnr. ist Ch-Nr."; Boolean)
        {
            Description = 'Petsch';
        }
        field(50021; PfadKonfektionierungsprotokoll; Text[150])
        {
            Description = 'Petsch';
        }
        field(50022; HerstellprotokollDirektDrucken; Boolean)
        {
            Description = 'Petsch';
        }
        field(50023; Materialgemeinkosten2; Decimal)
        {
            Description = 'Petsch';
        }
        field(50024; Fertigungsgemeinkosten2; Decimal)
        {
            Description = 'Petsch';
        }
        field(50025; Verpackungsgemeinkosten2; Decimal)
        {
            Description = 'Petsch';
        }
        field(50026; LetzteChargenNr; Integer)
        {
            Description = 'Petsch';
            MaxValue = 999;
            MinValue = 0;
        }
        field(50027; Chargennummernsystem; Option)
        {
            Description = 'Petsch';
            OptionMembers = Lannacher,Gerot;
        }
        field(50028; "Verp.-Schwundklasse 1"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50029; "Verp.-Schwundklasse 1 von"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50030; "Verp.-Schwundklasse 1 bis"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50031; "Verp.-Schwundklasse 2"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50032; "Verp.-Schwundklasse 2 von"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50033; "Verp.-Schwundklasse 2 bis"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50034; "Verp.-Schwundklasse 3"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50035; "Verp.-Schwundklasse 3 von"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50036; "Verp.-Schwundklasse 3 bis"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50037; "Verp.-Bulk-Schwundklasse 1"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50038; "Verp.-Bulk-Schwundklasse 1 von"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50039; "Verp.-Bulk-Schwundklasse 1 bis"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50040; "Verp.-Bulk-Schwundklasse 2"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50041; "Verp.-Bulk-Schwundklasse 2 von"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50042; "Verp.-Bulk-Schwundklasse 2 bis"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50043; "Verp.-Bulk-Schwundklasse 3"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50044; "Verp.-Bulk-Schwundklasse 3 von"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50045; "Verp.-Bulk-Schwundklasse 3 bis"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50050; "WaagePinVerschlüsselung"; Integer)
        {
            Description = 'Petsch';
            InitValue = 0;
            MaxValue = 10;
            MinValue = 0;
        }
        field(50051; "Backend Due Date"; Boolean)
        {
            Caption = 'Komponentenfälligkeit ist FA-Enddatum';
            Description = 'Petsch';
        }
        field(50052; Planungsauftragsnummer; Code[10])
        {
            Description = 'Petsch';
            TableRelation = "No. Series";
            ValidateTableRelation = false;
        }
        field(50053; "Verp.-Schwundklasse 4"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50054; "Verp.-Schwundklasse 4 von"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50055; "Verp.-Schwundklasse 4 bis"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50056; "Verp.-Schwundklasse 5"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50057; "Verp.-Schwundklasse 5 von"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50058; "Verp.-Schwundklasse 5 bis"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50059; FremdChargenNr; Code[20])
        {
            Description = 'Petsch';
            TableRelation = "No. Series".Code;
        }
        field(50060; FremdChNrProdBuchGruppe; Code[20])
        {
            Description = 'Petsch';
            TableRelation = "Gen. Product Posting Group".Code;
        }
        field(50061; PfadKartonetiketten; Text[150])
        {
            Description = 'Petsch';
        }
        field(50062; "Verp.-Bulk-Schwundklasse 4"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50063; "Verp.-Bulk-Schwundklasse 4 von"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50064; "Verp.-Bulk-Schwundklasse 4 bis"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50065; "Verp.-Bulk-Schwundklasse 5"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50066; "Verp.-Bulk-Schwundklasse 5 von"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50067; "Verp.-Bulk-Schwundklasse 5 bis"; Decimal)
        {
            Description = 'Petsch';
        }
        field(50068; dtWartungAngelegt; Date)
        {
            Description = 'MFU';
        }
        field(50069; Rohstoffchargennummern; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50070; PfadProbenEtiketten; Text[150])
        {
        }
        field(50071; ProbenetikettenDrucker; Text[150])
        {
        }
        field(50072; ProbenetikettenPreview; Boolean)
        {
        }
        field(50073; "Lagerbestand vor Ort Filter"; Code[50])
        {
        }
        field(50074; dtWartungPruefmittelAngelegt; Date)
        {
            Description = 'MFU';
        }
        field(50075; PfadKonfektionierungsFuellkont; Text[200])
        {
            Description = 'Petsch';
        }
        field(50076; PfadUmpackprotokoll; Text[200])
        {
            Description = 'MFU';
        }
        field(50077; PfadRohstoffPruefBericht; Text[200])
        {
        }
        field(50078; ChargenFreigabeLegende; BLOB)
        {
            SubType = Bitmap;
        }
        field(50079; Materialgemeinkosten3_7EPMGK; Decimal)
        {
            Description = 'MFU';
        }
        field(50080; PfadPalettenetiketten; Text[200])
        {
            Description = 'MFU';
        }
        field(50081; LagerbestandProduktionVorOrt; Code[40])
        {
            Description = 'MFU';
        }
        field(50082; CmrLastUpdate; DateTime)
        {
        }
        field(50083; "Variable-8GK HW-MGK"; Decimal)
        {
        }
        field(50084; "Variable-7EP HW-MGK"; Decimal)
        {
        }
        field(50085; "Variable-9HK HW-MGK"; Decimal)
        {
        }
    }
}
