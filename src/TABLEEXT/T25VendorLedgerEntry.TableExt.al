tableextension 50034 T25VendorLedgerEntry extends "Vendor Ledger Entry"
{
    fields
    {
        field(50000; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            Description = 'LAN1.00';
        }
        field(50001; "Order Date"; Date)
        {
            Caption = 'Order Date';
            Description = 'LAN1.00';
        }
        field(50002; "Valuta Date"; Date)
        {
            Caption = 'Valuta Date';
            Description = 'LAN1.00';
        }
    }
}
