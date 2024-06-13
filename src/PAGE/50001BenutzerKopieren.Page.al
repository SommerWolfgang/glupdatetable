
//TASK47 TASK47.01  14.03.2024  MFU:  Benutzer Lookup Funktion


page 50001 BenutzerKopieren
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    //SourceTable = TableName;



    layout
    {
        area(Content)
        {
            group(UserKopieren)
            {
                field(tUserVon; tUserVon)
                {
                    Caption = 'Benutzer von';
                    ToolTip = 'Kopieren von Benutzer';
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        cuCodesammlung.LookupUser(tUserVon, tSIDVon);
                    end;

                    trigger OnValidate()
                    begin
                        tSIDVon := HoleSID(tUserVon);
                    end;

                }
                field(tUserNach; tUserNach)
                {
                    Caption = 'Benutzer nach';
                    ToolTip = 'Kopieren auf Benutzer';
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        cuCodesammlung.LookupUser(tUserNach, tSIDNach);
                    end;

                    trigger OnValidate()
                    begin
                        tSIDNach := HoleSID(tUserNach);
                    end;
                }
                field(bRollenKopieren; bRollenKopieren)
                {
                    ApplicationArea = All;
                    Caption = 'Rollen kopieren';
                }
                field(bRechteKopieren; bRechteKopieren)
                {
                    ApplicationArea = All;
                    Caption = 'Rechte kopieren';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Benutzer kopieren")
            {
                ApplicationArea = All;
                Image = Users;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    IF NOT ValidateUserID(tUserVon) THEN
                        EXIT;
                    IF NOT ValidateUserID(tUserNach) THEN
                        EXIT;

                    IF tUserNach = '' THEN
                        ERROR('ZielUser darf nicht leer sein');
                    IF tUserVon = '' THEN
                        ERROR('QuellUser darf nicht leer sein');


                    IF bRechteKopieren THEN
                        RechteKopieren();


                    IF bRollenKopieren THEN
                        RollenKopieren();



                end;
            }
        }
    }


    //Globale Variablen
    var
        tUserVon: Code[132];
        tUserNach: Code[132];
        tSIDVon: Guid;
        tSIDNach: Guid;
        bRollenKopieren: Boolean;
        bRechteKopieren: Boolean;
        LoginMgt: Codeunit "418";
        cuCodesammlung: Codeunit CodesammlungGLDE;


    procedure HoleSID(UserID: Text[100]) SID: Guid
    var
        //recSIDAccount: Record "2000000055";
        recLogin: Record "2000000120";
    begin

        recLogin.SETRANGE("User Name", UserID);
        IF recLogin.FINDFIRST THEN
            SID := recLogin."User Security ID";
    end;

    procedure ValidateUserID(UserID: Text[100]) lOk: Boolean
    var
        recUser: Record "2000000120";
    begin
        lOk := TRUE;

        recUser.SETRANGE("User Name", UserID);
        IF NOT recUser.FINDFIRST THEN BEGIN
            MESSAGE('User %1 not found', UserID);
            lOk := FALSE;
        END;
    end;

    procedure RollenKopieren()
    var
        recRollenVon: Record "2000000073";
        recRollenNach: Record "2000000073";
        recUserMetaVon: Record "2000000075";
        recSeitenanpassungVon: Record "2000000080";
        recUserMetaNach: Record "2000000075";
        recSeitenanpassungNach: Record "2000000080";
        //recUserPageMetadataVon: Record "2000000188";
        //recUserPageMetadataNach: Record "2000000188";
        iAnpassungenCounter: Integer;
        cHelp: Code[80];
    begin
        iAnpassungenCounter := 0;

        //Mögliche vorhandene Rolle löschen
        recRollenNach.RESET;
        recRollenNach.SETRANGE("User SID", tSIDNach);
        IF recRollenNach.FINDFIRST THEN
            recRollenNach.DELETE;

        //Rolle Kopieren
        recRollenVon.RESET;
        IF recRollenVon.GET(tSIDVon) THEN BEGIN
            recRollenNach.RESET;
            recRollenNach.INIT;
            recRollenNach.COPY(recRollenVon);
            recRollenNach."User SID" := tSIDNach;
            IF NOT recRollenNach.INSERT THEN
                ERROR('Rolle %1 konnte nicht auf Benutzer %2 kopiert werden', recRollenVon."Profile ID", tUserNach);
        END ELSE BEGIN
            MESSAGE('Keine Rollen zum kopieren von Benutzer %1 gefunden!', tUserVon);
        END;

        //----------------------------------------------------

        //Mögliche vorhandene löschen
        recUserMetaNach.RESET;
        recUserMetaNach.SETRANGE("User SID", tSIDNach);
        IF recUserMetaNach.FINDFIRST THEN
            recUserMetaNach.DELETEALL;

        //Kopieren
        recUserMetaVon.RESET;
        recUserMetaVon.SETRANGE("User SID", tSIDVon);
        IF recUserMetaVon.FINDFIRST THEN BEGIN
            REPEAT
                iAnpassungenCounter += 1;
                recUserMetaVon.CALCFIELDS("Page Metadata Delta");   //Blob Felder zuerst Berechnen und dann extra kopieren
                recUserMetaNach.RESET;
                recUserMetaNach.INIT;
                recUserMetaNach.COPY(recUserMetaVon);
                recUserMetaNach."User SID" := tSIDNach;
                recUserMetaNach."Page Metadata Delta" := recUserMetaVon."Page Metadata Delta";
                IF NOT recUserMetaNach.INSERT THEN
                    ERROR('Metadaten von %1 konnte nicht auf %2 kopiert werden', tUserVon, tUserNach);
            UNTIL recUserMetaVon.NEXT = 0;
        END ELSE BEGIN
            MESSAGE('Keine User-Metadaten zum kopieren von Benutzer %1 gefunden!', tUserVon);
        END;


        //----------------------------------------------------
        //Mögliche vorhandene löschen
        recSeitenanpassungNach.RESET;
        recSeitenanpassungNach.SETRANGE("User SID", tSIDNach);
        IF recSeitenanpassungNach.FINDFIRST THEN
            recSeitenanpassungNach.DELETEALL;

        //Kopieren
        recSeitenanpassungVon.RESET;
        recSeitenanpassungVon.SETRANGE("User SID", tSIDVon);
        IF recSeitenanpassungVon.FINDFIRST THEN BEGIN
            REPEAT
                iAnpassungenCounter += 1;
                recSeitenanpassungVon.CALCFIELDS(Value);
                recSeitenanpassungNach.RESET;
                recSeitenanpassungNach.INIT;
                recSeitenanpassungNach.COPY(recSeitenanpassungVon);
                recSeitenanpassungNach."User SID" := tSIDNach;
                recSeitenanpassungNach.Value := recSeitenanpassungVon.Value;
                IF NOT recSeitenanpassungNach.INSERT THEN
                    ERROR('Metadaten von %1 konnte nicht auf %2 kopiert werden', tUserVon, tUserNach);
            UNTIL recSeitenanpassungVon.NEXT = 0;
        END ELSE BEGIN
            MESSAGE('Keine Seitenanpassungen zum kopieren von Benutzer %1 gefunden!', tUserVon);
        END;


        /*
        //----------------------------------------------------
        //Mögliche vorhandene löschen
        recUserPageMetadataNach.RESET;
        recUserPageMetadataNach.SETRANGE("User SID", tSIDNach);
        IF recUserPageMetadataNach.FINDFIRST THEN
            recUserPageMetadataNach.DELETEALL;

        //Kopieren
        recUserPageMetadataVon.RESET;
        recUserPageMetadataVon.SETRANGE("User SID", tSIDVon);
        IF recUserPageMetadataVon.FINDFIRST THEN BEGIN
            REPEAT
                iAnpassungenCounter += 1;
                //recSeitenanpassungVon.CALCFIELDS(Value);
                recUserPageMetadataNach.RESET;
                recUserPageMetadataNach.INIT;
                recUserPageMetadataNach.COPY(recUserPageMetadataVon);
                recUserPageMetadataNach."User SID" := tSIDNach;
                //recUserPageMetadataNach.Value := recUserPageMetadataVon.Value;
                IF NOT recUserPageMetadataNach.INSERT THEN
                    ERROR('Metadaten von %1 konnte nicht auf %2 kopiert werden', tUserVon, tUserNach);
            UNTIL recUserPageMetadataVon.NEXT = 0;
        END ELSE BEGIN
            MESSAGE('Keine Seitenanpassungen zum kopieren von Benutzer %1 gefunden!', tUserVon);
        END;
        */


        MESSAGE('%1 Anzeige-Anpassungen auf %2 kopiert', iAnpassungenCounter, tUserNach);
    end;

    procedure RechteKopieren()
    var
        recUserVon: Record "2000000120";
        recUserSetupVon: Record "91";
        recAccessControlVon: Record "2000000053";
        recUserNach: Record "2000000120";
        recUserSetupNach: Record "91";
        recAccessControlNach: Record "2000000053";
        User_Sec_ID_Nach: Guid;
        User_Sec_ID_Von: Guid;
        iRechteAnzahl: Integer;
        recUserGruppenVon: Record "9001";
        recUserGruppenNach: Record "9001";
    begin
        iRechteAnzahl := 0;

        //Benutzersicherheitskennung ("User Security ID") aus der User Tabelle holen (Anlage des Benutzers nmus manuell gemacht werden)
        recUserNach.RESET;
        recUserNach.SETRANGE("User Security ID", tSIDNach);
        IF NOT recUserNach.FINDFIRST THEN
            ERROR('Ziel-User %1 wurde nicht gefunden', tUserNach);

        recUserVon.RESET;
        recUserVon.SETRANGE("User Security ID", tSIDVon);
        IF NOT recUserVon.FINDFIRST THEN
            ERROR('Ausgangs-User %1 wurde nicht gefunden', tUserVon);


        //Mögliche vorhandene Einträge löschen
        //Benutzer einrichtung löschen
        recUserSetupNach.RESET;
        recUserSetupNach.SETRANGE("User ID", tUserNach);
        IF recUserSetupNach.FINDFIRST THEN
            recUserSetupNach.DELETE;

        //Einzelrechte löschen
        recAccessControlNach.RESET;
        recAccessControlNach.SETRANGE("User Security ID", tSIDNach);
        IF recAccessControlNach.FINDFIRST THEN
            recAccessControlNach.DELETEALL(TRUE);

        //Berechtigungsgruppen löschen
        recUserGruppenNach.RESET;
        recUserGruppenNach.SETRANGE("User Security ID", tSIDNach);
        IF recUserGruppenNach.FINDFIRST THEN
            recUserGruppenNach.DELETEALL(TRUE);




        //Einträge Kopieren
        recUserSetupNach.RESET;
        recUserSetupVon.SETRANGE("User ID", tUserVon);
        IF recUserSetupVon.FINDFIRST THEN BEGIN
            recUserSetupNach.RESET;
            recUserSetupNach.INIT;
            recUserSetupNach.COPY(recUserSetupVon);
            recUserSetupNach."User ID" := tUserNach;
            //Gewisse Felder nicht kopieren, sondern leer setzen
            recUserSetupNach."Salespers./Purch. Code" := '';
            recUserSetupNach."E-Mail" := '';
            IF NOT recUserSetupNach.INSERT THEN
                ERROR('Benutzereinrichtung konnte nicht auf Benutzer %1 kopiert werden', tUserNach);
        END ELSE BEGIN
            MESSAGE('Keine Benutzereinrichtung zu Benutzer %1 gefunden!', tUserVon);
        END;


        //Berechtigungsgruppen kopieren
        recUserGruppenNach.RESET;
        recUserGruppenVon.SETRANGE("User Security ID", tSIDVon);
        IF recUserGruppenVon.FINDFIRST THEN BEGIN
            REPEAT
                recUserGruppenNach.RESET;
                recUserGruppenNach.RESET;
                recUserGruppenNach.COPY(recUserGruppenVon);
                recUserGruppenNach."User Security ID" := tSIDNach;
                IF NOT recUserGruppenNach.INSERT(TRUE) THEN        //Einzelrechte gleich anlegen -> Zusätzliche EInzelrechte im nächsten Schritt
                    ERROR('Zugriffsrechtegruppe konnte nicht auf Benutzer %1 kopiert werden', tUserNach);
            UNTIL recUserGruppenVon.NEXT = 0;
        END;


        //Einzelrechte
        recAccessControlNach.RESET;
        recAccessControlVon.SETRANGE("User Security ID", tSIDVon);
        IF recAccessControlVon.FINDFIRST THEN BEGIN
            REPEAT
                //Ist das Recht schon von den Rechtegruppen eingetragen wurden?   User Security ID,Role ID
                recAccessControlNach.SETRANGE("User Security ID", tSIDNach);
                recAccessControlNach.SETRANGE("Role ID", recAccessControlVon."Role ID");
                IF NOT recAccessControlNach.FINDFIRST THEN BEGIN
                    //Einzelrecht nicht durch Rechtegruppe vorhanden
                    recAccessControlNach.RESET;
                    recAccessControlNach.INIT;
                    recAccessControlNach.COPY(recAccessControlVon);
                    recAccessControlNach."User Security ID" := tSIDNach;
                    iRechteAnzahl += 1;
                    IF NOT recAccessControlNach.INSERT THEN
                        ERROR('Zugriffsrechte konnte nicht auf Benutzer %1 kopiert werden', tUserNach);

                END;
            UNTIL recAccessControlVon.NEXT = 0;
        END ELSE BEGIN
            MESSAGE('Keine Zugriffsrechte zu Benutzer %1 gefunden!', tUserVon);
        END;

        MESSAGE('%1 DB-Rechte auf %2 kopiert', iRechteAnzahl, tUserNach);
    end;


}

