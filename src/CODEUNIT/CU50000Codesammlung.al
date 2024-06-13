codeunit 50000 Codesammlung
{
    Permissions =

        tabledata "Bin Content" = R,
        tabledata "Comment Line" = R,
        tabledata "Currency Exchange Rate" = R,
        tabledata Customer = R,
        tabledata "General Ledger Setup" = R,
        tabledata "Inventory Setup" = R,
        tabledata Item = R,
        tabledata "Item Journal Batch" = RID,
        tabledata "Item Journal Line" = RID,
        tabledata "Item Ledger Entry" = R,
        tabledata Location = R,
        tabledata "Lot No. Information" = R,
        tabledata "Purch. Cr. Memo Hdr." = R,
        tabledata "Purch. Cr. Memo Line" = R,
        tabledata "Purch. Inv. Header" = R,
        tabledata "Purch. Inv. Line" = R,
        tabledata "Purchase Header" = R,
        tabledata "Purchase Line" = RIM,
        tabledata "Sales Cr.Memo Header" = RM,
        tabledata "Sales Header" = RM,
        tabledata "Sales Invoice Header" = RM,
        tabledata "Sales Price" = R,
        tabledata "Sales Shipment Header" = R,
        tabledata "Ship-to Address" = R,
        tabledata "Transfer Header" = R,
        tabledata "Transfer Line" = R,
        tabledata "Value Entry" = R,
        tabledata Vendor = R,
        tabledata "Warehouse Entry" = R;

    trigger OnRun()
    begin
    end;

    var
        HasBeenInitialized: Boolean;
        ANSI: Text[94];
        ASCII: Text[94];
        TEMPLATE_NAME: Label 'UMLAGERUNG';
        BATCH_NAME: Label '$BEREITST.';
        DOCUMENT_NAME: Label 'BEREITSTELLUNG';

    procedure Bemerkungsmeldung("Artikelnr.": Code[20])
    var
        BemerkungsText: Text[1000];
        Bemerkzeile: Record "97";
    begin
        //-LAN001
        BemerkungsText := '';
        Bemerkzeile.SETCURRENTKEY("Table Name", Code, Date, "Meldung in Bestellung anzeigen");
        Bemerkzeile.SETRANGE("Table Name", Bemerkzeile."Table Name"::Item);
        Bemerkzeile.SETRANGE("No.", "Artikelnr.");
        Bemerkzeile.SETRANGE("Meldung in Bestellung anzeigen", TRUE);
        IF Bemerkzeile.FINDSET THEN BEGIN
            REPEAT
                IF Bemerkzeile.Comment <> '' THEN BEGIN
                    BemerkungsText += COPYSTR(Bemerkzeile.Comment, 1,
                      MAXSTRLEN(BemerkungsText) - STRLEN(BemerkungsText));
                    IF MAXSTRLEN(BemerkungsText) > STRLEN(BemerkungsText) THEN
                        BemerkungsText += '\';
                END;
            UNTIL Bemerkzeile.NEXT = 0;
        END;

        IF BemerkungsText <> '' THEN
            MESSAGE(COPYSTR(BemerkungsText, 1, STRLEN(BemerkungsText) - 1));
        //+LAN001
    end;

    procedure EKLiefBemerkungsmeldung(EKKopf: Record "38")
    var
        BemerkungsText: Text[1000];
        Bemerkzeile: Record "97";
        EKZeile: Record "39";
        OldItem: Code[20];
    begin
        //-LAN001
        OldItem := '';
        EKZeile.SETRANGE("Document Type", EKKopf."Document Type");
        EKZeile.SETRANGE("Document No.", EKKopf."No.");
        EKZeile.SETRANGE(Type, EKZeile.Type::Item);
        IF EKZeile.FINDSET THEN
            REPEAT
                BemerkungsText := '';
                Bemerkzeile.SETCURRENTKEY("Table Name", Code, Date, "Meldung in Bestellung anzeigen");
                Bemerkzeile.SETRANGE("Table Name", Bemerkzeile."Table Name"::Item);
                Bemerkzeile.SETRANGE("No.", EKZeile."No.");
                Bemerkzeile.SETRANGE("Meldung bei EK-Lieferung", TRUE);
                IF Bemerkzeile.FIND('-') THEN BEGIN
                    REPEAT
                        IF Bemerkzeile.Comment <> '' THEN BEGIN
                            BemerkungsText += COPYSTR(Bemerkzeile.Comment, 1,
                              MAXSTRLEN(BemerkungsText) - STRLEN(BemerkungsText));
                            IF MAXSTRLEN(BemerkungsText) > STRLEN(BemerkungsText) THEN
                                BemerkungsText += '\';
                        END;
                    UNTIL Bemerkzeile.NEXT = 0;
                END;
                IF OldItem <> EKZeile."No." THEN
                    IF BemerkungsText <> '' THEN
                        MESSAGE(COPYSTR(BemerkungsText, 1, STRLEN(BemerkungsText) - 1));
                OldItem := EKZeile."No.";
            UNTIL EKZeile.NEXT = 0;
        //+LAN001
    end;

    procedure Verkaufslager() Lagerort: Code[10]
    var
        LagerEinrichtung: Record "313";
    begin
        //-LAN001
        LagerEinrichtung.GET;
        LagerEinrichtung.TESTFIELD(Verkaufslagerortcode);
        Lagerort := LagerEinrichtung.Verkaufslagerortcode;
        //+LAN001
    end;

    procedure AktArtikelkonto(Item: Record "27")
    var
        TempValueEntry: Record "5802" temporary;
        ValueEntry: Record "5802";
        PurchInvHeader: Record "122";
        PurchInvLine: Record "123";
        PurchCrMemoHeader: Record "124";
        PurchCrMemoLine: Record "125";
        CurrencyExchRate: Record "330";
        GLEntry: Record "17";
        EntryNoGLEntry: Integer;
        Zeilennummer: Integer;
        Fenster: Dialog;
    begin
        //-LAN001
        WITH Item DO BEGIN
            Fenster.OPEN('Ermittle Artikelkontoinfo ' + Item."No." + ' #1#########');
            CLEAR(TempValueEntry);

            ValueEntry.SETCURRENTKEY("Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type");
            ValueEntry.SETFILTER("Item No.", "No.");
            ValueEntry.SETRANGE("Entry Type", ValueEntry."Entry Type"::"Direct Cost");
            ValueEntry.SETRANGE("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Purchase);
            Fenster.UPDATE(1, 'Wertposten');
            IF ValueEntry.FINDSET THEN
                REPEAT
                    TempValueEntry.INIT;
                    TempValueEntry := ValueEntry;
                    TempValueEntry."No." := '';
                    IF NOT TempValueEntry.INSERT THEN
                        TempValueEntry.MODIFY;
                UNTIL ValueEntry.NEXT = 0;

            //EK-Rechnungen mit Bezug Artikelnr.
            Fenster.UPDATE(1, 'EK-Rechnungen');
            Zeilennummer := 99990000;
            PurchInvLine.SETCURRENTKEY(Type, "Zuordnung zu Artikelnr.");
            PurchInvLine.SETRANGE(Type, PurchInvLine.Type::"G/L Account");
            PurchInvLine.SETRANGE("Zuordnung zu Artikelnr.", "No.");
            IF PurchInvLine.FIND('-') THEN
                REPEAT
                    Zeilennummer += 1;
                    TempValueEntry.INIT;
                    TempValueEntry."Entry No." := Zeilennummer;
                    TempValueEntry."Document No." := PurchInvLine."Document No.";
                    TempValueEntry.Description := PurchInvLine.Description;
                    TempValueEntry."No." := PurchInvLine."No.";          //Sachkontonr.
                    TempValueEntry."Item No." := PurchInvLine."Zuordnung zu Artikelnr.";
                    TempValueEntry."Item Ledger Entry No." := PurchInvLine."Zuordnung zu Artikelposten";
                    TempValueEntry."Item Ledger Entry Type" := TempValueEntry."Item Ledger Entry Type"::Purchase;
                    TempValueEntry."Global Dimension 1 Code" := PurchInvLine."Shortcut Dimension 1 Code";
                    TempValueEntry."Valued Quantity" := PurchInvLine."Quantity (Base)";
                    TempValueEntry."Invoiced Quantity" := PurchInvLine."Quantity (Base)";
                    //Rechnungskopf holen
                    PurchInvHeader.GET(PurchInvLine."Document No.");
                    TempValueEntry."Document Date" := PurchInvHeader."Document Date";
                    TempValueEntry."Posting Date" := PurchInvHeader."Posting Date";
                    TempValueEntry."External Document No." := PurchInvHeader."Vendor Invoice No.";
                    TempValueEntry."Cost per Unit" := PurchInvLine."Unit Cost (LCY)";
                    TempValueEntry."Cost Amount (Actual)" := CurrencyExchRate.ExchangeAmtFCYToLCY(
                      PurchInvHeader."Posting Date",
                      PurchInvHeader."Currency Code",
                      PurchInvLine.Amount,
                      PurchInvHeader."Currency Factor");
                    TempValueEntry."Betrag (FW)" := PurchInvLine.Amount;
                    TempValueEntry.Fremdwährung := PurchInvHeader."Currency Code";
                    TempValueEntry."Bestellnr." := PurchInvHeader."Order No.";
                    TempValueEntry.Bestelldatum := PurchInvHeader."Order Date";
                    TempValueEntry."Source Type" := TempValueEntry."Source Type"::Vendor;
                    TempValueEntry."Source No." := PurchInvLine."Buy-from Vendor No.";
                    TempValueEntry.INSERT;
                UNTIL PurchInvLine.NEXT = 0;

            Fenster.UPDATE(1, 'EK-Gutschriften');
            PurchCrMemoLine.SETCURRENTKEY(Type, "Zuordnung zu Artikelnr.");  //Gutschriften mit Bezug Artikelnr.
                                                                             //PurchCrMemoLine.SETRANGE(Type,PurchCrMemoLine::"G/L Account");
            PurchCrMemoLine.SETRANGE("Zuordnung zu Artikelnr.", "No.");
            IF PurchCrMemoLine.FIND('-') THEN
                REPEAT
                    Zeilennummer += 1;
                    TempValueEntry.INIT;
                    TempValueEntry."Entry No." := Zeilennummer;
                    TempValueEntry."Document No." := PurchCrMemoLine."Document No.";
                    TempValueEntry.Description := PurchCrMemoLine.Description;
                    TempValueEntry."No." := PurchCrMemoLine."No.";          //Sachkontonr.
                    TempValueEntry."Item No." := PurchCrMemoLine."Zuordnung zu Artikelnr.";
                    TempValueEntry."Item Ledger Entry No." := PurchCrMemoLine."Zuordnung zu Artikelposten";
                    TempValueEntry."Item Ledger Entry Type" := TempValueEntry."Item Ledger Entry Type"::Purchase;
                    TempValueEntry."Global Dimension 1 Code" := PurchCrMemoLine."Shortcut Dimension 1 Code";
                    TempValueEntry."Valued Quantity" := PurchCrMemoLine."Quantity (Base)";
                    TempValueEntry."Invoiced Quantity" := PurchCrMemoLine."Quantity (Base)";
                    //Gutschriftskopf holen
                    PurchCrMemoHeader.GET(PurchCrMemoLine."Document No.");
                    TempValueEntry."Document Date" := PurchCrMemoHeader."Document Date";
                    TempValueEntry."Posting Date" := PurchCrMemoHeader."Posting Date";
                    TempValueEntry."External Document No." := PurchCrMemoHeader."Vendor Cr. Memo No.";
                    TempValueEntry."Cost per Unit" := PurchCrMemoLine."Unit Cost (LCY)";
                    TempValueEntry."Cost Amount (Actual)" := CurrencyExchRate.ExchangeAmtFCYToLCY(
                      PurchCrMemoHeader."Posting Date",
                      PurchCrMemoHeader."Currency Code",
                      PurchCrMemoLine.Amount,
                      PurchCrMemoHeader."Currency Factor");
                    TempValueEntry."Betrag (FW)" := PurchCrMemoLine.Amount;
                    TempValueEntry.Fremdwährung := PurchCrMemoHeader."Currency Code";
                    //TempValueEntry."Bestellnr." := PurchCrMemoHeader."Order No.";
                    //TempValueEntry.Bestelldatum := PurchCrMemoHeader."Order Date";
                    TempValueEntry."Source Type" := TempValueEntry."Source Type"::Vendor;
                    TempValueEntry."Source No." := PurchCrMemoLine."Buy-from Vendor No.";
                    TempValueEntry.INSERT;
                UNTIL PurchCrMemoLine.NEXT = 0;
            Fenster.CLOSE;
            TempValueEntry.SETRANGE("Item Ledger Entry Type", TempValueEntry."Item Ledger Entry Type"::Purchase);
            PAGE.RUNMODAL(51205, TempValueEntry);
        END;
        //+LAN001
    end;

    procedure ASCII2ANSI(Text: Text[1024]): Text[1024]
    begin
        InitCharMap;
        EXIT(CONVERTSTR(Text, ASCII, ANSI));
    end;

    procedure ANSI2ASCII(Text: Text[1024]): Text[1024]
    begin
        InitCharMap;
        EXIT(CONVERTSTR(Text, ANSI, ASCII));
    end;

    local procedure InitCharMap()
    begin
        IF HasBeenInitialized THEN
            EXIT;

        ANSI[1] := 131;
        ASCII[1] := 159;  // ƒ
        ANSI[2] := 161;
        ASCII[2] := 173;  // ¡
        ANSI[3] := 162;
        ASCII[3] := 189;  // ¢
        ANSI[4] := 163;
        ASCII[4] := 156;  // £
        ANSI[5] := 164;
        ASCII[5] := 207;  // ¤
        ANSI[6] := 165;
        ASCII[6] := 190;  // ¥
        ANSI[7] := 166;
        ASCII[7] := 221;  // ¦
        ANSI[8] := 167;
        ASCII[8] := 245;  // §
        ANSI[9] := 168;
        ASCII[9] := 249;  // ¨
        ANSI[10] := 169;
        ASCII[10] := 184;  // ©
        ANSI[11] := 170;
        ASCII[11] := 166;  // ª
        ANSI[12] := 171;
        ASCII[12] := 174;  // «
        ANSI[13] := 173;
        ASCII[13] := 240;  // ­
        ANSI[14] := 174;
        ASCII[14] := 169;  // ®
        ANSI[15] := 175;
        ASCII[15] := 238;  // ¯
        ANSI[16] := 176;
        ASCII[16] := 167;  // °
        ANSI[17] := 177;
        ASCII[17] := 241;  // ±
        ANSI[18] := 178;
        ASCII[18] := 253;  // ²
        ANSI[19] := 179;
        ASCII[19] := 252;  // ³
        ANSI[20] := 180;
        ASCII[20] := 239;  // ´
        ANSI[21] := 181;
        ASCII[21] := 230;  // µ
        ANSI[22] := 182;
        ASCII[22] := 244;  // ¶
        ANSI[23] := 183;
        ASCII[23] := 250;  // ·
        ANSI[24] := 184;
        ASCII[24] := 247;  // ¸
        ANSI[25] := 185;
        ASCII[25] := 251;  // ¹
        ANSI[26] := 187;
        ASCII[26] := 175;  // »
        ANSI[27] := 188;
        ASCII[27] := 172;  // ¼
        ANSI[28] := 189;
        ASCII[28] := 171;  // ½
        ANSI[29] := 190;
        ASCII[29] := 243;  // ¾
        ANSI[30] := 191;
        ASCII[30] := 168;  // ¿
        ANSI[31] := 192;
        ASCII[31] := 183;  // À
        ANSI[32] := 193;
        ASCII[32] := 181;  // Á
        ANSI[33] := 194;
        ASCII[33] := 182;  // Â
        ANSI[34] := 195;
        ASCII[34] := 199;  // Ã
        ANSI[35] := 196;
        ASCII[35] := 142;  // Ä
        ANSI[36] := 197;
        ASCII[36] := 143;  // Å
        ANSI[37] := 198;
        ASCII[37] := 146;  // Æ
        ANSI[38] := 199;
        ASCII[38] := 128;  // Ç
        ANSI[39] := 200;
        ASCII[39] := 212;  // È
        ANSI[40] := 201;
        ASCII[40] := 144;  // É
        ANSI[41] := 202;
        ASCII[41] := 210;  // Ê
        ANSI[42] := 203;
        ASCII[42] := 211;  // Ë
        ANSI[43] := 204;
        ASCII[43] := 222;  // Ì
        ANSI[44] := 205;
        ASCII[44] := 214;  // Í
        ANSI[45] := 206;
        ASCII[45] := 215;  // Î
        ANSI[46] := 207;
        ASCII[46] := 216;  // Ï
        ANSI[47] := 208;
        ASCII[47] := 209;  // Ð
        ANSI[48] := 209;
        ASCII[48] := 165;  // Ñ
        ANSI[49] := 210;
        ASCII[49] := 227;  // Ò
        ANSI[50] := 211;
        ASCII[50] := 224;  // Ó
        ANSI[51] := 212;
        ASCII[51] := 226;  // Ô
        ANSI[52] := 213;
        ASCII[52] := 229;  // Õ
        ANSI[53] := 214;
        ASCII[53] := 153;  // Ö
        ANSI[54] := 215;
        ASCII[54] := 158;  // ×
        ANSI[55] := 216;
        ASCII[55] := 157;  // Ø
        ANSI[56] := 217;
        ASCII[56] := 235;  // Ù
        ANSI[57] := 218;
        ASCII[57] := 233;  // Ú
        ANSI[58] := 219;
        ASCII[58] := 234;  // Û
        ANSI[59] := 220;
        ASCII[59] := 154;  // Ü
        ANSI[60] := 221;
        ASCII[60] := 237;  // Ý
        ANSI[61] := 222;
        ASCII[61] := 232;  // Þ
        ANSI[62] := 223;
        ASCII[62] := 225;  // ß
        ANSI[63] := 224;
        ASCII[63] := 133;  // à
        ANSI[64] := 225;
        ASCII[64] := 160;  // á
        ANSI[65] := 226;
        ASCII[65] := 131;  // â
        ANSI[66] := 227;
        ASCII[66] := 198;  // ã
        ANSI[67] := 228;
        ASCII[67] := 132;  // ä
        ANSI[68] := 229;
        ASCII[68] := 134;  // å
        ANSI[69] := 230;
        ASCII[69] := 145;  // æ
        ANSI[70] := 231;
        ASCII[70] := 135;  // ç
        ANSI[71] := 232;
        ASCII[71] := 138;  // è
        ANSI[72] := 233;
        ASCII[72] := 130;  // é
        ANSI[73] := 234;
        ASCII[73] := 136;  // ê
        ANSI[74] := 235;
        ASCII[74] := 137;  // ë
        ANSI[75] := 236;
        ASCII[75] := 141;  // ì
        ANSI[76] := 237;
        ASCII[76] := 161;  // í
        ANSI[77] := 238;
        ASCII[77] := 140;  // î
        ANSI[78] := 239;
        ASCII[78] := 139;  // ï
        ANSI[79] := 240;
        ASCII[79] := 208;  // ð
        ANSI[80] := 241;
        ASCII[80] := 164;  // ñ
        ANSI[81] := 242;
        ASCII[81] := 149;  // ò
        ANSI[82] := 243;
        ASCII[82] := 162;  // ó
        ANSI[83] := 244;
        ASCII[83] := 147;  // ô
        ANSI[84] := 245;
        ASCII[84] := 228;  // õ
        ANSI[85] := 246;
        ASCII[85] := 148;  // ö
        ANSI[86] := 247;
        ASCII[86] := 246;  // ÷
        ANSI[87] := 248;
        ASCII[87] := 155;  // ø
        ANSI[88] := 249;
        ASCII[88] := 151;  // ù
        ANSI[89] := 250;
        ASCII[89] := 163;  // ú
        ANSI[90] := 251;
        ASCII[90] := 150;  // û
        ANSI[91] := 252;
        ASCII[91] := 129;  // ü
        ANSI[92] := 253;
        ASCII[92] := 236;  // ý
        ANSI[93] := 254;
        ASCII[93] := 231;  // þ
        ANSI[94] := 255;
        ASCII[94] := 152;  // ÿ

        HasBeenInitialized := TRUE;
    end;

    procedure Fakturenkontrolle(EinkKopf: Record "38"): Boolean
    var
        EinkZeile: Record "39";
    begin
        EinkZeile.SETRANGE("Document Type", EinkKopf."Document Type");
        EinkZeile.SETRANGE("Document No.", EinkKopf."No.");
        EinkZeile.SETRANGE(Type, EinkZeile.Type::Item);
        IF EinkZeile.FIND('-') THEN
            REPEAT
                IF (EinkZeile."Qty. to Receive" > 0) OR (EinkZeile."Qty. to Invoice" > 0) THEN
                    IF Artikelprüfen(EinkZeile, 20) THEN
                        EXIT(FALSE);
            UNTIL EinkZeile.NEXT = 0;
        EXIT(TRUE);

        //false heißt: nicht buchen in CU 91
    end;

    procedure Suchtgiftliste()
    begin
        /*
        //UPDATE2013 - Wird nicht mehr benötigt
        ReportSuchtgiftliste.Starten;
        ReportSuchtgiftliste.RUNMODAL;
        IF ReportSuchtgiftliste."alles gedruckt" THEN
          IF CONFIRM('Wurde der Druck ohne Fehler durchgeführt?',TRUE) THEN
            ReportSuchtgiftliste.ArtikelModify;
        */

    end;

    procedure "Artikelprüfen"(EinkkaufszeileRec: Record "39"; Warnwert: Decimal): Boolean
    var
        EinkRechZeile: Record "123";
        artikel: Record "27";
        nhilf: Decimal;
        cHilf: Text[150];
    begin

        //-GL019
        //neu: Nur mehr den Einstandspreis Abfragen  (Erstbestellung funkt dann auch)

        IF artikel.GET(EinkkaufszeileRec."No.") THEN BEGIN
            IF COPYSTR(EinkRechZeile."No.", 1, 2) = 'DI' THEN  //Diverse Artikel nicht abprüfen
                IF FORMAT(artikel.Artikelart) = ' ' THEN
                    EXIT(FALSE);

            nhilf := Abweichung(artikel."Unit Cost",
                               EinkkaufszeileRec."Unit Cost" / EinkkaufszeileRec."Qty. per Unit of Measure");    //GL020 "Unit Cost" statt "Unit Cost (LCY)" genommen
            cHilf := 'bisher: ' + FORMAT(artikel."Unit Cost") + ' jetzt: ' + FORMAT(EinkkaufszeileRec."Unit Cost" / EinkkaufszeileRec."Qty. per Unit of Measure");
            cHilf := '(' + cHilf + ')';

            IF artikel."Costing Method" = artikel."Costing Method"::Standard THEN BEGIN
                //Bei Fertigwaren/HF immer zum Einstandspreis genau Einkaufen, sonst Meldung
                IF ABS(nhilf) > 0 THEN
                    IF NOT CONFIRM(
                      'Der Einstandspreis von %1 weicht um %2 Prozent ab.%3\' +
                      'Wollen Sie trotzdem Buchen?', FALSE, EinkkaufszeileRec."No.", ROUND(nhilf, 0.1), cHilf) THEN
                        EXIT(TRUE);

            END ELSE BEGIN
                //Bei FiFo-Artikel den Toleranzwert zulassen (Preiserhöhung)
                IF ABS(nhilf) >= Warnwert THEN
                    IF NOT CONFIRM(
                      'Der Einstandspreis von %1 weicht um %2 Prozent ab.%3\' +
                      'Wollen Sie trotzdem Buchen?', FALSE, EinkkaufszeileRec."No.", ROUND(nhilf, 0.1), cHilf) THEN
                        EXIT(TRUE);
            END;
        END;

        EXIT(FALSE);


        //alt (Nur prüfung, wenn schon EK-Rechnung vorhanden):
        /*
        EinkRechZeile.SETCURRENTKEY(Type,"No.");
        EinkRechZeile.SETRANGE(Type,EinkRechZeile.Type::Item);
        EinkRechZeile.SETRANGE("No.",EinkkaufszeileRec."No.");
        EinkRechZeile.SETFILTER(Quantity,'>0'); //keine RÜR!
        IF EinkRechZeile.FIND('+') THEN BEGIN
            IF COPYSTR(EinkRechZeile."No.",1,2)='DI' THEN  //Diverse Artikel nicht abprüfen
              IF artikel.GET(EinkRechZeile."No.") THEN
                 IF FORMAT(artikel.Artikelart) = ' ' THEN
                    EXIT(FALSE);
            nhilf := Abweichung(EinkRechZeile."Unit Cost (LCY)"/EinkRechZeile."Qty. per Unit of Measure",
                               EinkkaufszeileRec."Unit Cost (LCY)"/EinkkaufszeileRec."Qty. per Unit of Measure");
            cHilf := 'bisher: '+FORMAT(EinkRechZeile."Unit Cost (LCY)") + ' jetzt: '+ FORMAT(EinkkaufszeileRec."Unit Cost (LCY)");
            cHilf := '('+cHilf+')';
            IF ABS(nhilf) >= Warnwert THEN
              IF NOT CONFIRM(
                'Der Einstandspreis von %1 weicht um %2 Prozent ab.%3\' +
                'Wollen Sie trotzdem Buchen?',FALSE,EinkRechZeile."No.",ROUND(nhilf,0.1),cHilf) THEN
                   EXIT(TRUE);
        END;
        EXIT(FALSE);
        */
        //+GL019

    end;

    procedure Abweichung(Wert1: Decimal; Wert2: Decimal) Abweich: Decimal
    begin
        IF Wert1 <> 0 THEN
            Abweich := (Wert2 / Wert1 - 1) * 100
        ELSE
            Abweich := 0;
        //Abweich := abs(Abweich);
    end;

    procedure Bereitstellungslager(var "Location Name": Code[10]) Result: Boolean
    var
        LagerEinrichtung: Record "313";
    begin
        //Prüfe auf welches Lager die Komm. zugreifen soll (Verkaufslager)

        LagerEinrichtung.GET();
        Result := LagerEinrichtung.Bereitstellungslagerortcode <> '';
        "Location Name" := LagerEinrichtung.Bereitstellungslagerortcode;
    end;
    /* TODOPBA Benötigt?
    procedure DimMatchCodeSuche(DimNo: Integer; Text: Text[1024]): Text[1024]
    var
        //recDepartment: Record "1001762";
        //recProject: Record "1001763";
        number: Integer;
    begin
        //-002
        IF Text = '' THEN
            EXIT(Text);
        IF EVALUATE(number, Text) THEN
            EXIT(Text);

        CASE DimNo OF
            1:
                BEGIN
                    recDepartment.Code := Text;
                    IF recDepartment.FIND('=>') THEN
                        IF COPYSTR(recDepartment.Code, 1, STRLEN(Text)) = UPPERCASE(Text) THEN BEGIN
                            Text := recDepartment.Code;
                            EXIT(Text);
                        END;
                    recDepartment.SETCURRENTKEY("Search Description");
                    recDepartment."Search Description" := Text;
                    recDepartment.Code := '';
                    IF recDepartment.FIND('=>') THEN
                        IF COPYSTR(recDepartment."Search Description", 1, STRLEN(Text)) = UPPERCASE(Text) THEN
                            Text := recDepartment.Code;
                END;
        END;
        CASE DimNo OF
            2:
                BEGIN
                    recProject.Code := Text;
                    IF recProject.FIND('=>') THEN
                        IF COPYSTR(recProject.Code, 1, STRLEN(Text)) = UPPERCASE(Text) THEN BEGIN
                            Text := recProject.Code;
                            EXIT(Text);
                        END;
                    recProject.SETCURRENTKEY("Search Description");
                    recProject."Search Description" := Text;
                    recProject.Code := '';
                    IF recProject.FIND('=>') THEN
                        IF COPYSTR(recProject."Search Description", 1, STRLEN(Text)) = UPPERCASE(Text) THEN
                            Text := recProject.Code;
                END;
        END;
        EXIT(Text);
        //+002
    end;
    */
    procedure FAPDatum(artikelnummer: Code[20]; tDatum: Text[30]) fap: Decimal
    var
        ArtVKPreis: Record "7002";
        recCurrencyExchangeRate: Record "330";
    begin
        //-GL006
        fap := 0;
        CLEAR(ArtVKPreis);
        WITH ArtVKPreis DO BEGIN
            SETFILTER("Item No.", artikelnummer);
            SETRANGE("Sales Type", ArtVKPreis."Sales Type"::"Customer Price Group");
            SETFILTER("Sales Code", '1FAP');
            SETFILTER("Starting Date", '<=' + tDatum);
            SETFILTER("Ending Date", '>' + tDatum + '|''''');
            IF FIND('+') THEN
                fap := "Unit Price";
            IF "Currency Code" <> '' THEN BEGIN
                CLEAR(recCurrencyExchangeRate);
                recCurrencyExchangeRate.SETRANGE("Currency Code", "Currency Code");
                IF recCurrencyExchangeRate.FINDLAST THEN
                    fap := ROUND("Unit Price" / recCurrencyExchangeRate."Exchange Rate Amount", 0.00001);  //Mit Tageskurs in EUR umrechnen
            END;
        END;
        //+GL006
    end;

    procedure ShowBelegKundenInfoBox(cKundenNr: Code[20])
    var
        recCommentLine: Record "97";
        s: Text;
    begin
        //-GL007
        //Kundenmeldung von Auftrag Rechnung und Gutschriften aufrufen
        s := '';
        recCommentLine.SETRANGE("Table Name", recCommentLine."Table Name"::Customer);
        recCommentLine.SETRANGE("No.", cKundenNr);
        recCommentLine.SETRANGE("Meldung in VK-Auftrag anzeigen", TRUE);
        IF recCommentLine.FIND('-') THEN
            REPEAT
                //-GL042
                //  IF STRLEN(s + recCommentLine.Comment) > 250 THEN
                //    s:= s + COPYSTR(recCommentLine.Comment, 1, 250 - STRLEN(s) - 5) + ' ...->'
                //  ELSE
                s := s + recCommentLine.Comment + '\';  //der backslash ersetzt #13
                                                        //+GL042
            UNTIL recCommentLine.NEXT = 0;
        IF s <> '' THEN MESSAGE(s);
        CLEAR(recCommentLine);
        //+GL007
    end;

    procedure BemerkungsmeldungAuftrag("Artikelnr.": Code[20])
    var
        Bemerkzeile: Record "97";
        BemerkungsText: Text[1000];
    begin
        //-GL035
        //Artikelbemerkungs Meldung vom Auftrag Aufrufen
        BemerkungsText := '';
        Bemerkzeile.SETCURRENTKEY("Table Name", "No.");
        Bemerkzeile.SETRANGE("Table Name", Bemerkzeile."Table Name"::Item);
        Bemerkzeile.SETRANGE("No.", "Artikelnr.");
        Bemerkzeile.SETRANGE("Meldung in VK-Auftrag anzeigen", TRUE);
        IF Bemerkzeile.FINDSET THEN BEGIN
            REPEAT
                IF Bemerkzeile.Comment <> '' THEN BEGIN
                    BemerkungsText += COPYSTR(Bemerkzeile.Comment, 1,
                      MAXSTRLEN(BemerkungsText) - STRLEN(BemerkungsText));
                    IF MAXSTRLEN(BemerkungsText) > STRLEN(BemerkungsText) THEN
                        BemerkungsText += '\';
                END;
            UNTIL Bemerkzeile.NEXT = 0;
        END;

        IF BemerkungsText <> '' THEN
            MESSAGE(COPYSTR(BemerkungsText, 1, STRLEN(BemerkungsText) - 1));
        //+GL035
    end;

    procedure BemerkungsmeldungAuftragGetText("Artikelnr.": Code[20]) BemerkungsText: Text
    var
        Bemerkzeile: Record "97";
    begin
        //-GL008
        //Artikelbemerkungs Meldung vom Auftrag Aufrufen
        BemerkungsText := '';
        Bemerkzeile.SETCURRENTKEY("Table Name", "No.");
        Bemerkzeile.SETRANGE("Table Name", Bemerkzeile."Table Name"::Item);
        Bemerkzeile.SETRANGE("No.", "Artikelnr.");
        Bemerkzeile.SETRANGE("Meldung in VK-Auftrag anzeigen", TRUE);
        IF Bemerkzeile.FINDSET THEN BEGIN
            REPEAT
                IF Bemerkzeile.Comment <> '' THEN BEGIN
                    BemerkungsText += COPYSTR(Bemerkzeile.Comment, 1,
                      MAXSTRLEN(BemerkungsText) - STRLEN(BemerkungsText));
                    IF MAXSTRLEN(BemerkungsText) > STRLEN(BemerkungsText) THEN
                        BemerkungsText += '\';
                END;
            UNTIL Bemerkzeile.NEXT = 0;
        END;

        //IF BemerkungsText <> '' THEN
        //  MESSAGE(COPYSTR(BemerkungsText,1,STRLEN(BemerkungsText)-1));
        //+GL008
    end;

    procedure GetTextTeil(tText: Text[1000]; tSeparator: Text[10]; iSektion: Integer) tReturn: Text[1000]
    var
        pos: Integer;
        iSek_lokal: Integer;
        tRet_lokal: Text[250];
    begin
        //-GL010
        //Liefert aus einem Text mit Trennzeichen einen Teilbereich
        //z.B.: GetTextTeil('aa;bbbb;cccc;d;eee;',';',3)   ->  'cccc'

        tReturn := '';
        iSek_lokal := 1;
        pos := STRPOS(tText, tSeparator);
        IF pos > 0 THEN BEGIN
            //Bis zur geforderten Sektion weitergehen (wenn vorhanden)
            REPEAT
                //Text der derzzeitigen Sektion holen
                tRet_lokal := COPYSTR(tText, 1, pos - 1);
                tText := COPYSTR(tText, pos + STRLEN(tSeparator), STRLEN(tText));

                IF iSek_lokal = iSektion THEN BEGIN
                    tReturn := tRet_lokal;
                    pos := 0;
                END ELSE BEGIN
                    //Zur nächsten Sektion wechseln
                    pos := STRPOS(tText, tSeparator);
                    iSek_lokal += 1;
                END;

            UNTIL pos = 0;
        END;
        //+GL010
    end;

    procedure BemerkungsmeldungEKRechnung(KreditorenNr: Code[20])
    var
        BemerkungsText: Text[1000];
        Bemerkzeile: Record "97";
    begin
        //-GL013
        //Artikelbemerkungs Meldung vom Auftrag Aufrufen
        BemerkungsText := '';
        Bemerkzeile.SETCURRENTKEY("Table Name", "No.");
        Bemerkzeile.SETRANGE("Table Name", Bemerkzeile."Table Name"::Vendor);
        Bemerkzeile.SETRANGE("No.", KreditorenNr);
        Bemerkzeile.SETRANGE("Meldung in Einkauf Rechnung an", TRUE);
        IF Bemerkzeile.FINDSET THEN BEGIN
            REPEAT
                IF Bemerkzeile.Comment <> '' THEN BEGIN
                    BemerkungsText += COPYSTR(Bemerkzeile.Comment, 1,
                      MAXSTRLEN(BemerkungsText) - STRLEN(BemerkungsText));
                    IF MAXSTRLEN(BemerkungsText) > STRLEN(BemerkungsText) THEN
                        BemerkungsText += '\';
                END;
            UNTIL Bemerkzeile.NEXT = 0;
        END;

        IF BemerkungsText <> '' THEN
            MESSAGE(COPYSTR(BemerkungsText, 1, STRLEN(BemerkungsText) - 1));
        //+GL013
    end;

    procedure GetLagerplatzinhaltStichtag(cLagerort: Code[10]; cLagerplatz: Code[20]; cItemNo: Code[20]; dtStichtag_: Date) nReturn: Decimal
    var
        recWarehouseEntry: Record "7312";
    begin
        //-GL015
        nReturn := 0;

        recWarehouseEntry.RESET;
        recWarehouseEntry.SETCURRENTKEY("Location Code", "Bin Code", "Item No.", "Variant Code", "Registering Date", "Lot No.");

        recWarehouseEntry.SETFILTER("Location Code", cLagerort);
        recWarehouseEntry.SETFILTER("Bin Code", cLagerplatz);
        recWarehouseEntry.SETRANGE("Item No.", cItemNo);
        recWarehouseEntry.SETFILTER("Registering Date", '..' + FORMAT(dtStichtag_));

        recWarehouseEntry.CALCSUMS("Qty. (Base)");
        nReturn := recWarehouseEntry."Qty. (Base)";

        //+GL015
    end;


    /*TODOPBA
    procedure PDFMailErstellen(recCRSalesHeader: Record "114"; recSalesInvHeader: Record "112"; tTyp: Code[20])
    var
        PurchaseHeader: Record "38";
        recCustomer: Record "18";
        recSalespersonPurchaser: Record "13";
        tFileNameFrom: Text[250];
        tFileNameTo: Text[250];
        iRenameVersuche: Integer;
        recGenLedSetup: Record "98";
        recRechnungMailversand: Record "Rechnung Mailversand";
        cuUserManagement: Codeunit "418";
        bOK: Boolean;
        recSalesInvHeader_: Record "112";
        recSalesCRHeader_: Record "114";
        iRechnungskopien_: Integer;
        tMailToAdresse: Text[100];
        recShipToAddress: Record "222";
        cuFile_: Codeunit "419";
        repGS: Report "Standard Sales - Credit Memo";
        repRech: Report "Standard Sales - Invoice";
        tPfadSpeicherort: Text[250];
        bExportBeleg: Boolean;
        //repRechExport: Report "50109";
        //repGSExport: Report "50114";
        cuNavipharma: Codeunit 50001;
    begin

        //-GL032
        //IF cuNavipharma.IsTestEnvironment() THEN
        //  ERROR('PDF-Mail im Testsystem nicht zulässig!');
        //+GL032


        bExportBeleg := FALSE;
        recCRSalesHeader.SETRANGE("No.", recCRSalesHeader."No.");
        recSalesInvHeader.SETRANGE("No.", recSalesInvHeader."No.");

        //Ist Mail Adresse zum Rechnungskunden vorhanden?
        IF tTyp = 'GUTSCHRIFT' THEN BEGIN
            IF recCRSalesHeader."Responsibility Center" = 'EXPORT' THEN bExportBeleg := TRUE;  //GL028

            bOK := recCustomer.GET(recCRSalesHeader."Bill-to Customer No.");
            tMailToAdresse := recCustomer."E-Mail";
            //Rechnung an Code abfangen
            IF STRLEN(recCRSalesHeader."Bill-to Code") > 0 THEN BEGIN
                IF recShipToAddress.GET(recCRSalesHeader."Sell-to Customer No.", recCRSalesHeader."Bill-to Code") THEN
                    tMailToAdresse := recShipToAddress."E-Mail";
            END;
        END;
        IF tTyp = 'RECHNUNG' THEN BEGIN
            IF recSalesInvHeader."Responsibility Center" = 'EXPORT' THEN bExportBeleg := TRUE;  //GL028

            bOK := recCustomer.GET(recSalesInvHeader."Bill-to Customer No.");
            tMailToAdresse := recCustomer."E-Mail";
            //Rechnung an Code abfangen
            IF STRLEN(recSalesInvHeader."Bill-to Code") > 0 THEN BEGIN
                IF recShipToAddress.GET(recSalesInvHeader."Sell-to Customer No.", recSalesInvHeader."Bill-to Code") THEN
                    tMailToAdresse := recShipToAddress."E-Mail";
            END;
        END;



        IF bOK = TRUE THEN BEGIN   //Bill-to Customer No.
            IF STRLEN(tMailToAdresse) > 0 THEN BEGIN

                //-GL022
                //Variante mit NAV-PDF-erstellung

                //Dateipfade am Server
                recGenLedSetup.GET;

                //-GL028    //Export oder Inland Speicherort
                tPfadSpeicherort := recGenLedSetup.PDFPfad;
                IF bExportBeleg = TRUE THEN
                    tPfadSpeicherort := recGenLedSetup.PDFPfadExport;
                //+GL028

                IF STRLEN(tPfadSpeicherort) = 0 THEN
                    ERROR('Kein Speicherpfad definiert!');

                IF tTyp = 'GUTSCHRIFT' THEN
                    tFileNameTo := tPfadSpeicherort + GetWFScompatibleString(recCRSalesHeader."No.") + '.pdf';
                IF tTyp = 'RECHNUNG' THEN
                    tFileNameTo := tPfadSpeicherort + GetWFScompatibleString(recSalesInvHeader."No.") + '.pdf';

                //Speichern nur am \\Server1\Export zulassen -> Lokal müsste ein Stream Download gemacht werden
                IF (COPYSTR(tFileNameTo, 1, 9) = '\\server1') OR (COPYSTR(tFileNameTo, 1, 9) = '\\SERVER1') THEN BEGIN

                    //Existiert die PDF Datei schon? -> Dann löschen!
                    IF cuFile_.ServerFileExists(tFileNameTo) = TRUE THEN
                        cuFile_.DeleteServerFile(tFileNameTo);

                    bOK := FALSE;  //Bool Variable wieder benutzer

                    //PDF erstellen
                    IF tTyp = 'GUTSCHRIFT' THEN BEGIN
                        //Gutschriftkopien auf 0 Stellen
                        CLEAR(recSalesCRHeader_);
                        IF recSalesCRHeader_.GET(recCRSalesHeader."No.") THEN BEGIN
                            iRechnungskopien_ := recSalesCRHeader_."invoice copies";
                            recSalesCRHeader_."invoice copies" := 0;  //Keine Rechnungskopien in PDF erstellen
                            recSalesCRHeader_.MODIFY;
                        END;
                        //-GL028
                        IF bExportBeleg = TRUE THEN BEGIN
                            repGSExport.SETTABLEVIEW(recCRSalesHeader);  //Datensatz dem Bericht zuweisen
                            IF repGSExport.SAVEASPDF(tFileNameTo) = TRUE THEN
                                bOK := TRUE;
                        END ELSE BEGIN
                            repGS.SETTABLEVIEW(recCRSalesHeader);  //Datensatz dem Bericht zuweisen
                            IF repGS.SAVEASPDF(tFileNameTo) = TRUE THEN
                                bOK := TRUE;
                        END;
                        //+GL028
                    END;

                    IF tTyp = 'RECHNUNG' THEN BEGIN

                        //Rechnungskopien auf 0 Stellen
                        CLEAR(recSalesInvHeader_);
                        IF recSalesInvHeader_.GET(recSalesInvHeader."No.") THEN BEGIN
                            iRechnungskopien_ := recSalesInvHeader_."invoice copies";
                            recSalesInvHeader_."invoice copies" := 0;  //Keine Rechnungskopien in PDF erstellen
                            recSalesInvHeader_.MODIFY;
                        END;
                        //-GL028
                        IF bExportBeleg = TRUE THEN BEGIN
                            repRechExport.SETTABLEVIEW(recSalesInvHeader);  //Datensatz dem Bericht zuweisen
                            IF repRechExport.SAVEASPDF(tFileNameTo) = TRUE THEN
                                bOK := TRUE;
                        END ELSE BEGIN
                            repRech.SETTABLEVIEW(recSalesInvHeader);  //Datensatz dem Bericht zuweisen
                            IF repRech.SAVEASPDF(tFileNameTo) = TRUE THEN
                                bOK := TRUE;
                        END;
                        //+GL028
                    END;

                    //Rechnung-/Gutschriftskopien wieder auf vorherigen Wert stellen
                    IF tTyp = 'GUTSCHRIFT' THEN BEGIN
                        recSalesCRHeader_.GET(recSalesCRHeader_."No.");
                        recSalesCRHeader_."invoice copies" := iRechnungskopien_;
                        recSalesCRHeader_.MODIFY;
                    END;
                    IF tTyp = 'RECHNUNG' THEN BEGIN
                        recSalesInvHeader_.GET(recSalesInvHeader_."No.");
                        recSalesInvHeader_."invoice copies" := iRechnungskopien_;
                        recSalesInvHeader_.MODIFY;
                    END;


                    IF bOK = TRUE THEN BEGIN
                        IF cuFile_.ServerFileExists(tFileNameTo) = FALSE THEN
                            ERROR('PDF-Bestellung %1 wurde nicht erstellt!', tFileNameTo);

                        //PDF vorhanFden -> Mailversand an Kunde wenn Datei erstellt wurde
                        //Eintragen von Mailversand Informationen in einer Tabelle
                        CLEAR(recRechnungMailversand);
                        recRechnungMailversand.INIT;
                        recRechnungMailversand.EMailEmpfaenger := tMailToAdresse;
                        recRechnungMailversand.Versendet := FALSE;
                        IF tTyp = 'GUTSCHRIFT' THEN BEGIN
                            recRechnungMailversand."Invoice No" := recCRSalesHeader."No.";
                            recRechnungMailversand.Buchungsdatum := recCRSalesHeader."Posting Date";
                            recRechnungMailversand.RechKdnNr := recCRSalesHeader."Bill-to Customer No.";
                        END;
                        IF tTyp = 'RECHNUNG' THEN BEGIN
                            recRechnungMailversand."Invoice No" := recSalesInvHeader."No.";
                            recRechnungMailversand.Buchungsdatum := recSalesInvHeader."Posting Date";
                            recRechnungMailversand.RechKdnNr := recSalesInvHeader."Bill-to Customer No.";
                        END;

                        recRechnungMailversand.INSERT;
                        COMMIT;  //Damit RUNMODAL funktioniert

                        //CLEAR(recRechnungMailversand);
                        recRechnungMailversand.FILTERGROUP(2); //Versteckte Filter
                                                               //recRechnungMailversand.SETRANGE(Buchungsdatum,PostingDateReq);
                        recRechnungMailversand.SETRANGE(Versendet, FALSE);
                        recRechnungMailversand.FILTERGROUP(0);
                        PAGE.RUNMODAL(50188, recRechnungMailversand);



                    END ELSE
                        ERROR('Das PDF %1 konnte nicht erstellt werden!', tFileNameTo);

                END ELSE
                    ERROR('PDF-Datei kann nur am Server1 erstellt werden!');

                /*
                //Variante mit lokal Installierten PDF-Drucker
                IF recSalespersonPurchaser.GET(USERID) THEN BEGIN

                  recSalespersonPurchaser.PrintPDF := TRUE;
                  recSalespersonPurchaser.MODIFY;

                  //PDF erstellen
                  IF tTyp = 'GUTSCHRIFT' THEN BEGIN
                    //Gutschriftkopien auf 0 Stellen
                    CLEAR(recSalesCRHeader_);
                    IF recSalesCRHeader_.GET(recCRSalesHeader."No.") THEN BEGIN
                      iRechnungskopien_ := recSalesCRHeader_."invoice copies";
                      recSalesCRHeader_."invoice copies" := 0;  //Keine Rechnungskopien in PDF erstellen
                      recSalesCRHeader_.MODIFY;
                    END;

                    REPORT.RUN(207,FALSE,FALSE,recCRSalesHeader);
                  END;

                  IF tTyp = 'RECHNUNG' THEN BEGIN

                    //Rechnungskopien auf 0 Stellen
                    CLEAR(recSalesInvHeader_);
                    IF recSalesInvHeader_.GET(recSalesInvHeader."No.") THEN BEGIN
                      iRechnungskopien_ := recSalesInvHeader_."invoice copies";
                      recSalesInvHeader_."invoice copies" := 0;  //Keine Rechnungskopien in PDF erstellen
                      recSalesInvHeader_.MODIFY;
                    END;

                    REPORT.RUN(206,FALSE,FALSE,recSalesInvHeader);
                  END;

                  recSalespersonPurchaser.PrintPDF := FALSE;
                  recSalespersonPurchaser.MODIFY;


                  //Rechnung-/Gutschriftskopien wieder auf vorherigen Wert stellen
                  IF tTyp = 'GUTSCHRIFT' THEN BEGIN
                    recSalesCRHeader_.GET(recSalesCRHeader_."No.");
                    recSalesCRHeader_."invoice copies" := iRechnungskopien_;
                    recSalesCRHeader_.MODIFY;
                  END;
                  IF tTyp = 'RECHNUNG' THEN BEGIN
                    recSalesInvHeader_.GET(recSalesInvHeader_."No.");
                    recSalesInvHeader_."invoice copies" := iRechnungskopien_;
                    recSalesInvHeader_.MODIFY;
                  END;


                  //Dateinamen des erstellten PDF's definieren  (PDF-Drucker muss richtig eingerichtet sein, das der Ausgabename unterschiedlich ist: "%DOCNAME%" bei EDocPrintPro)
                  recGenLedSetup.GET;
                  IF tTyp = 'RECHNUNG' THEN
                    tFileNameFrom := recGenLedSetup.PDFPfad+ 'Verkauf - Rechnung.pdf';
                  IF tTyp = 'GUTSCHRIFT' THEN
                    tFileNameFrom := recGenLedSetup.PDFPfad+ 'Verkauf - Gutschrift.pdf';

                  IF tTyp = 'GUTSCHRIFT' THEN
                    tFileNameTo := recGenLedSetup.PDFPfad+ GetWFScompatibleString(recCRSalesHeader."No.")+'.pdf';
                  IF tTyp = 'RECHNUNG' THEN
                    tFileNameTo := recGenLedSetup.PDFPfad+ GetWFScompatibleString(recSalesInvHeader."No.")+'.pdf';

                  CREATE(WSHFile,TRUE,TRUE);

                  //Ist die Datei schon vorhanden? Kann bei Ändern einer Bestellung und neu erstellen sein. Wenn vorhanden dann löschen
                  IF WSHFile.FileExists(tFileNameTo) THEN BEGIN
                    WSHFile.DeleteFile(tFileNameTo);
                  END;

                  //PDF-erstellung etwas Zeit geben
                  SLEEP(4000);

                  //Datei umbenennen
                  IF WSHFile.FileExists(tFileNameFrom) THEN BEGIN

                    iRenameVersuche := 0;
                    REPEAT
                      SLEEP(1000);
                      iRenameVersuche += 1;
                      WSHFile.MoveFile(tFileNameFrom, tFileNameTo)
                    UNTIL (WSHFile.FileExists(tFileNameTo)) OR (iRenameVersuche>30);   //20 sec maximal warten   -> auf 30 erweitert

                    //Ist die PDFGutschrift erstellt worden?
                    IF WSHFile.FileExists(tFileNameTo) THEN BEGIN

                      //Eintragen von Mailversand Informationen in einer Tabelle
                      CLEAR(recRechnungMailversand);
                      recRechnungMailversand.INIT;
                      recRechnungMailversand.EMailEmpfaenger := tMailToAdresse;
                      recRechnungMailversand.Versendet := FALSE;
                      IF tTyp = 'GUTSCHRIFT' THEN BEGIN
                        recRechnungMailversand."Invoice No" := recCRSalesHeader."No.";
                        recRechnungMailversand.Buchungsdatum := recCRSalesHeader."Posting Date";
                        recRechnungMailversand.RechKdnNr := recCRSalesHeader."Bill-to Customer No.";
                      END;
                      IF tTyp = 'RECHNUNG' THEN BEGIN
                        recRechnungMailversand."Invoice No" := recSalesInvHeader."No.";
                        recRechnungMailversand.Buchungsdatum := recSalesInvHeader."Posting Date";
                        recRechnungMailversand.RechKdnNr := recSalesInvHeader."Bill-to Customer No.";
                      END;

                      recRechnungMailversand.INSERT;
                      COMMIT;  //Damit RUNMODAL funktioniert

                      //CLEAR(recRechnungMailversand);
                      recRechnungMailversand.FILTERGROUP(2); //Versteckte Filter
                      //recRechnungMailversand.SETRANGE(Buchungsdatum,PostingDateReq);
                      recRechnungMailversand.SETRANGE(Versendet,FALSE);
                      recRechnungMailversand.FILTERGROUP(0);
                      PAGE.RUNMODAL(50188,recRechnungMailversand);

                    END ELSE BEGIN
                      MESSAGE('PDF-Gutschrift %1 wurde nicht erstellt!', tFileNameTo);
                    END;

                  END ELSE BEGIN
            //        CREATE(WSHFile,TRUE,TRUE);
            //        IF WSHFile.FileExists(tFileNameFrom) THEN
            //          MESSAGE('Doch gefunden!')
            //        ELSE
                      MESSAGE('PDF-Gutschrift %1 wurde nicht gefunden!', tFileNameFrom);
                  END;

                  CLEAR(WSHFile);

                  recSalespersonPurchaser.PrintPDF := FALSE;
                  recSalespersonPurchaser.MODIFY;

                  COMMIT;
                  //Rec.FINDLAST;
                  //CurrForm.UPDATE;

                END ELSE
                  MESSAGE('Verkaufsperson Einrichtung für Benutzer %1 nicht vorhanden!', USERID);
            
                //+GL022

            END ELSE
                MESSAGE('E-Mail Adresse zu Rechnungskunde nicht vorhanden!');
        END ELSE
            MESSAGE('Rechnungskunde wurde nicht gefunden!');

    end;
    */

    procedure "Bestellzeile Kopieren"(Einkaufszeile: Record "39")
    var
        EinkZeile: Record "39";
        EinkZeile2: Record "39";
        "NächsteZeile": Integer;
        NeueZeile: Integer;
    begin
        //-UPDATE2013

        EinkZeile.INIT;
        EinkZeile.COPY(Einkaufszeile);
        EinkZeile2.INIT;
        EinkZeile2.SETRANGE("Document Type", Einkaufszeile."Document Type");
        EinkZeile2.SETRANGE("Document No.", Einkaufszeile."Document No.");
        EinkZeile2.SETFILTER("Line No.", '>%1', Einkaufszeile."Line No.");
        IF EinkZeile2.FIND('-') THEN BEGIN
            NächsteZeile := EinkZeile2."Line No.";
            NeueZeile := ROUND((NächsteZeile + Einkaufszeile."Line No.") / 2, 1)
        END ELSE
            NeueZeile := Einkaufszeile."Line No." + 10000;

        EinkZeile."Line No." := NeueZeile;
        EinkZeile."Qty. Rcd. Not Invoiced" := 0;
        EinkZeile."Amt. Rcd. Not Invoiced" := 0;
        EinkZeile."Quantity Received" := 0;
        EinkZeile."Quantity Invoiced" := 0;
        EinkZeile."Qty. Rcd. Not Invoiced (Base)" := 0;
        EinkZeile."Qty. Received (Base)" := 0;
        EinkZeile."Qty. Invoiced (Base)" := 0;
        EinkZeile."Quantity (Base)" := 0;
        EinkZeile."Urspr. Menge" := 0;
        EinkZeile."Receipt No." := '';
        EinkZeile."Receipt Line No." := 0;
        EinkZeile.VALIDATE(Quantity, 0);
        EinkZeile."Lot No." := '';
        EinkZeile."Verkaufschargennr." := '';
        EinkZeile."Expiration Date" := 0D;
        EinkZeile.INSERT;
        EinkZeile.VALIDATE("Shortcut Dimension 1 Code");
        EinkZeile.MODIFY;

        //+UPDATE2013
    end;

    procedure IsTextInTextTeil(tText: Text[1000]; tSeparator: Text[10]; tSearchText: Text[20]) bReturn: Boolean
    var
        pos: Integer;
        iSek_lokal: Integer;
        tRet_lokal: Text[250];
    begin

        //-GL017
        //Liefert aus einem Text mit Trennzeichen, ob ein Text in einem Teil ist
        //z.B.: IsTextInTextTeil('aa;bbbb;cccc;d;eee;',';','cccc')   ->  TRUE

        bReturn := FALSE;
        iSek_lokal := 1;
        pos := STRPOS(tText, tSeparator);
        IF pos > 0 THEN BEGIN
            //Bis zur Sektion mit dem Suchtext weitergehen
            REPEAT
                //Text der derzzeitigen Sektion holen
                tRet_lokal := COPYSTR(tText, 1, pos - 1);
                tText := COPYSTR(tText, pos + STRLEN(tSeparator), STRLEN(tText));

                IF tRet_lokal = tSearchText THEN BEGIN
                    bReturn := TRUE;
                    pos := 0;
                END ELSE BEGIN
                    //Zur nächsten Sektion wechseln
                    pos := STRPOS(tText, tSeparator);
                    iSek_lokal += 1;
                END;

            UNTIL pos = 0;
        END;
        IF tText = tSearchText THEN //Gleich ohne Trennzeichen
            bReturn := TRUE;
        //+GL017
    end;


    procedure TextAuffuellen(tText: Text[50]; iLaenge: Integer; tFuellzeichen: Text[1]) tReturn: Text[50]
    var
        iCounter: Integer;
    begin
        //-GL023
        //Füllt einen Text mit einem Textzeichen vorne sollange auf, bis die gewünschte Textlänge erreicht ist
        //Z.B.: 12 -> 00012

        tReturn := tText;
        iCounter := STRLEN(tText);
        IF (iCounter < iLaenge) THEN BEGIN
            REPEAT
                tReturn := tFuellzeichen + tReturn;
                iCounter += 1;
            UNTIL iCounter >= iLaenge   //GL030 vorher:   iCounter>iLaenge
        END;
        //+GL023
    end;

    procedure RemoveChars(BCText: Text[250]; iCharAsciiCode: Integer) tBCReturn: Text[250]
    var
        iCounter: Integer;
    begin
        //-GL024
        iCounter := 1;
        WHILE iCounter <= STRLEN(BCText) DO BEGIN
            IF NOT (BCText[iCounter] = iCharAsciiCode) THEN
                tBCReturn += COPYSTR(BCText, iCounter, 1);
            iCounter += 1;
        END;
        //+GL024
    end;

    procedure KWInDatum(iKW: Integer; iJahr: Integer) dtReturn: Date
    var
        dtHelp: Date;
        iKWHelp: Integer;
    begin
        //-GL025

        //Jahresanfang ermitteln
        //dtHelp := CALCDATE('-LJ',TODAY);
        EVALUATE(dtHelp, '01.01.' + FORMAT(iJahr));

        //Zur Ermittlung, ob 01.01 diesen Jahres KW1 oder KW53 ist
        EVALUATE(iKWHelp, FORMAT(dtHelp, 0, '<Week,2><Filler Character,0>'));

        IF iKWHelp = 1 THEN
            dtReturn := CALCDATE('+' + FORMAT(iKW - 1) + 'W', dtHelp)
        ELSE
            dtReturn := CALCDATE('+' + FORMAT(iKW) + 'W', dtHelp);

        //Auf Wochenanfang konvertieren
        dtReturn := CALCDATE('-LW', dtReturn);
        //+GL025
    end;
    /* TODOPBA
    procedure PDFLieferFTPSenden(recSalesShipHeader: Record "110")
    var
        PurchaseHeader: Record "38";
        ApprovalMgt: Codeunit "439";
        recCustomer: Record "18";
        recSalespersonPurchaser: Record "13";
        tFileNameFrom: Text[250];
        tFileNameTo: Text[250];
        iRenameVersuche: Integer;
        recGenLedSetup: Record "98";
        recRechnungMailversand: Record "50080";
        cuUserManagement: Codeunit "418";
        WSHFile: Automation;
        bOK: Boolean;
        recSalesHeader_: Record "36";
        iLieferkopien_: Integer;
        tMailToAdresse: Text[100];
        recShipToAddress: Record "222";
        cuFile_: Codeunit "419";
        repShip: Report "208";
        FTPRequest: DotNet FileWebRequest;
        FTPResponse: DotNet FtpWebResponse;
        UTF8Encoding: DotNet UTF8Encoding;
        RequestStream: DotNet Stream;
        NetworkCredential: DotNet NetworkCredential;
        ConnectionString: Text;
        SourceText: Text;
    begin
        //-GL026
        //Für GL-DE

        recSalesShipHeader.SETRANGE("No.", recSalesShipHeader."No.");


        bOK := recCustomer.GET(recSalesShipHeader."Bill-to Customer No.");
        //tMailToAdresse := 'martin.fuerbass@gl-pharma.at';  //Mail Addresse der AEP-Auslieferung?  //recCustomer."E-Mail";


        IF bOK = TRUE THEN BEGIN
            //IF STRLEN(tMailToAdresse)>0 THEN BEGIN

            //Variante mit NAV-PDF-erstellung

            //Dateipfad am Server
            recGenLedSetup.GET;
            IF STRLEN(recGenLedSetup.PDFPfad) = 0 THEN
                ERROR('Kein Speicherpfad definiert!');

            tFileNameTo := recGenLedSetup.PDFPfad + GetWFScompatibleString(recSalesShipHeader."No.") + '.pdf';

            //Speichern nur am \\Server1\Export zulassen -> Lokal müsste ein Stream Download gemacht werden
            IF (COPYSTR(tFileNameTo, 1, 9) = '\\server1') OR (COPYSTR(tFileNameTo, 1, 9) = '\\SERVER1') THEN BEGIN

                //Existiert die PDF Datei schon? -> Dann löschen!
                IF cuFile_.ServerFileExists(tFileNameTo) = TRUE THEN
                    cuFile_.DeleteServerFile(tFileNameTo);

                bOK := FALSE;  //Bool Variable wieder benutzer

                //PDF erstellen
                //Liefercopien im SalesHeader auf 0 Stellen
                CLEAR(recSalesHeader_);
                IF recSalesHeader_.GET(recSalesHeader_."Document Type"::Order, recSalesShipHeader."Order No.") THEN BEGIN
                    iLieferkopien_ := recSalesHeader_."shipment copies";
                    recSalesHeader_."shipment copies" := 0;  //Keine Rechnungskopien in PDF erstellen
                    recSalesHeader_.MODIFY;
                END;

                repShip.SETTABLEVIEW(recSalesShipHeader);  //Datensatz dem Bericht zuweisen
                IF repShip.SAVEASPDF(tFileNameTo) = TRUE THEN
                    bOK := TRUE;

                recSalesHeader_.GET(recSalesHeader_."Document Type"::Order, recSalesShipHeader."Order No.");
                recSalesHeader_."shipment copies" := iLieferkopien_;
                recSalesHeader_.MODIFY;


                IF bOK = TRUE THEN BEGIN
                    IF cuFile_.ServerFileExists(tFileNameTo) = FALSE THEN
                        ERROR('PDF-Bestellung %1 wurde nicht erstellt!', tFileNameTo);

                    //PDF vorhanden -> FTP-Upload machen
                    //ConnectionString := 'sftp:\\u74138658.1and1-data.host';
                    //SourceText := 'test';








                END ELSE
                    ERROR('Das PDF %1 konnte nicht erstellt werden!', tFileNameTo);

            END ELSE
                ERROR('PDF-Datei kann nur am Server1 erstellt werden!');

            //END ELSE
            //  MESSAGE('E-Mail Adresse zu Rechnungskunde nicht vorhanden!');
        END ELSE
            MESSAGE('Rechnungskunde wurde nicht gefunden!');

        //-GL026
    end;
   
    procedure PDFLieferMailSenden(recSalesShipHeader: Record "110")
    var
        PurchaseHeader: Record "38";
        ApprovalMgt: Codeunit "439";
        recCustomer: Record "18";
        recSalespersonPurchaser: Record "13";
        tFileNameFrom: Text[250];
        tFileNameTo: Text[250];
        iRenameVersuche: Integer;
        recGenLedSetup: Record "98";
        recRechnungMailversand: Record "50080";
        cuUserManagement: Codeunit "418";
        WSHFile: Automation;
        bOK: Boolean;
        recSalesHeader_: Record "36";
        iLieferkopien_: Integer;
        tMailToAdresse: Text[100];
        recShipToAddress: Record "222";
        cuFile_: Codeunit "419";
        repShip: Report "208";
    begin
        //-GL026
        //Für GL-DE

        recSalesShipHeader.SETRANGE("No.", recSalesShipHeader."No.");

        bOK := recCustomer.GET(recSalesShipHeader."Bill-to Customer No.");
        tMailToAdresse := 'martin.fuerbass@gl-pharma.at';  //Mail Addresse der AEP-Auslieferung?  //recCustomer."E-Mail";

        IF bOK = TRUE THEN BEGIN
            IF STRLEN(tMailToAdresse) > 0 THEN BEGIN

                //Variante mit NAV-PDF-erstellung

                //Dateipfad am Server
                recGenLedSetup.GET;
                IF STRLEN(recGenLedSetup.PDFPfad) = 0 THEN
                    ERROR('Kein Speicherpfad definiert!');

                tFileNameTo := recGenLedSetup.PDFPfad + GetWFScompatibleString(recSalesShipHeader."No.") + '.pdf';

                //Speichern nur am \\Server1\Export zulassen -> Lokal müsste ein Stream Download gemacht werden
                IF (COPYSTR(tFileNameTo, 1, 9) = '\\server1') OR (COPYSTR(tFileNameTo, 1, 9) = '\\SERVER1') THEN BEGIN

                    //Existiert die PDF Datei schon? -> Dann löschen!
                    IF cuFile_.ServerFileExists(tFileNameTo) = TRUE THEN
                        cuFile_.DeleteServerFile(tFileNameTo);

                    bOK := FALSE;  //Bool Variable wieder benutzer

                    //PDF erstellen
                    //Liefercopien im SalesHeader auf 0 Stellen
                    CLEAR(recSalesHeader_);
                    IF recSalesHeader_.GET(recSalesHeader_."Document Type"::Order, recSalesShipHeader."Order No.") THEN BEGIN
                        iLieferkopien_ := recSalesHeader_."shipment copies";
                        recSalesHeader_."shipment copies" := 0;  //Keine Rechnungskopien in PDF erstellen
                        recSalesHeader_.MODIFY;
                    END;

                    repShip.SETTABLEVIEW(recSalesShipHeader);  //Datensatz dem Bericht zuweisen
                    IF repShip.SAVEASPDF(tFileNameTo) = TRUE THEN
                        bOK := TRUE;

                    recSalesHeader_.GET(recSalesHeader_."Document Type"::Order, recSalesShipHeader."Order No.");
                    recSalesHeader_."shipment copies" := iLieferkopien_;
                    recSalesHeader_.MODIFY;


                    IF bOK = TRUE THEN BEGIN
                        IF cuFile_.ServerFileExists(tFileNameTo) = FALSE THEN
                            ERROR('PDF-Bestellung %1 wurde nicht erstellt!', tFileNameTo);

                        //PDF vorhanden -> Mailversand an Kunde wenn Datei erstellt wurde
                        //Eintragen von Mailversand Informationen in einer Tabelle
                        CLEAR(recRechnungMailversand);
                        recRechnungMailversand.INIT;
                        recRechnungMailversand.EMailEmpfaenger := tMailToAdresse;
                        recRechnungMailversand.Versendet := FALSE;

                        recRechnungMailversand."Invoice No" := recSalesShipHeader."No.";
                        recRechnungMailversand.Buchungsdatum := recSalesShipHeader."Posting Date";
                        recRechnungMailversand.RechKdnNr := recSalesShipHeader."Sell-to Customer No.";

                        recRechnungMailversand.INSERT;
                        COMMIT;  //Damit RUNMODAL funktioniert

                        //CLEAR(recRechnungMailversand);
                        recRechnungMailversand.FILTERGROUP(2); //Versteckte Filter
                                                               //recRechnungMailversand.SETRANGE(Buchungsdatum,PostingDateReq);
                        recRechnungMailversand.SETRANGE(Versendet, FALSE);
                        recRechnungMailversand.FILTERGROUP(0);
                        PAGE.RUNMODAL(50188, recRechnungMailversand);

                    END ELSE
                        ERROR('Das PDF %1 konnte nicht erstellt werden!', tFileNameTo);

                END ELSE
                    ERROR('PDF-Datei kann nur am Server1 erstellt werden!');

            END ELSE
                MESSAGE('E-Mail Adresse zu Rechnungskunde nicht vorhanden!');
        END ELSE
            MESSAGE('Rechnungskunde wurde nicht gefunden!');

        //-GL026
    end;
 */

    procedure EKBemerkungsmeldung(cKredNo: Code[20])
    var
        BemerkungsText: Text[250];
        Bemerkzeile: Record "97";
    begin
        //-GL028
        BemerkungsText := '';
        Bemerkzeile.SETCURRENTKEY("Table Name", Code, Date, "Meldung in Bestellung anzeigen");
        Bemerkzeile.SETRANGE("Table Name", Bemerkzeile."Table Name"::Vendor);
        Bemerkzeile.SETRANGE("No.", cKredNo);
        Bemerkzeile.SETRANGE("Meldung in Bestellung anzeigen", TRUE);
        IF Bemerkzeile.FIND('-') THEN BEGIN
            REPEAT
                IF Bemerkzeile.Comment <> '' THEN BEGIN
                    BemerkungsText += COPYSTR(Bemerkzeile.Comment, 1,
                      MAXSTRLEN(BemerkungsText) - STRLEN(BemerkungsText));
                    IF MAXSTRLEN(BemerkungsText) > STRLEN(BemerkungsText) THEN
                        BemerkungsText += '\';
                END;
            UNTIL Bemerkzeile.NEXT = 0;

            IF BemerkungsText <> '' THEN
                MESSAGE(COPYSTR(BemerkungsText, 1, STRLEN(BemerkungsText) - 1));

        END;
        //+GL028
    end;


    procedure GetWFScompatibleString(tOriginal: Text[250]) tFormatted: Text[250]
    var
        tTemp: Text[250];
    begin
        //-GL034
        tTemp := CONVERTSTR(tOriginal, '<', '-');
        tTemp := CONVERTSTR(tTemp, '>', '-');
        tTemp := CONVERTSTR(tTemp, ':', '.');
        tTemp := CONVERTSTR(tTemp, '"', '_');
        tTemp := CONVERTSTR(tTemp, '/', '_');
        tTemp := CONVERTSTR(tTemp, '\', '_');
        tTemp := CONVERTSTR(tTemp, '|', '-');
        tTemp := CONVERTSTR(tTemp, '?', '_');
        tTemp := CONVERTSTR(tTemp, '*', '_');
        tFormatted := tTemp;
        //+GL034
    end;

    procedure RemoveBadChars(BCText: Text[250]) tBCReturn: Text[250]
    var
        iCounter: Integer;
    begin

        iCounter := 1;
        WHILE iCounter <= STRLEN(BCText) DO BEGIN
            IF NOT ((BCText[iCounter] = 9) OR (BCText[iCounter] = 13) OR (BCText[iCounter] = 10)) THEN
                tBCReturn += COPYSTR(BCText, iCounter, 1);
            iCounter += 1;
        END;
    end;

    procedure BemerkungsmeldungUmlagerung("Artikelnr.": Code[20])
    var
        Bemerkzeile: Record "97";
        BemerkungsText: Text[1000];
    begin
        //-GL036
        //Artikelbemerkungs Meldung Umlagerung
        BemerkungsText := '';
        Bemerkzeile.SETCURRENTKEY("Table Name", "No.");
        Bemerkzeile.SETRANGE("Table Name", Bemerkzeile."Table Name"::Item);
        Bemerkzeile.SETRANGE("No.", "Artikelnr.");
        Bemerkzeile.SETRANGE("Meldung bei Umlagerung", TRUE);
        IF Bemerkzeile.FINDSET THEN BEGIN
            REPEAT
                IF Bemerkzeile.Comment <> '' THEN BEGIN
                    BemerkungsText += COPYSTR(Bemerkzeile.Comment, 1,
                      MAXSTRLEN(BemerkungsText) - STRLEN(BemerkungsText));
                    IF MAXSTRLEN(BemerkungsText) > STRLEN(BemerkungsText) THEN
                        BemerkungsText += '\';
                END;
            UNTIL Bemerkzeile.NEXT = 0;
        END;

        IF BemerkungsText <> '' THEN
            MESSAGE(COPYSTR(BemerkungsText, 1, STRLEN(BemerkungsText) - 1));
        //+GL036
    end;
    /*
    procedure PDFMailBestellungErstellen(recPurchHeader: Record "38"; tTyp: Code[20]; bSuppressWindow: Boolean)
    var
        PurchaseHeader: Record "38";
        recVendor: Record "23";
        recSalespersonPurchaser: Record "13";
        tFileNameFrom: Text[250];
        tFileNameTo: Text[250];
        iRenameVersuche: Integer;
        recGenLedSetup: Record "98";
        recBestellungMailversand: Record "50091";
        cuUserManagement: Codeunit "418";
        WSHFile: Automation;
        bOK: Boolean;
        recPurchHeaderLocal: Record "38";
        iRechnungskopien_: Integer;
        tMailToAdresse: Text[100];
        recShipToAddress: Record "222";
        cuFile_: Codeunit "419";
        tPfadSpeicherort: Text[250];
        cuNavipharma: Codeunit "50506";
        repOrder: Report "405";
        bProceed: Boolean;
    begin
        //-GL037
        //-GL032
        //IF cuNavipharma.IsTestEnvironment() THEN
        //  ERROR('PDF-Mail im Testsystem nicht zulässig!');
        //+GL032
        recPurchHeader.SETRANGE("No.", recPurchHeader."No.");

        bOK := recVendor.GET(recPurchHeader."Buy-from Vendor No.");
        IF recVendor.Bestellemail = '' THEN
            IF DIALOG.CONFIRM('Kreditor %1 hat keine Bestell-Email hinterlegt. Kontakt Email (%2) verwenden?', FALSE, recPurchHeader."Buy-from Vendor No.", recVendor."E-Mail") THEN
                tMailToAdresse := recVendor."E-Mail"
            ELSE
                EXIT
        ELSE
            tMailToAdresse := recVendor.Bestellemail;

        IF bOK = TRUE THEN BEGIN   //Buy-From Vendor No.
            IF STRLEN(tMailToAdresse) > 0 THEN BEGIN
                //Dateipfade am Server
                recGenLedSetup.GET;
                tPfadSpeicherort := recGenLedSetup.PDFPfadEK;

                IF STRLEN(tPfadSpeicherort) = 0 THEN
                    ERROR('Kein Speicherpfad definiert!');

                tFileNameTo := tPfadSpeicherort + GetWFScompatibleString(recPurchHeader."No.") + '.pdf';

                //Speichern nur am \\Server1\Export zulassen -> Lokal müsste ein Stream Download gemacht werden
                IF (COPYSTR(tFileNameTo, 1, 9) = '\\server1') OR (COPYSTR(tFileNameTo, 1, 9) = '\\SERVER1') THEN BEGIN

                    //Existiert die PDF Datei schon? -> Dann löschen!
                    IF cuFile_.ServerFileExists(tFileNameTo) = TRUE THEN
                        cuFile_.DeleteServerFile(tFileNameTo);

                    bOK := FALSE;  //Bool Variable wieder benutzen
                    repOrder.SETTABLEVIEW(recPurchHeader);  //Datensatz dem Bericht zuweisen
                    IF repOrder.SAVEASPDF(tFileNameTo) = TRUE THEN
                        bOK := TRUE;
                    //+GL028
                    IF bOK = TRUE THEN BEGIN
                        IF cuFile_.ServerFileExists(tFileNameTo) = FALSE THEN
                            ERROR('PDF-Bestellung %1 wurde nicht erstellt!', tFileNameTo);

                        //PDF vorhanden -> Mailversand an Kunde wenn Datei erstellt wurde
                        //Eintragen von Mailversand Informationen in einer Tabelle
                        bProceed := TRUE;
                        recBestellungMailversand.SETRANGE("Order No", recPurchHeader."No.");
                        IF recBestellungMailversand.FIND('-') THEN BEGIN
                            bProceed := FALSE;
                            IF recBestellungMailversand.Versendet = FALSE THEN BEGIN
                                recBestellungMailversand.DELETE;
                                bProceed := TRUE;
                            END
                            ELSE BEGIN
                                IF DIALOG.CONFIRM('Zu Bestellung %1 wurde bereits ein Mail versandt. Erneut erstellen?', TRUE, recPurchHeader."No.") THEN BEGIN
                                    recBestellungMailversand.DELETE;
                                    bProceed := TRUE;
                                END;
                            END;
                        END;

                        IF bProceed THEN BEGIN
                            CLEAR(recBestellungMailversand);
                            recBestellungMailversand.INIT;
                            recBestellungMailversand.EMailEmpfaenger := tMailToAdresse;
                            recBestellungMailversand.Versendet := FALSE;
                            recBestellungMailversand."Order No" := recPurchHeader."No.";
                            recBestellungMailversand.Buchungsdatum := recPurchHeader."Posting Date";
                            recBestellungMailversand.BestellKdnNr := recPurchHeader."Buy-from Vendor No.";
                            recBestellungMailversand."Language Code" := recPurchHeader."Language Code";
                            recBestellungMailversand.INSERT;
                            COMMIT;  //Damit RUNMODAL funktioniert
                        END;

                        IF NOT (bSuppressWindow = TRUE) THEN BEGIN
                            recBestellungMailversand.FILTERGROUP(2); //Versteckte Filter
                            recBestellungMailversand.SETRANGE(Versendet, FALSE);
                            recBestellungMailversand.FILTERGROUP(0);
                            PAGE.RUN(50228, recBestellungMailversand);
                        END;
                    END ELSE
                        ERROR('Das PDF %1 konnte nicht erstellt werden!', tFileNameTo);

                END ELSE
                    ERROR('PDF-Datei kann nur am Server1 erstellt werden!');
            END ELSE
                MESSAGE('E-Mail Adresse zu Rechnungskunde nicht vorhanden!');
        END ELSE
            MESSAGE('Rechnungskunde wurde nicht gefunden!');
        //+GL037
    end;
*/


}

