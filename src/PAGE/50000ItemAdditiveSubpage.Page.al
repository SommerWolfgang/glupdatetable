
//TASK46  13.03.2024  MFU:  Artikel Zusatzinfo Subpage

page 50000 ItemAdditiveSubpage
{
    Caption = 'Artikel Zusatzinfo';
    PageType = CardPart;
    SourceTable = ItemAdditive;

    layout
    {
        area(content)
        {
            group(Zusatzinfo)
            {
                Caption = 'Item', comment = 'DEA="Artikel"';
                field("Wirkstärke"; Wirkstaerke)
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Wirkstärke';
                    //ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    //Visible = NoFieldVisible;
                }
                field("Darreichungsform"; Darreichungsform)
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Darreichungsform';
                    //ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    //Visible = NoFieldVisible;


                }

            }
        }
    }
}
