table 50105 DropDownContent
{
    Permissions =
        tabledata DropDownContent = R,
        tabledata DropDownContentParameter = R;

    fields
    {
        field(1; Tabelle; Integer)
        {
        }
        field(2; Feld; Code[20])
        {
        }
        field(3; ID; Code[20])
        {
        }
        field(4; Inhalt; Text[250])
        {
        }
        field(5; "Standort Zuordnung"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; Tabelle, Feld, ID, "Standort Zuordnung")
        {
        }
        key(Key2; ID, Inhalt)
        {
        }
        key(Key3; Tabelle, Feld, ID, Inhalt)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; ID, Inhalt)
        {
        }
        fieldgroup(Whatsapp; Tabelle, Feld, ID, "Standort Zuordnung", Inhalt)
        {
        }
    }

    trigger OnDelete()
    begin
        DropDownContentParameter.SETFILTER(Table, '%1', Tabelle);
        DropDownContentParameter.SETFILTER(Field, Feld);
        DropDownContentParameter.SETFILTER(ID, ID);
        IF DropDownContentParameter.FIND('-') THEN BEGIN
            IF NOT DropDownContentParameter.Allow_Delete THEN
                ERROR('Für Tabelle=''%1'', Feld=''%2'', ID=''%3'' darf keine Löschung erfolgen!', Tabelle, Feld, ID);
            EXIT
        END;

        DropDownContentParameter.SETFILTER(ID, '%1', '');
        IF DropDownContentParameter.FIND('-') THEN BEGIN
            IF NOT DropDownContentParameter.Allow_Delete THEN
                ERROR('Für Tabelle=''%1'', Feld=''%2'' darf keine Löschung erfolgen!', Tabelle, Feld);
            EXIT;
        END;

        DropDownContentParameter.SETFILTER(Field, '%1', '');
        IF DropDownContentParameter.FIND('-') THEN BEGIN
            IF NOT DropDownContentParameter.Allow_Delete THEN
                ERROR('Für Tabelle=''%1'' darf keine Löschung erfolgen!', Tabelle);
            EXIT;
        END;
    end;

    trigger OnInsert()
    begin

        DropDownContentParameter.SETFILTER(Table, '%1', Tabelle);
        DropDownContentParameter.SETFILTER(Field, Feld);
        DropDownContentParameter.SETFILTER(ID, ID);
        //-GL001
        DropDownContentParameter.SETFILTER("Standort Zuordnung", "Standort Zuordnung");
        //+GL001
        IF DropDownContentParameter.FIND('-') THEN BEGIN
            IF NOT DropDownContentParameter.Allow_New THEN
                ERROR('Für Tabelle=''%1'', Feld=''%2'', ID=''%3'' darf kein Eintrag erstellt werden!', Tabelle, Feld, ID);
            EXIT
        END;

        DropDownContentParameter.SETFILTER(ID, '%1', '');
        IF DropDownContentParameter.FIND('-') THEN BEGIN
            IF NOT DropDownContentParameter.Allow_New THEN
                ERROR('Für Tabelle=''%1'', Feld=''%2'' darf kein Eintrag erstellt werden!', Tabelle, Feld);
            EXIT;
        END;

        DropDownContentParameter.SETFILTER(Field, '%1', '');
        IF DropDownContentParameter.FIND('-') THEN BEGIN
            IF NOT DropDownContentParameter.Allow_New THEN
                ERROR('Für Tabelle=''%1'' darf kein neuer Eintrag erstellt werden!', Tabelle);
            EXIT;
        END;

        //-GL001
        //"Standort Zuordnung" := cuNaviPharma.StandortWeiche('SCHULUNG_USER', USERID);
        //+GL001
    end;

    trigger OnModify()
    begin
        DropDownContentParameter.SETFILTER(Table, '%1', Tabelle);
        DropDownContentParameter.SETFILTER(Field, Feld);
        DropDownContentParameter.SETFILTER(ID, ID);
        IF DropDownContentParameter.FIND('-') THEN BEGIN
            IF ((xRec.Tabelle = Rec.Tabelle) AND (xRec.Feld = Rec.Feld) AND (xRec.ID = Rec.ID)) THEN
                IF DropDownContentParameter.Allow_Description THEN
                    EXIT
                ELSE
                    ERROR('Für Tabelle=''%1'', Feld=''%2'', ID=''%3'' darf die Beschreibung nicht verändert werden!', Tabelle, Feld, ID);


            IF NOT DropDownContentParameter.Allow_Modify THEN
                ERROR('Für Tabelle=''%1'', Feld=''%2'', ID=''%3'' darf keine Änderung erfolgen!', Tabelle, Feld, ID);
            EXIT;
        END;

        DropDownContentParameter.SETFILTER(ID, '%1', '');
        IF DropDownContentParameter.FIND('-') THEN BEGIN
            IF NOT DropDownContentParameter.Allow_Modify THEN
                ERROR('Für Tabelle=''%1'', Feld=''%2'' darf keine Änderung erfolgen!', Tabelle, Feld);
            EXIT;
        END;

        DropDownContentParameter.SETFILTER(Field, '%1', '');
        IF DropDownContentParameter.FIND('-') THEN BEGIN
            IF NOT DropDownContentParameter.Allow_Modify THEN
                ERROR('Für Tabelle=''%1'' darf keine Änderung erfolgen!', Tabelle);
            EXIT;
        END;
    end;

    trigger OnRename()
    begin
        DropDownContentParameter.SETFILTER(Table, '%1', Tabelle);
        DropDownContentParameter.SETFILTER(Field, Feld);
        DropDownContentParameter.SETFILTER(ID, ID);
        IF DropDownContentParameter.FIND('-') THEN BEGIN
            IF ((xRec.Tabelle = Rec.Tabelle) AND (xRec.Feld = Rec.Feld) AND (xRec.ID = Rec.ID)) THEN
                IF DropDownContentParameter.Allow_Description THEN
                    EXIT
                ELSE
                    ERROR('Für Tabelle=''%1'', Feld=''%2'', ID=''%3'' darf die Beschreibung nicht verändert werden!', Tabelle, Feld, ID);


            IF NOT DropDownContentParameter.Allow_Modify THEN
                ERROR('Für Tabelle=''%1'', Feld=''%2'', ID=''%3'' darf keine Änderung erfolgen!', Tabelle, Feld, ID);
            EXIT
        END;

        DropDownContentParameter.SETFILTER(ID, '%1', '');
        IF DropDownContentParameter.FIND('-') THEN BEGIN
            IF NOT DropDownContentParameter.Allow_Modify THEN
                ERROR('Für Tabelle=''%1'', Feld=''%2'' darf keine Änderung erfolgen!', Tabelle, Feld);
            EXIT;
        END;

        DropDownContentParameter.SETFILTER(Field, '%1', '');
        IF DropDownContentParameter.FIND('-') THEN BEGIN
            IF NOT DropDownContentParameter.Allow_Modify THEN
                ERROR('Für Tabelle=''%1'' darf keine Änderung erfolgen!', Tabelle);
            EXIT;
        END;

        //-GL002  //Von leerer ID auf einen Wert abändern nicht zulassen, Werte in Tabellen werden sonst gesetzt
        IF (STRLEN(xRec.ID) = 0) AND (STRLEN(Rec.ID) > 0) THEN
            ERROR('Ein leerer ID Wert darf nicht geändert werden!');
        //+GL002
    end;

    var
        DropDownContentParameter: Record 50106;

}

