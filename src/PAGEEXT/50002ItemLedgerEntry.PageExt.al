
//TASK50 TASK50.01 (CCU40)  15.03.2024  MFU:  Artikelstammfelder in Artikelposten, Wertposten mitbuchen 


pageextension 50002 "50002ItemLedgerEntry" extends "Item Ledger Entries"
{

    layout
    {
        addafter("Source No.")
        {

            // >> TASK50.01
            field("Statistikcode I"; Rec."Statistikcode I")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
                ToolTip = 'Artikelstamm Statistikcode zum Buchungszeitpunkt';
            }
            field("Statistikcode II"; Rec."Statistikcode II")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
                ToolTip = 'Artikelstamm Statistikcode zum Buchungszeitpunkt';
            }
            field("Statistikcode III"; Rec."Statistikcode III")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
                ToolTip = 'Artikelstamm Statistikcode zum Buchungszeitpunkt';
            }
            // << TASK50.01

        }

    }

}
