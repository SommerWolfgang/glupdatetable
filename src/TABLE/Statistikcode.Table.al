
table 50015 Statistikcode2
{
    Caption = 'Statistikcode';
    DataClassification = CustomerContent; //SystemMetadata;
    //LookupPageID = StatistikcodeList;
    //DrillDownPageID = StatistikcodeList;


    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Bezeichnung; Text[30])
        {
        }
        field(3; Ebene; Integer)
        {
        }
        field(4; "Gehört Zu"; Code[10])
        {
            TableRelation = Statistikcode2;
        }
        field(5; PM; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(6; Marketinglinie; Code[20])
        {

        }
        field(7; Wirkstoff; Code[30])
        {
        }
        field(8; Standort; Code[20])
        {
        }
        field(9; NichtInBCUebernehmen; Boolean)
        {
        }
        field(10; InNAVBCStatcode4; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Code", Ebene)
        {
        }
        key(Key2; Bezeichnung)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Bezeichnung)
        {
        }
    }

}
