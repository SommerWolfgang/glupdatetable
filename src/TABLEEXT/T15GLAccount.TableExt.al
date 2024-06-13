tableextension 50008 "T15 GL Account" extends "G/L Account"
{
    // version NAVW114.44,NAVDACH14.44,TODOPBA

    // -----------------------------------------------------
    // (c) gbedv, OPplus, All rights reserved
    // 
    // No.  Date       changed
    // -----------------------------------------------------
    // GLOE 01.11.08   Gen.Ledger Open Entries
    //                 - New Field added
    // TAX  01.04.12   Balance and Taxes
    //                 - New Fields added
    // -----------------------------------------------------
    // 
    // LAN001 12.11.09 ACPSS LAN1.00
    //   New Fields: ID 50002
    //   Kostenstellenaufteilung nur bei GuV-Konten
    // 
    // 
    // GL002 CostAccount mitumbenennen; Funktion KostenartErstellen()
    //       Flowfield Kst-Buchung auf T352-Dimensionscode Prüfung
    // 
    // GL003 Aufteilungscode mit Table Relation erweitert
    // 
    // ------------------------------------------------------------------------------------------------------------------------------------
    // Datum      | Autor   | Status     | Beschreibung
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-01-11 | MFU     | ok         | Update von 3.60
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2017-03-06 | MFU     | ok         | GL004 - Dimension handling
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2018-02-20 | DKO     | ok         | GL005 - Dimension handling - CompanyName Check CaseInsensitive gemacht
    // ------------------------------------------------------------------------------------------------------------------------------------

    fields
    {
        field(50002; Aufteilungscode; Code[10])
        {
            Description = 'KSAUF';

            trigger OnValidate()
            begin
                /*
                //-LAN001
                IF Aufteilungscode <> '' THEN
                  IF NOT ("Account Type" = "Account Type"::Posting)
                    OR NOT ("Income/Balance" = "Income/Balance"::"Income Statement")
                  THEN
                    ERROR(Text50000);
                //+LAN001
                */

            end;
        }
        field(50064; "Name 2"; Text[30])
        {
            Description = 'Petsch';
        }
        field(50065; "Bilanzziffer 1"; Code[5])
        {
            Description = 'Petsch';
        }
        field(50066; "Bilanzziffer 2"; Code[5])
        {
            Description = 'Petsch';
        }
        field(50067; "Bilanzziffer 3"; Code[5])
        {
            Description = 'Petsch';
        }
        /*
        field(50068; "Kst Buchung"; Enum '' )
        {
            CalcFormula = Lookup("Default Dimension"."Value Posting" WHERE (Table ID=CONST(15),
                                                                            No.=FIELD(No.)));
            FieldClass = FlowField;
            OptionCaption = ' ,Code Mandatory,Same Code,No Code';
            OptionMembers = " ","Code Mandatory","Same Code","No Code";

            trigger OnLookup()
            var
                DefaultDimension: Record "352";
            begin
                //-GL002
                DefaultDimension.SETRANGE("Table ID",15);
                DefaultDimension.SETRANGE("No.","No.");
                PAGE.RUN(PAGE::"Default Dimensions",DefaultDimension);
                //+GL002
            end;
        }
        */
        field(50069; "KORE relevant"; Boolean)
        {
            Description = 'MFU';
        }
    }
}
