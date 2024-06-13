tableextension 50010 "T23 Vendor" extends Vendor
{
    fields
    {
        field(50003; "Modified by"; Code[50])
        {
            Caption = 'Korrigiert durch';
            Description = 'Petsch';
            Editable = false;
        }
        field(50004; "E-MailAvis"; Text[80])
        {
            Description = 'MFU';
        }
        field(50010; "ARA-Lizenz"; Option)
        {
            Description = 'Rieder';
            OptionCaption = ' ,Ja,Nein';
            OptionMembers = " ",Ja,Nein;
        }
        field(50011; Betriebsnummer; Code[10])
        {
            Description = 'MFU';
        }
        field(50020; Bestellemail; Text[80])
        {
            Description = 'DKO';
        }

    }
}
