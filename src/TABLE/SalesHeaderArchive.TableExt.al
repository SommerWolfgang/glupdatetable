tableextension 50046 SalesHeaderArchive extends "Sales Header Archive"
{
    // LAN001 02.12.09 ACPSS LAN1.00
    //   New Fields: ID 50500, 50501, 50515, 50601, 50602, 51000, 52000
    // 
    // GL001 Flowfields Restmenge (Basis) und Packing Information eingebaut
    // 
    // ------------------------------------------------------------------------------------------------------------------------------------
    // Datum      | Autor   | Status     | Beschreibung
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-02-05 | Petsch  | ok         | Update von 3.60
    // ------------------------------------------------------------------------------------------------------------------------------------

    fields
    {
        field(50000; "shipment copies"; Integer)
        {
            Caption = 'Shipment Copies';
            Description = 'Petsch';
        }
        field(50001; "Preis Null"; Boolean)
        {
            Description = 'Petsch';
        }
        field(50002; "100% Zeilenrabatt"; Boolean)
        {
            Description = 'Petsch';
        }
        field(50003; "invoice copies"; Integer)
        {
            Caption = 'Invoice Copies';
            Description = 'Petsch';
        }
        field(50004; "Packing Information"; Integer)
        {
            //CalcFormula = Count("Packing Information" WHERE (Type=CONST('Order'),
            //                                                 "Document Type"=FIELD("Document Type"),
            //                                                 "Document No."=FIELD("No.")));
            //FieldClass = FlowField;
        }
        field(50005; Wertgutschrift; Boolean)
        {
            Description = 'LAN1.00';
        }
        field(50006; "Bill-to Code"; Code[10])
        {
            Caption = 'Bill-to Code';
            Description = 'LAN1.00';
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Bill-to Customer No."),
                                                          Type = FILTER(<> Shipment));
        }
        field(50007; Verkaufsstatistikcode; Code[10])
        {
            Description = 'LAN1.00';
        }
        field(50008; Sammelrechnungstyp; Option)
        {
            Description = 'LAN1.00';
            OptionMembers = "Pro Auftrag","Pro Tag",ProWoche,"Pro Monat";
        }
        field(50009; Auftragsstatus; Option)
        {
            Description = 'LAN1.00';
            OptionMembers = " ",Freigegeben,"In Kommission",Teillieferung,Geliefert;
        }
        field(50010; Etikettenanzahl; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'LAN1.00';
        }
        field(50011; "Restmenge (Basis)"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Outstanding Qty. (Base)" WHERE("Document Type" = FIELD("Document Type"),
                                                                            "Document No." = FIELD("No."),
                                                                            Type = CONST(Item)));
            FieldClass = FlowField;
        }
        field(50012; Musterlieferung; Boolean)
        {
            Description = 'LAN1.00';
        }
    }
}
