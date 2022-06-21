**********************************************************************
*                                                                    *
* Program..: IPADS.PRG                                               *
* Author...: Thomas Fabula, Zi.408, Tel.:73-3469                     *
* Datum....: 14.01.88                                                *
* Notiz....: Copyright (c) 1988, Institut fr Angewandte Physik      *
*                                der Universit„t Bonn                *
* Letzte nderung: 22.08.88                                          *
*                                                                    *
**********************************************************************
*            Literaturverwaltung fr Physik Abstracts                *
*            verwendete Dateien:                                     *
*            IPADS.BAT     -  Batchdatei auf DOS-Ebene               *
*            IPADS.PRG     -  dBASE-Programmdatei                    *
*            HILFE.PRG     -  Hilfe-Modul zu IPADS                   *
*            LIT.DBF       -  Literaturdatenbank                     *
*            LIT.DBT       -  Literaturdatenbank   (MEMO)            *
*            LIT.FMT       -  Formatdatei                            *
*            LISTE.FMT     -  Formatdatei zum Editieren              *
*            LISTn.FMT     -  Formatdatei zu SUCHn.DBF               *
*            SUCHE.TXT     -  recherchierte Literaturliste           *
*            SUCH1.DBF     -  temp. Suchdatei Autoren                *
*            SUCH2.DBF     -  temp. Suchdatei Titel&Kewords          *
*            SUCH3.DBF     -  temp. Suchdatei Keywords               *
*            SUCHT.DBF     -  temp. Suchdatei Titel                  *
*            TEMP.DBF      -  temp. Arbeitsdatei                     *
**********************************************************************


SET TALK OFF
SET BELL OFF
SET STATUS ON
SET ESCAPE OFF
SET CONFIRM ON
SET DATE GERMAN
CLEAR

DO WHILE .T.

   *    Zentrierte Anzeige der Menauswahl auf dem Bildschirm,
   *    Rahmen zeichnen und šberschrift ausgeben.
   CLEAR
   CLEAR GETS
   USE lit INDEX lit
   GO TOP
   @ 2,0 TO 16,79 DOUBLE
   @ 3,18 SAY [IPADS  -  L I T E R A T U R V E R W A L T U N G]
   @ 4,1 TO 4,78 DOUBLE
   @  5,21 SAY [1. ANHNGEN    -        neuer Datens„tze]
   @  6,21 SAY [2. NDERN      -  vorhandener Datens„tze]
   @  7,21 SAY [3. LISTE       -     der Datensatzfelder]
   @  8,21 SAY [4. AUTOR       -     Recherche vornehmen]
   @  9,21 SAY [5. TITEL&KEY   -     Recherche vornehmen]
   @ 10,21 SAY [6. GENERIEREN  -    einer Literaturliste]
   @ 11,21 SAY [7. SICHERN     -           der Datenbank]
   @ 12,21 SAY [8. HILFE       -                aufrufen]
   @ 13,21 SAY [9. ASSISTENT   -       Programm aufrufen]
   @ 14,21 SAY [ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ]

   @ 15,21 SAY '0. BEENDEN       der Literaturverwaltung'

   * Standardeinstellung --> HILFE
   STORE 8 TO selectnum
   @ 18,33 SAY "Auswahl :"
   @ 18,43 GET selectnum PICTURE "9" RANGE 0,9
   READ

   DO CASE
      USE lit
      GO TOP
      CASE selectnum = 0
         USE lit
         SET BELL ON
         * CLEAR
         * ? 'E N D E : Z„hlen der Gesamteintr„ge...'
         * COUNT TO gg
         CLEAR
         ? "I P A D S  -  Literaturdatenbank"
         ? VERSION()
         ? "Datum: ",DATE(),"  Uhrzeit: ",TIME()
         * ? "Gesamtzahl der Eintr„ge : ", gg
         ?
         ACCEPT "Literaturverwaltung Beenden (J/N) ? " TO ende
         ende = UPPER(ende)
         IF ende = "J"
           QUIT
         ELSE
           DO ipads
         ENDIF

**********************************************************************

      CASE selectnum = 1
      *  neue Datens„tze anh„ngen
         SET STATUS OFF
         SET CONFIRM OFF
         APPEND
         *  Sortieren der Datenbank 
         USE lit
         SET STATUS ON
         CLEAR
         @ 8,15 SAY 'Soll die Literatur-Datenbank  LIT.DBF sortiert werden ?'
         ?
         ACCEPT "                               Eingabe (J/N) : " TO sortiere
         sortiere = UPPER(sortiere)
         IF sortiere = "J"
           @ 13,24 SAY 'Sortiervorgang in  A r b e i t ...'
           SORT ON krzel TO sort
           CLOSE DATABASES
           ERASE lit.dbf
           ERASE lit.dbt
           COPY FILE sort.dbf TO lit.dbf
           COPY FILE sort.dbt TO lit.dbt
           ERASE sort.dbf
           ERASE sort.dbt
           USE lit
           ERASE lit.ndx
           INDEX ON krzel TO lit
           * Sortiervorgang beendet
         ELSE
           * Literatur-Datenbank wird  n i c h t  sortiert 
         ENDIF
         SET FORMAT TO
         SET CONFIRM ON
         SET STATUS ON

**********************************************************************

      CASE selectnum = 2
      *  vorhandene Datens„tze „ndern
         SET FORMAT TO lit
         gesamt=reccount()
         satznr = 100000
         SET STATUS OFF
         DO WHILE satznr > gesamt
            CLEAR
            @  1,21 SAY 'NDERN vorhandener Datens„tze:'
            @  2,21 SAY 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
            ?
            ?
            ? 'ACHTUNG: Satznummer muá kleiner gleich',gesamt,' sein.'
            ?
            INPUT 'Welchen Datensatz „ndern. Bitte Nummer eingeben : ' TO satznr
         ENDDO
         GO satznr
         EDIT
         SET FORMAT TO
         SET STATUS ON

**********************************************************************

      CASE selectnum = 3
      *  alle Datens„tze auflisten zum Anschauen
         SET STATUS OFF
         GO TOP
         BROWSE FIELDS krzel,gebiet,subgebiet,autoren,zeitschrft,titel,jahrgang FREEZE jahrgang NOAPPEND NOMENU
         SET STATUS ON

**********************************************************************

      CASE selectnum = 4
      * Literatur RECHERCHE vornehmen
        SET TALK OFF
        CLEAR
        STORE ' ' TO sucha
        @  1,21 SAY 'AUTOREN-Recherche:'
        @  2,21 SAY 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
        ?
        ? 'Beispiel: Die Eingabe von  <ller>  findet alle Autoren'
        ? '          bzw. Koautoren die diesen Teilstring enthalten.'
        ? '          (z.B.: Mueller, Kellermann, etc.)'
        ?
        @ 10,11 SAY '1. Recherche  N E U  vornehmen'
        @ 11,11 SAY '2. Aktuelle Recherche anzeigen'
        @ 12,11 SAY '3. Externe  Recherche anzeigen'
        @ 13,11 SAY [ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ]
        @ 14,11 SAY '0. Zurck zur Hauptauswahl'
        STORE 1 TO such
        @ 16,27 SAY "Auswahl :"
        @ 16,37 GET such PICTURE "9" RANGE 0,3
        READ

      DO CASE

        CASE such = 0
        *************
        CASE such = 1
        ACCEPT "Suchvorgabe fr AUTOREN   : " TO sucha
        CLEAR

        * Suche nach Autorenname im Feld AUTOREN
        ? 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
        graut = UPPER(sucha)
        LIST FOR ((sucha) $ AUTOREN .OR. (graut) $ upper(AUTOREN))  KšRZEL,AUTOREN
        ? 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'

        ? 'Abspeichern der recherchierten Datens„tze in:  SUCH1.DBF'
        COPY TO such1 FOR ((sucha) $ AUTOREN .OR. (graut) $ upper(AUTOREN))

        ? 'Editieren der recherchierten Datens„tze (SUCH1.DBF):'
        STORE ' ' TO wait_subst
        @ 23,0 SAY 'Eine Taste fr weiter in IPADS...' GET wait_subst
        READ
        CLEAR
        SET STATUS OFF
        USE such1
        COUNT TO anz1
        IF anz1 = 0
          @ 12,10 SAY 'ACHTUNG: Keine Eintr„ge gem„á Suchschlssel gefunden !'
          STORE ' ' TO wait_subst
          @ 23,0 SAY 'Eine Taste fr weiter in IPADS...' GET wait_subst
          READ
        ENDIF
        IF anz1 <> 0 
        USE such1
          SET FORMAT TO list1
          GO TOP
          edit
        ENDIF
        SET FORMAT TO
        SET STATUS ON
        *************
        CASE such = 2
        CLEAR
        SET STATUS OFF
        IF .NOT. FILE("such1.dbf")
          @ 12,10 SAY 'ACHTUNG: Keine AUTOREN-Recherche bis jetzt vorgenommen !'
          STORE ' ' TO wait_subst
          @ 23,0 SAY 'Eine Taste fr weiter in IPADS...' GET wait_subst
          READ
        ENDIF
        IF FILE("such1.dbf")
          USE such1
          SET FORMAT TO list1
          GO TOP
          edit
        ENDIF
        SET FORMAT TO
        SET STATUS ON
        *************
        CASE such = 3
        ? 'Externe Recherche-Datei editieren...'
        ACCEPT "Laufwerk & Dateinamen bitte eingeben (.DBF wird gesetzt)  : " TO datei
        READ
        CLEAR
        SET STATUS OFF
        datei = upper(datei) + ".DBF"
        IF .NOT. FILE("&datei")
          ??CHR(7)
          @ 12,5 SAY 'ACHTUNG: Angegeben Recherche-Datei  n i c h t  gefunden !'
          STORE ' ' TO wait_subst
          @ 23,0 SAY 'Eine Taste fr weiter in IPADS...' GET wait_subst
          READ
        ENDIF
        IF FILE("&datei")
        USE &datei
          GO TOP
          edit
        ENDIF
        SET FORMAT TO
        SET STATUS ON


  ENDCASE
        USE lit
        GO TOP

**********************************************************************


      CASE selectnum = 5
      * Literatur TITEL&KEYWORD-Recherche vornehmen
        SET TALK OFF
        CLEAR
        STORE ' ' TO suchtk
        @ 1,21 SAY 'TITEL & KEYWORD-Recherche:'
        @ 2,21 SAY 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
        ?
        ? 'Beispiel: Die Eingabe von  <aser>  findet alle Artikel die in den'
        ? '          Feldern TITEL bzw. KEYWORDS diesen Teilstring enthalten.'
        ? '          (z.B.: Laser, MASER, etc.)'
        ?
        @  9,11 SAY '1. Recherche  N E U  vornehmen'
        @ 10,11 SAY '2. Aktuelle Recherche anzeigen'
        @ 11,11 SAY [ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ]
        @ 12,11 SAY '0. Zurck zur Hauptauswahl'
        STORE 1 TO suche
        @ 16,27 SAY "Auswahl :"
        @ 16,37 GET suche PICTURE "9" RANGE 0,2
        READ

        DO CASE

           CASE suche = 0

        CASE suche = 1
        ACCEPT "Suchvorgabe fr TITEL bzw. KEYWORD  : " TO suchtk
        CLEAR
        * Auch Grossbuchstaben beachten
        TK = UPPER(suchtk)

        * Suche nach Suchbegriff in TITEL und KEYWORD
        ? 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
        LIST OFF FOR ((suchtk) $ TITEL .OR. (TK) $ upper(TITEL))   KšRZEL,TITEL
        ? 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'

        ? 'Abspeichern der recherchierten Datens„tze...'
        COPY TO sucht FOR ((suchtk) $ TITEL .OR. (TK) $ upper(TITEL))
        STORE ' ' TO wait_subst
        @ 23,0 SAY 'Eine Taste fr weitere Recherche...' GET wait_subst
        READ

        CLEAR
        @ 1,0 SAY 'KEYWORD-Recherche wird vorgenommen:'
        * Suche nach Stichworten :  KEYWORD

        ? 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
        LIST OFF FOR ((suchtk) $ KEYWORD1 .OR. (TK) $ upper(KEYWORD1)) KšRZEL,KEYWORD1,GEBIET,SUBGEBIET
        LIST OFF FOR ((suchtk) $ KEYWORD2 .OR. (TK) $ upper(KEYWORD2)) KšRZEL,KEYWORD2,GEBIET,SUBGEBIET
        LIST OFF FOR ((suchtk) $ KEYWORD3 .OR. (TK) $ upper(KEYWORD3)) KšRZEL,KEYWORD3,GEBIET,SUBGEBIET
        LIST OFF FOR ((suchtk) $ KEYWORD4 .OR. (TK) $ upper(KEYWORD4)) KšRZEL,KEYWORD4,GEBIET,SUBGEBIET
        LIST OFF FOR ((suchtk) $ KEYWORD5 .OR. (TK) $ upper(KEYWORD5)) KšRZEL,KEYWORD5,GEBIET,SUBGEBIET
        LIST OFF FOR ((suchtk) $ KEYWORD6 .OR. (TK) $ upper(KEYWORD6)) KšRZEL,KEYWORD6,GEBIET,SUBGEBIET
        LIST OFF FOR ((suchtk) $ KEYWORD7 .OR. (TK) $ upper(KEYWORD7)) KšRZEL,KEYWORD7,GEBIET,SUBGEBIET
        LIST OFF FOR ((suchtk) $ KEYWORD8 .OR. (TK) $ upper(KEYWORD8)) KšRZEL,KEYWORD8,GEBIET,SUBGEBIET
        ? 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'

        COPY TO such3 FOR ((TK) $ upper(KEYWORD1) .OR. (TK) $ upper(KEYWORD2) .OR. (TK) $ upper(KEYWORD3) .OR. (TK) $ upper(KEYWORD4) .OR. (TK) $ upper(KEYWORD5) .OR. (TK) $ upper(KEYWORD6) .OR. (TK) $ upper(KEYWORD7) .OR. (TK) $ upper(KEYWORD8))
        ? 'Abspeichern der recherchierten Datens„tze in:  SUCH2.DBF'
        COPY TO such2 FOR ((suchtk) $ KEYWORD1 .OR. (suchtk) $ KEYWORD2 .OR. (suchtk) $ KEYWORD3 .OR. (suchtk) $ KEYWORD4 .OR. (suchtk) $ KEYWORD5 .OR. (suchtk) $ KEYWORD6 .OR. (suchtk) $ KEYWORD7 .OR. (suchtk) $ KEYWORD8)
        *  Alle Eintraege werden in  SUCH2.DBF  gespeichert
        USE such2
        APPEND FROM such3
        APPEND FROM sucht

        ? 'Editieren der recherchierten Datens„tze (SUCH2.DBF):'
        STORE ' ' TO wait_subst
        @ 23,0 SAY 'Eine Taste fr weiter in IPADS...' GET wait_subst
        READ
        CLEAR
        SET STATUS OFF
        COUNT TO anz2
        IF anz2 = 0
          @ 12,10 SAY 'ACHTUNG: Keine Eintr„ge gem„á Suchschlssel gefunden !'
          STORE ' ' TO wait_subst
          @ 23,0 SAY 'Eine Taste fr weiter in IPADS...' GET wait_subst
          READ
        ENDIF
        IF anz2 <> 0
          SET FORMAT TO list2
          GO TOP
          edit
        ENDIF
        SET FORMAT TO
        SET STATUS ON
        USE lit
        GO TOP
        *************
        CASE suche = 2
        CLEAR
        SET STATUS OFF
        IF .NOT. FILE("such2.dbf")
          @ 12,10 SAY 'ACHTUNG: Keine TITEL&KEY-Recherche bis jetzt vorgenommen !'
          STORE ' ' TO wait_subst
          @ 23,0 SAY 'Eine Taste fr weiter in IPADS...' GET wait_subst
          READ
        ENDIF
        IF FILE("such2.dbf")
          SET FORMAT TO list2
          GO TOP
          edit
        ENDIF
        SET FORMAT TO
        SET STATUS ON

   ENDCASE

**********************************************************************

      CASE selectnum = 6
      * gefundene Datens„tze in ASCII-Datei speichern
        SET TALK OFF
        ERASE temp.dbf
        ERASE temp.dbt
        COPY STRUCTURE TO temp
        CLEAR
        @  1,21 SAY 'Die recherchierten Artikel werden in die'
        @  2,21 SAY 'Literaturliste   SUCHE.TXT  geschrieben:'
        @  3,21 SAY 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
        @  9,11 SAY [1. Artikel mit Suchvorgabe AUTOREN   (SUCH1.DBF) speichern]
        @ 10,11 SAY [2. Artikel mit Suchvorgabe TITEL&KEY (SUCH2.DBF) speichern]
        @ 11,11 SAY [3. Artikel mit beiden Suchvorgaben   (1. + 2.)   speichern]
        @ 12,11 SAY [ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ]
        @ 13,11 SAY '0. Zurck zur Hauptauswahl'
        STORE 0 TO rech
        @ 16,33 SAY "Auswahl :"
        @ 16,43 GET rech PICTURE "9" RANGE 0,3
        READ
        USE temp

        DO CASE

           CASE rech = 0

           CASE rech = 1
                IF FILE("such1.dbf")
                  APPEND FROM such1
                  @ 18,18 SAY "Datei  SUCHE.TXT  wird auf Platte geschrieben !"
                  COPY TO suche FIELDS AUTOREN,ZEITSCHRFT DELIMITED WITH BLANK
                ENDIF
                IF .NOT. FILE("such1.dbf")
                  @ 19,10 SAY 'ACHTUNG: Keine AUTOREN-Recherche bis jetzt vorgenommen !'
                ENDIF

           CASE rech = 2
                IF FILE("such2.dbf")
                  APPEND FROM such2
                  @ 18,18 SAY "Datei  SUCHE.TXT  wird auf Platte geschrieben !"
                  COPY TO suche FIELDS AUTOREN,ZEITSCHRFT DELIMITED WITH BLANK
                ENDIF
                IF .NOT. FILE("such2.dbf")
                  @ 20,10 SAY 'ACHTUNG: Keine TITEL&KEY-Recherche bis jetzt vorgenommen !'
                ENDIF

           CASE rech = 3
                IF FILE("such1.dbf")
                  APPEND FROM such1
                ENDIF
                IF FILE("such2.dbf")
                  APPEND FROM such2
                ENDIF
                COUNT to summe
                IF summe<>0
                  @ 18,18 SAY "Datei  SUCHE.TXT  wird auf Platte geschrieben !"
                  COPY TO suche FIELDS AUTOREN,ZEITSCHRFT DELIMITED WITH BLANK
                ENDIF

                IF .NOT. FILE("such1.dbf")
                  @ 19,10 SAY 'ACHTUNG: AUTOREN-Recherche wurde nicht vorgenommen !'
                ENDIF
                IF .NOT. FILE("such2.dbf")
                  @ 20,10 SAY 'ACHTUNG: TITEL&KEY-Recherche wurde nicht vorgenommen !'
                ENDIF


        ENDCASE
        SET TALK OFF
        SET CONFIRM OFF
        STORE ' ' TO wait_subst
        @ 23,0 SAY 'Eine Taste fr weiter in IPADS...' GET wait_subst
        READ
        SET CONFIRM ON
        USE lit
        GO TOP

**********************************************************************

     CASE selectnum = 7
      * Sichern der Datenbank  LIT.DBF  und  SUCHE.TXT
        SET TALK OFF
        CLEAR
        @  1,21 SAY 'Sichern der Datenbank-Dateien :'
        @  2,21 SAY 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
        @  7,11 SAY [1. Auf Laufwerk A: (1.2 MB - High Density Format) speichern]
        @  9,11 SAY [2. Auf Laufwerk B: (360 kB - Double Sided Format) speichern]
        @ 11,11 SAY [3. Literaturliste  SUCHE.TXT  auf Diskette speichern]
        @ 12,11 SAY [ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ]
        @ 13,11 SAY '0. Zurck zur Hauptauswahl'
        STORE 0 TO sich
        @ 16,33 SAY "Auswahl :"
        @ 16,43 GET sich PICTURE "9" RANGE 0,3
        READ
        CLOSE DATABASES

        DO CASE

           CASE sich = 0

           CASE sich = 1
                @ 18,13 SAY "Die Datenbank-Datei wird auf Diskette A: gesichert !"
                COPY FILE lit.dbf TO a:lit.dbf
                COPY FILE lit.dbt TO a:lit.dbt


           CASE sich = 2
                @ 18,13 SAY "Die Datenbank-Datei wird auf Diskette B: gesichert !"
                COPY FILE lit.dbf TO b:lit.dbf
                COPY FILE lit.dbt TO b:lit.dbt


           CASE sich = 3
           STORE 1 TO laufw
           @ 18,10 SAY "Literaturliste auf welches Laufwerk sichern ? (A=1, B=2) "
           @ 18,67 GET laufw PICTURE "9" RANGE 1,2
           READ
           IF .NOT. FILE("suche.txt")
             CLEAR
             @ 12,20 SAY "Datei  SUCHE.TXT  n i c h t  vorhanden !"
           ENDIF

           IF FILE("suche.txt")
             DO CASE

             CASE laufw = 1
                @ 19,13 SAY "Die Literaturliste wird auf Diskette A: gesichert !"
                COPY FILE suche.txt TO a:suche.txt

             CASE laufw = 2
                @ 19,13 SAY "Die Literaturliste wird auf Diskette B: gesichert !"
                COPY FILE suche.txt TO b:suche.txt
             ENDCASE
           ENDIF

        ENDCASE
        SET TALK OFF
        USE lit
        GO TOP
        STORE ' ' TO wait_subst
        @ 23,0 SAY 'Eine Taste fr weiter in IPADS...' GET wait_subst
        READ

**********************************************************************

     CASE selectnum = 8
      * Allgemeine HILFE aufrufen
        CLEAR
        @  1,21 SAY 'On-Line Hilfefunktionen :'
        @  2,21 SAY 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
        @  7,18 SAY [1. Hilfe zu der Literaturverwaltung]
        @  9,18 SAY [2. Allgemeine Hilfe zu  dBASE III +]
        @ 10,18 SAY [ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ]
        @ 11,18 SAY '0. Zurck zur Hauptauswahl'
        STORE 1 TO hilfmir
        @ 16,27 SAY "Auswahl :"
        @ 16,37 GET hilfmir PICTURE "9" RANGE 0,2
        READ

        DO CASE

           CASE hilfmir = 0

           CASE hilfmir = 1
                * Aufrufen des Hilfe-Programms HILFE.PRG
                DO hilfe

           CASE hilfmir = 2
                * Aufrufen des dBASE On-Line-Hilfe 
                HELP

        ENDCASE
        SET TALK OFF
        USE lit
        GO TOP
        STORE ' ' TO wait_subst
        @ 23,0 SAY 'Eine Taste fr weiter in IPADS...' GET wait_subst
        READ

**********************************************************************

      CASE selectnum = 9
      *  dBASE-ASSISTENT aufrufen
        CLEAR
        @  7,10 SAY '               A  C  H  T  U  N  G :'
        @ 10,10 SAY 'Um nach Aufruf von  ASSIST  im Literatur-Programm  IPADS'
        @ 11,10 SAY 'weiter zu arbeiten, bitte die  <ESC>ape  Taste drcken...'
        STORE ' ' TO wait_subst
        @ 23,0 SAY 'Eine Taste fr weiter mit  A S S I S T ...' GET wait_subst
        READ
        ASSIST


ENDCASE
ENDDO T
RETURN
* EOF: IPADS.PRG
