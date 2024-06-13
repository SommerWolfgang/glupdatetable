page 50003 "GLChargenfreigabe"
{
    CaptionML = ENU = 'GL Batch release', DEU = 'GL Chargenfreigabe';
    PageType = Worksheet;
    SourceTable = "Lot No. Information";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)   //Untergruppe für Darstellung der Felder untereinander und nicht nebeneinander
            {
                group(test)
                {
                    CaptionML = ENU = 'General', DEU = 'Allgemein';

                    field(Chargennr; "Lot No.")
                    {
                        ApplicationArea = All;
                        Editable = bEditable AND bEditableStatusAblaufDatum;
                        Style = StandardAccent;
                        StyleExpr = FarbeLotNo;

                        trigger OnValidate()
                        begin
                            IF xRec."Lot No." <> Rec."Lot No." THEN
                                IF NOT CONFIRM(TextLotChange, FALSE, xRec."Lot No.", Rec."Lot No.") THEN
                                    ERROR('Chargennummer wurde nicht umbenannt');

                            //Unsichtbarer Filter aendern
                            FILTERGROUP(2);
                            SETRANGE("Lot No.", "Lot No.");
                            FILTERGROUP(0);

                            SetChangeStatusFarben();
                        end;
                    }
                    field("Verkaufschargennr."; "Verkaufschargennr.")
                    {
                        ApplicationArea = All;
                        Editable = bEditable;

                    }
                    field("Expiration Date"; "Expiration Date")
                    {
                        ApplicationArea = All;
                        Editable = bEditable AND bEditableStatusAblaufDatum;

                        trigger OnValidate()
                        begin
                            IF NOT cuCodsammlung.AblaufDatumPlausibel("Item No.", "Expiration Date") THEN
                                ERROR('Ablaufdatum %1 ist nicht Plausibel', FORMAT(Rec."Expiration Date"));

                            SetChangeStatusFarben();
                        end;
                    }

                    field(Status; optGLStatus)
                    {
                        ApplicationArea = All;
                        Editable = bEditableStatusAblaufDatum;  //bEditable


                        trigger OnValidate()
                        begin
                            SetGLStatus();
                        end;
                    }
                    field(Freigabedatum; Freigabedatum)
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field(Freigabename; Freigabename)
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field(Lagerstand; Lagerstand)
                    {
                        Editable = false;
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            tempRecItemLedgerEntry: Record "32" temporary;
                        begin
                            tempRecItemLedgerEntry."Item No." := "Item No.";
                            tempRecItemLedgerEntry.SETRANGE("Item No.", "Item No.");
                            tempRecItemLedgerEntry.SETRANGE(Open, TRUE);
                            IF PAGE.RUNMODAL(PAGE::UmlagerInfoNeu, tempRecItemLedgerEntry) = ACTION::LookupOK THEN;
                        end;
                    }
                    field(Description; Description)
                    {
                        ApplicationArea = All;
                        Editable = bEditable;
                    }
                }
            }
        }
    }


    //Globale Variablen
    var
        StatusFarbe: Text;
        //cuNaviPharma: Codeunit 50506;
        recItem: Record 27;
        bLotNoEditable: Boolean;
        StatusFarbeLotNo: Text;
        recItemLedgEntry: Record 32;
        FarbeLotNo: Text;
        FarbeLiefCh: Text;
        FarbeAblaufDatum: Text;
        FarbeVKCh: Text;
        FarbeGehalt: Text;
        FarbeLabKommentar: Text;
        FarbeStatus: Text;
        FarbePackmittelVersion: Text;
        cText: Text;
        cInfoText: Text;
        bTestumgebung: Boolean;
        sTestumgebung: Text[50];
        bEditable: Boolean;
        recProdEinrichtung: Record "Manufacturing Setup";
        bTrendAnzeige: Boolean;
        iAnzahlChargenAnzeige: Integer;
        bIsHF: Boolean;
        optGLStatus: Option " ",QUARANTÄNE,FREI,GESPERRT;
        BacklogVisible: Boolean;
        GLStatusOld: Integer;
        bEditableStatusAblaufDatum: Boolean;
        ProdDateEditable: Boolean;
        bEditableProduktionskommentar: Boolean;
        bEditableEKChargeninfo: Boolean;
        bEditableLimsStatus: Boolean;
        //cuLims: Codeunit 50096;
        //recLotStatus: Record 5034621;
        GLStatusAuswahlOld: Code[20];
        cuCodsammlung: Codeunit CodesammlungGLDE;
        TextLotChange: TextConst DEU = 'Wollen Sie die Chargennummer von %1 in %2 umbenennen?', ENU = 'Would you change Lot from %1 to %2?';


    trigger OnOpenPage()
    begin

        sTestumgebung := '';
        bTestumgebung := FALSE;

        IF cuCodsammlung.IsTestEnvironment() THEN BEGIN
            sTestumgebung := 'Testumgebung';
            bTestumgebung := TRUE;
        END;

    end;

    trigger OnClosePage()
    begin
        SetGLStatus();
    end;


    trigger OnAfterGetRecord()
    var
        recItem: Record 27;
        cRechtText: Code[20];
    begin

        CLEAR(recItem);
        recItem.GET("Item No.");

        SetStatusFarbe();
        SetChangeStatusFarben();


        bEditableStatusAblaufDatum := FALSE;
        bEditable := FALSE;
        IF cuCodsammlung.Berechtigung('GL_CHARGEBEARBEITEN') = TRUE THEN
            bEditable := TRUE;

        IF bEditable = TRUE THEN BEGIN
            Rec.CALCFIELDS(Artikelart);
            IF Rec.Artikelart = Rec.Artikelart::Fertigprodukt THEN BEGIN

                IF (Rec.Status = Rec.Status::"Quarantäne") AND (cuCodsammlung.Berechtigung('$CHARGENFREIGABE') = TRUE) THEN  //ALT  //MFU 09.07.2021
                    bEditableStatusAblaufDatum := TRUE;

                IF cuCodsammlung.Berechtigung('$MARKTFREIGABE') = TRUE THEN
                    bEditableStatusAblaufDatum := TRUE;
            END ELSE BEGIN
                IF (cuCodsammlung.Berechtigung('$CHARGENFREIGABE') = TRUE) OR (cuCodsammlung.Berechtigung('$MARKTFREIGABE') = TRUE) THEN
                    bEditableStatusAblaufDatum := TRUE;
            END;
        END;

        optGLStatus := optGLStatus::" ";

        IF Rec.Status = Rec.Status::"Quarantäne" then
            optGLStatus := optGLStatus::"QUARANTÄNE";
        IF Rec.Status = Rec.Status::Frei then
            optGLStatus := optGLStatus::FREI;
        IF Rec.Status = Rec.Status::Gesperrt then
            optGLStatus := optGLStatus::GESPERRT;

        GLStatusOld := optGLStatus;


        //UpdateBacklogVisibility(); //  CCU109.01
        //SetProdOrderEditable("Item No.", ProdDateEditable); 

    end;


    LOCAL PROCEDURE SetGLStatus();
    BEGIN

        IF optGLStatus <> GLStatusOld THEN BEGIN
            CASE optGLStatus OF
                optGLStatus::FREI:
                    BEGIN
                        Rec.Status := Rec.Status::Frei;
                        GLStatusOld := optGLStatus;
                    END;
                optGLStatus::GESPERRT:
                    BEGIN
                        Rec.Status := Rec.Status::Gesperrt;
                        GLStatusOld := optGLStatus;
                    END;
                optGLStatus::"QUARANTÄNE":
                    BEGIN
                        Rec.Status := Rec.Status::"Quarantäne";
                        GLStatusOld := optGLStatus;
                    END;
            END;
        END;


        //cuLims.UpdateBacklog(Rec,Rec.FIELDNO(Status),Rec.Status);

    END;



    PROCEDURE SetStatusFarbe();
    BEGIN
        //Statusfarbe setzen
        StatusFarbe := 'Standard';
        IF Rec.Status = Rec.Status::Gesperrt THEN
            StatusFarbe := 'Attention';
        IF Rec.Status = Rec.Status::Frei THEN
            StatusFarbe := 'Favorable';
    END;

    PROCEDURE SetChangeStatusFarben();
    BEGIN
        //Farben der Eingabefelder zentral setzen

        FarbeLotNo := 'Standard';
        FarbeLiefCh := 'Standard';
        FarbeAblaufDatum := 'Standard';
        FarbeVKCh := 'Standard';
        FarbeGehalt := 'Standard';
        FarbeLabKommentar := 'Standard';
        FarbeStatus := 'Standard';
        FarbePackmittelVersion := 'Standard';

    END;


}
