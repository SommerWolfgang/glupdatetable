page 50007 "Aenderungsprotokoll"
{
    CaptionML = ENU = 'Change Log', DEU = 'Änderungsprotokoll';
    PageType = List;
    SourceTable = "Change Log Entry";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Date and Time"; "Date and Time")
                {
                    ApplicationArea = All;

                }
                field(Time; Time)
                {
                    ApplicationArea = All;

                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;

                }
                field("Table No."; "Table No.")
                {
                    ApplicationArea = All;
                }
                field("Table Caption"; "Table Caption")
                {
                    ApplicationArea = All;
                }
                field("Field No."; "Field No.")
                {
                    ApplicationArea = All;
                }
                field("Field Caption"; "Field Caption")
                {
                    ApplicationArea = All;
                }
                field("Type of Change"; "Type of Change")
                {
                    ApplicationArea = All;
                }
                field("Old Value"; "Old Value")
                {
                    ApplicationArea = All;
                }
                field("Old Value Local"; GetLocalOldValue)
                {
                    ApplicationArea = All;
                    Caption = 'Old Value (Local)';
                }
                field("New Value"; "New Value")
                {
                    ApplicationArea = All;
                }
                field("New Value Local"; GetLocalNewValue)
                {
                    ApplicationArea = All;
                    Caption = 'New Value (Local)';
                }
                field("Primary Key"; "Primary Key")
                {
                    ApplicationArea = All;
                }
                field("Primary Key Field 1 No."; "Primary Key Field 1 No.")
                {
                    ApplicationArea = All;
                }
                field("Primary Key Field 1 Caption"; "Primary Key Field 1 Caption")
                {
                    ApplicationArea = All;
                }
                field("Primary Key Field 1 Value"; "Primary Key Field 1 Value")
                {
                    ApplicationArea = All;
                }
                field("Primary Key Field 2 No."; "Primary Key Field 2 No.")
                {
                    ApplicationArea = All;
                }
                field("Primary Key Field 2 Caption"; "Primary Key Field 2 Caption")
                {
                    ApplicationArea = All;
                }
                field("Primary Key Field 2 Value"; "Primary Key Field 2 Value")
                {
                    ApplicationArea = All;
                }
                field("Primary Key Field 3 No."; "Primary Key Field 3 No.")
                {
                    ApplicationArea = All;
                }
                field("Primary Key Field 3 Caption"; "Primary Key Field 3 Caption")
                {
                    ApplicationArea = All;
                }
                field("Primary Key Field 3 Value"; "Primary Key Field 3 Value")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF sFilterCode <> '' THEN
            Rec.SETFILTER("Primary Key Field 1 Value", sFilterCode);
        IF sFilterUser <> '' THEN
            Rec.SETFILTER("User ID", sFilterUser);
        IF sFilterTable <> '' THEN
            Rec.SETFILTER("Table Caption", sFilterTable);
        IF sFilterTableNo <> '' THEN
            Rec.SETFILTER("Table No.", sFilterTableNo);
        IF sFilterCode2 > '' THEN
            Rec.SETFILTER("Primary Key Field 2 Value", sFilterCode2);
        IF sFilterCode3 > '' THEN
            Rec.SETFILTER("Primary Key Field 3 Value", sFilterCode3);
    end;


    var
        sFilterUser: Text[30];
        sFilterTable: Text[30];
        sFilterCode: Code[20];
        sFilterField: Text[30];
        sFilterCode2: Code[20];
        sFilterCode3: Code[20];
        sFilterTableNo: Text;


    procedure setFilter(sUser: Text[30]; sTable: Text[50]; sCode: Code[20])
    begin
        sFilterUser := sUser;
        sFilterTable := sTable;
        sFilterCode := sCode;  // GL001
        //  sFilterField:= sField;
    end;

    procedure setFilterArtikelHersteller(sUser: Text[30]; sTable: Text[50]; sCode: Code[20]; sCode2: Code[20]; sCode3: Code[20])
    begin
        //-GL003
        sFilterUser := sUser;
        sFilterTable := sTable;
        sFilterCode := sCode;
        sFilterCode2 := sCode2;
        sFilterCode3 := sCode3;
        //+GL003
    end;

    procedure setFilterChargenstamm(sUser: Text[30]; sTable: Text[50]; sCode: Code[20]; sCode2: Code[20])
    begin
        sFilterUser := sUser;
        sFilterTable := sTable;
        sFilterCode := sCode;
        sFilterCode2 := '';
        sFilterCode3 := sCode2;
    end;

    procedure setFilterByRec(sUser: Text[30]; Source: Variant): Boolean
    var
        myInt: Integer;
        cuDataTypeMgmt: Codeunit "Data Type Management";
        rRef: RecordRef;
        refKey: KeyRef;
        fRef: FieldRef;
        maxKey: Integer;
        i: Integer;
        KeyValArr: array[3] of Text;

    begin
        IF NOT cuDataTypeMgmt.GetRecordRef(Source, rRef) THEN
            EXIT(FALSE);

        refKey := rRef.KEYINDEX(1);
        maxKey := refKey.FIELDCOUNT();
        IF maxKey > 3 THEN
            maxKey := 3;
        FOR i := 1 TO maxKey DO BEGIN
            fRef := refKey.FIELDINDEX(i);
            KeyValArr[i] := fRef.VALUE;
            //KeyNoArr[i] := fRef.NUMBER;
        END;

        sFilterUser := sUser;
        sFilterTableNo := FORMAT(rRef.NUMBER);
        sFilterCode := KeyValArr[1];
        sFilterCode2 := KeyValArr[2];
        sFilterCode3 := KeyValArr[3];
        EXIT(TRUE);

    end;
}
