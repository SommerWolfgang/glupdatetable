tableextension 50028 T79CompanyInformation extends "Company Information"
{
    fields
    {
        field(50000; "Bankkonto Zusatztext"; Text[100])
        {
            Description = 'Petsch';
        }
        field(50001; "Bankkonto 2"; Text[115])
        {
            Description = 'Petsch';
        }
        field(50002; "Bankkonto 3"; Text[115])
        {
            Description = 'Petsch';
        }
        field(50003; "Belegtext 1"; Text[200])
        {
            Description = 'Petsch';
        }
        field(50004; "Belegtext 2"; Text[200])
        {
            Description = 'Petsch';
        }
        field(50005; "ARA-Lizenznr"; Text[30])
        {
            Description = 'Petsch';
        }
        field(50006; Gerichtsstand; Text[30])
        {
            Description = 'Petsch';
        }
        field(50007; "Fax-EK"; Text[30])
        {
            Description = 'Petsch';
        }
        field(50008; "Fax-VK"; Text[30])
        {
            Description = 'Petsch';
        }
        field(50009; Vertriebsmandant; Text[30])
        {
            Description = 'Petsch';
            TableRelation = Company.Name;
        }
        field(50010; Produktionsmandant; Text[30])
        {
            Description = 'Petsch';
            TableRelation = Company.Name;
        }
        field(50011; Firmensitz; Text[250])
        {
            Description = 'Rieder';
        }
        field(50012; "Gen. Bus. Posting Group"; Code[10])
        {
            Description = 'Fürbaß';
        }
        field(50013; EORI; Code[20])
        {
            Description = 'Fürbaß';
        }
    }
}
