tableextension 50030 T222ShipToAdress extends "Ship-to Address"
{
    // 
    // LAN001 25.11.09 ACPSS LAN1.00
    //   New Fields: ID 50500
    // 
    // ------------------------------------------------------------------------------------------------------------------------------------
    // Datum      | Autor     | Status     | Beschreibung
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2017-07-03 | MFU       | OK         | Betriebscode für Suchtgiftabrechnung hinzugefügt
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2018-05-30 | MFU       | OK         | BillToMailPrefer für VK-Rechnung Mailadressenauswahl hinzugefügt
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2018-11-07 | MFU       | OK         | Feld Address 3 hinzugefügt
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2019-10-15 | MFU       | OK         | Feld GrosshandelsBetriebscode für Suchtgiftabrechnung hinzugefügt
    // ------------------------------------------------------------------------------------------------------------------------------------
    fields
    {
        field(50000; "VAT Registration No."; Text[25])
        {
            Caption = 'VAT Registration No.';
            Description = 'CCU580';
        }
        field(50023; "Address 3"; Text[50])
        {
            Caption = 'Adresse 3';
        }
        field(50500; Type; Option)
        {
            OptionCaption = ' ,Shipment,Invoice';
            OptionMembers = " ",Shipment,Invoice;
        }
        field(50501; Betriebscode; Code[10])
        {
        }
        field(50502; BillToMailPrefer; Boolean)
        {
        }
        field(50503; GrosshandelsBetriebscode; Code[10])
        {
            Caption = 'Grosshandels Betriebscode';
        }
    }
}
