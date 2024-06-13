tableextension 50036 T91UserSetup extends "User Setup"
{ // ------------------------------------------------------------------------------------------------------------------------------------
    // Datum      | Autor   | Status     | Beschreibung
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-02-05 | Petsch  | ok         | Update von 3.60
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-07-13 | Rieder  | OK         | Feld "Site Manufacturing" hinzugefügt (Ref. DropDownTable)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2010-11-15 | MFU     | OK         | Felder "Wartung_Standort" und "Wartung_Bereich" hinzugefügt für Maschionen Wartung Einschränkung
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2013-06-05 | MFU     | OK         | Feld "Wartung_Zuordnung" hinzugefügt für Maschinen Wartung Einschränkung
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2014-09-11 | MFU     | OK         | Feld "Buchblatt_User_Zuordnung" hinzugefügt für Buchblatt User Auswahl Einschränkung
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-04-21 | MFU     | OK         | GL002 - Feld "BenutzerEinstellungen" und Bearbeitungsfunktionen hinzugefügt -> Zum manuellen Speichern von Einstellungen im NAV
    //                                     Erste Zeichen für P50105 reserviert
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2016-06-21 | MFU     | OK         | AbsatzplanungBenachrichtigung eingebaut (Für Benutzerbezogene Info Verteilung bei Export PAE's)
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2017-10-18 | MFU     | OK         | GL003 - MarktfreigabePin eingebaut
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2017-11-13 | MFU     | OK         | GL004 - LagerHandheldPin eingebaut
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 2019-10-11 | MFU     | OK         | KommissionierungLagerortFilter für Schenker Kommissionierung
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 
    // 
    // 
    // 
    // !!!Achtung: Bei WaagePin() onvalidate: keine Standortunterscheidung in cuNaviPharma.StrCrypt(/true/false) mehr möglich
    fields
    {
        field(50000; WaagePin; Text[10])
        {
            Description = 'Petsch';

            trigger OnValidate()
            var
                cuNaviPharma: Codeunit NaviPharma;
                recManufacturingSetup: Record "99000765";
            begin
                recManufacturingSetup.GET;
                IF recManufacturingSetup.WaagePinVerschlüsselung > 0 THEN
                    WaagePin := cuNaviPharma.StrCrypt(WaagePin, recManufacturingSetup.WaagePinVerschlüsselung, TRUE);

                //IF recManufacturingSetup.Chargennummernsystem = recManufacturingSetup.Chargennummernsystem::Lannacher THEN BEGIN
                //  IF recManufacturingSetup.WaagePinVerschlüsselung > 0 THEN
                //     WaagePin:= cuNaviPharma.StrCrypt(WaagePin, recManufacturingSetup.WaagePinVerschlüsselung, TRUE);
                //END ELSE IF recManufacturingSetup.Chargennummernsystem = recManufacturingSetup.Chargennummernsystem::Gerot THEN BEGIN
                //  IF recManufacturingSetup.WaagePinVerschlüsselung > 0 THEN
                //     WaagePin:= cuNaviPharma.StrCrypt(WaagePin, recManufacturingSetup.WaagePinVerschlüsselung, FALSE);
                //END;
            end;
        }
        field(50001; WiegeUserLevel; Integer)
        {
            Description = 'Petsch';
        }
        field(50002; WiegeSuperVisorLevel; Integer)
        {
            Description = 'Petsch';
        }
        field(50003; Telefonnummer; Text[30])
        {
            Description = 'Rieder';
        }
        field(50004; Faxnummer; Text[30])
        {
            Description = 'Rieder';
        }
        field(50005; eMail; Text[30])
        {
            Description = 'Rieder';
        }
        field(50006; NaviWeigh; Boolean)
        {
            Description = 'Rieder';
        }
        field(50007; Ablaufdatum; Date)
        {
            Description = 'Rieder';
        }
        field(50010; "Site Manufacturing"; Code[20])
        {
            Caption = 'Standort Herstellung';
            Description = 'Rieder';

        }
        field(50011; Wartung_Standort; Code[10])
        {
        }
        field(50012; Wartung_Bereich; Code[10])
        {
        }
        field(50013; Schulung_Zuordnung; Code[10])
        {

        }
        field(50014; Wartung_Zuordnung; Code[20])
        {
            Description = 'MFU';

        }
        field(50015; BenutzerEinstellungen; Code[10])
        {
        }
        field(50016; AbsatzplanungBenachrichtigung; Option)
        {
            OptionMembers = " ",Mail,InfoCenter,MailErweitert;
        }
        field(50017; MarktfreigabePin; Text[10])
        {
            Description = 'MFU';

            trigger OnValidate()
            var
                cuNaviPharma: Codeunit NaviPharma;
                recManufacturingSetup: Record "99000765";
            begin
                //-GL003
                recManufacturingSetup.GET;
                IF recManufacturingSetup.WaagePinVerschlüsselung > 0 THEN
                    MarktfreigabePin := cuNaviPharma.StrCrypt(MarktfreigabePin, recManufacturingSetup.WaagePinVerschlüsselung, TRUE);
                //+GL003
            end;
        }
        field(50018; LagerHandheldPin; Text[10])
        {
            Description = 'MFU';

            trigger OnValidate()
            var
                recManufacturingSetup: Record "99000765";
                cuNaviPharma: Codeunit NaviPharma;
            begin

                //-GL004
                recManufacturingSetup.GET;
                IF recManufacturingSetup.WaagePinVerschlüsselung > 0 THEN
                    LagerHandheldPin := cuNaviPharma.StrCrypt(LagerHandheldPin, recManufacturingSetup.WaagePinVerschlüsselung, TRUE);
                //+GL004
            end;
        }
        field(50019; KommissionierungLagerortFilter; Text[10])
        {
            Caption = 'Kommissionierung Lagerort Filter';
            Description = 'MFU';
            TableRelation = Location.Code;
        }
        field(50021; "Site Assignment"; Code[20])
        {
            Caption = 'Standort Zuordnung';
            Description = 'CCU12';

        }
        field(50022; "Default Location"; Code[10])
        {
            Caption = 'Standard Lagerort';
            Description = 'CCU12';
            TableRelation = IF ("Site Assignment" = FILTER('WIEN')) Location.Code WHERE(City = FILTER('WIEN' | ''))
            ELSE
            IF ("Site Assignment" = FILTER('LANNACH')) Location.Code WHERE(City = FILTER('LANNACH' | ''))
            ELSE
            IF ("Site Assignment" = FILTER('')) Location.Code;
        }
        field(50023; "Default Bin"; Code[20])
        {
            Caption = 'Standard Lagerplatz';
            Description = 'CCU12';
            TableRelation = IF ("Default Location" = FILTER(<> '')) Bin.Code WHERE("Location Code" = FIELD("Default Location"));
        }
    }
    procedure SetBenutzerEinstellung(cUserID: Code[50]; iPosition: Integer; cZeichen: Code[1])
    var
        cVal: Code[10];
    begin
        //-GL002
        IF (iPosition > 0) AND (iPosition <= 10) THEN BEGIN
            IF Rec.GET(cUserID) THEN BEGIN
                cVal := Rec.BenutzerEinstellungen;
                cVal[iPosition] := cZeichen[1];
                Rec.BenutzerEinstellungen := cVal;
                Rec.MODIFY;
            END;
        END;
        //+GL002
    end;

    procedure GetBenutzerEinstellung(cUserID: Code[50]; iPosition: Integer) cReturn: Code[1]
    begin
        //-GL002
        cReturn := '';
        IF (iPosition > 0) AND (iPosition <= 10) THEN BEGIN
            IF Rec.GET(cUserID) THEN BEGIN
                cReturn := COPYSTR(Rec.BenutzerEinstellungen, iPosition, 1);
            END;
        END;
        //+GL002
    end;
}
