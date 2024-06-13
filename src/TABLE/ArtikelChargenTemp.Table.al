table 50012 ArtikelChargen_Temp
{
    Caption = 'ArtikelChargen_Temp';
    DataClassification = SystemMetadata;

    // version TODOPBA


    fields
    {
        field(1; User; Code[20])
        {
        }
        field(2; ItemNo; Code[20])
        {
        }
        field(3; LotNo; Code[20])
        {
        }
        field(4; Artikelart; Option)
        {
            OptionMembers = " ",Rohstoff,Halbfabrikat,Fertigprodukt,Verpackungsstoff,Arbeitsschritt;
        }
        field(5; "Statistikcode I"; Code[10])
        {
            TableRelation = Statistikcode2.Code WHERE(Ebene = CONST(1));
        }
        field(6; "Statistikcode II"; Code[10])
        {
            TableRelation = Statistikcode2.Code WHERE(Ebene = CONST(2));
        }
        field(7; "Statistikcode III"; Code[10])
        {
            TableRelation = Statistikcode2.Code WHERE(Ebene = CONST(3));
        }
        field(8; "SG/PSY"; Boolean)
        {
        }
        field(9; Produktbuchungsgruppe; Code[10])
        {
            TableRelation = "Gen. Product Posting Group";
            ValidateTableRelation = false;
        }
        field(10; ItemDescription; Text[50])
        {
        }
        field(11; ArtikelGesperrt; Boolean)
        {
        }
        field(12; bHideEntry; Boolean)
        {
            Caption = 'Artikel/Chargen Mit Lagerstand';
        }
        field(13; Lagerbuchungsgruppe; Code[10])
        {
            TableRelation = "Inventory Posting Group";
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(Key1; User, ItemNo, LotNo)
        {
        }
    }

    fieldgroups
    {
    }
}
