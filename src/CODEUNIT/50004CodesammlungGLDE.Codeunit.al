
//TASK47 TASK47.01  14.03.2024  MFU:  Benutzer Lookup Funktion


codeunit 50004 CodesammlungGLDE
{
    procedure LagerstandStatus(itemno: Code[20]; LotStatus: code[20]; Lagerort: Code[20]): Decimal
    var
        recItem: Record Item;
        recILE: Record "Item Ledger Entry";
        recChargenstamm: Record "Lot No. Information";
        lagerstand: Decimal;
    begin
        if recItem.Get(itemno) then
            if recItem."Item Tracking Code" <> '' then begin
                recILE.SetCurrentKey("Item No.", "Variant Code", "Open", "Positive", "Location Code", "Expiration Date", "Lot No.");
                recILE.SetRange("Item No.", itemno);
                recILE.SetRange("Open", true);
                if Lagerort <> '' then
                    recILE.SetRange("Location Code", Lagerort);
                if recILE.FindSet(false) then
                    repeat
                        if recChargenstamm.Get(recILE."Item No.", '', recILE."Lot No.") then
                            if Format(recChargenstamm.Status) = LotStatus then
                                lagerstand := lagerstand + recILE."Remaining Quantity";
                    until recILE.Next() = 0;
            end else begin
                recItem.CalcFields(Inventory);
                lagerstand := recItem.Inventory;
            end;
        exit(lagerstand);
    end;

    // >> TASK60.01
    procedure ReplaceText(BCText: Text[250]; tTextReplace: Text; tReplaceTo: Text): text
    begin
        //Funktion für Verkaufsbericht
        exit(BCText.Replace(tTextReplace, tReplaceTo));
    end;
    // << TASK60.01

    // >> TASK47.01
    procedure LookupUser(var UserName: Code[50]; var SID: Guid): Boolean
    var
        User: Record User;
    begin
        User.RESET;
        User.SETCURRENTKEY("User Name");
        User."User Name" := UserName;
        if User.FIND('=><') then;
        if PAGE.RUNMODAL(PAGE::Users, User) = ACTION::LookupOK then begin
            UserName := User."User Name";
            SID := User."User Security ID";
            exit(TRUE);
        end;

        exit(FALSE);
    end;
    // >> TASK47.01


    procedure IsTestEnvironment(): boolean
    var
        bResult: Boolean;
        ActiveSession: Record "Active Session";
        cDatabasename: Text[100];
    begin
        bResult := FALSE;
        ActiveSession.SETRANGE("Server Instance ID", SERVICEINSTANCEID);
        ActiveSession.SETRANGE("Session ID", SESSIONID);
        ActiveSession.FINDFIRST;
        cDatabasename := ActiveSession."Database Name";

        IF (UPPERCASE(cDatabasename) <> 'BC_ECHT') THEN
            bResult := true;

        EXIT(bResult);

    end;


    procedure Berechtigung(Aktion: Code[20]): boolean
    var
        ok: Boolean;
        recUser: Record User;
        recAccessControl: Record "Access Control";
        UserSecurityID: Guid;
    begin

        ok := false;

        recUser.SETCURRENTKEY("User Name");
        recUser.SETRANGE("User Name", USERID);
        recUser.FINDFIRST;
        UserSecurityID := recUser."User Security ID";

        recAccessControl.SETRANGE("User Security ID", UserSecurityID);
        recAccessControl.SETRANGE("Role ID", Aktion);
        IF recAccessControl.FINDFIRST THEN
            ok := true;

        IF Aktion = '$MANDANTENCHECK' THEN BEGIN
            ok := Berechtigung('$' + UPPERCASE(COMPANYNAME)); //rekursiver Funktionsaufruf
            EXIT(ok);
        END;

        IF NOT ok THEN BEGIN  //bei Rolle Super alle Berechtigung für
            recAccessControl.SETRANGE("Role ID", 'SUPER');
            IF recAccessControl.FINDFIRST THEN
                EXIT(true);
        END;

        EXIT(ok);

    end;


    procedure AblaufDatumPlausibel(sArtikelnummer: Text[20]; dtDate: Date): boolean
    var
        bResult: Boolean;
        recItem: Record Item;
        dtHelp: Date;
        dtHelpToday: Date;
    begin

        bResult := FALSE;
        IF dtDate = 0D THEN EXIT(TRUE);
        IF dtDate <= TODAY THEN BEGIN
            MESSAGE('Das Ablaufdatum muss in der Zukunft liegen!\Das Datum wird zurückgesetzt.');
            EXIT;
        END;
        IF NOT recItem.GET(sArtikelnummer) THEN EXIT;
        IF (FORMAT(recItem."Expiration Calculation") <> '') THEN BEGIN

            dtHelp := CALCDATE('<-' + FORMAT(recItem."Expiration Calculation") + '>', dtDate);
            dtHelpToday := CALCDATE('+LM', TODAY); //Auf Monatsletzten setzen

            IF (dtHelp > dtHelpToday) THEN BEGIN
                MESSAGE('Gemäß der Ablaufdatumsformel würde das Herstelldatum in der Zukunft liegen! Das kann nicht sein.\' +
                'Das Datum wird zurückgesetzt.');
                EXIT;
            END;
        END;
        bResult := TRUE;
    end;

}
