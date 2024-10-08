* Unter-Programm:  HILFE.PRG
*
* Hilfsbildschirme zur
* Literaturverwaltung IPADS.PRG
*
*
   CLEAR
   @ 2,0 TO 16,79
   @ 3,18 SAY [H I L F E  zu einzelnen IPADS-Programmpunkten]
   @ 4,1 TO 4,78
   @  5,21 SAY [1. ANHÄNGEN    -        neuer Datensätze]
   @  6,21 SAY [2. ÄNDERN      -  vorhandener Datensätze]
   @  7,21 SAY [3. LISTE       -     der Datensatzfelder]
   @  8,21 SAY [4. AUTOR       -     Recherche vornehmen]
   @  9,21 SAY [5. TITEL&KEY   -     Recherche vornehmen]
   @ 10,21 SAY [6. GENERIEREN  -    einer Literaturliste]
   @ 11,21 SAY [7. SICHERN     -           der Datenbank]
   @ 12,21 SAY [8. HILFE       -                aufrufen]
   @ 13,21 SAY [9. ASSISTENT   -       Programm aufrufen]
   @ 14,21 SAY [========================================]

   @ 15,21 SAY [0. ZURÜCK      -        zur Hauptauswahl]
   STORE 0 TO hilf
   @ 18,33 SAY "Auswahl :"
   @ 18,43 GET hilf PICTURE "9" RANGE 0,9
   READ

    DO CASE
      CASE hilf = 0

      CASE hilf = 1
           CLEAR
           TEXT
                     Hilfsbildschirm 1 : ANHÄNGEN
                     ============================

      Fr die Neueingabe von Daten (Artikel) steht die Standard-Eingabe-
      maske des dBASE-Interpreters zur Verfügung. Die neu eingegebenen Daten
      werden an die bestehende Datenbank angehängt und beim Verlassen des
      Programms nach dem Feld KÜRZEL indiziert (LIT.NDX). Auf Wunsch können
      die Daten alphabetisch nach KÜRZEL sortiert werden.
      Um die Felder zu bearbeiten stehen neben den Pfeiltasten die
      Wordstar Editier-Befehle (Ctrl-A,S,D,F,G,Y,T,X) zur Verfügung.
      Das ABSTRACT-Feld wird mit der Tastenkombination <Ctrl-Home> geöffnet
      und mit <Ctrl-End> geschlossen. Hier läßt sich ein beliebiger Text
      (max. 1024 Zeichen) eingeben. Die Escape-Taste <ESC> bricht die Eingabe
      ab, die Daten werden dann  n i c h t  abgespeichert. Das Abspeichern
      der neuen Daten erfolgt indem man eine neue Eingabemaske erreicht
      (PgDown bzw. <RETURN>) oder <Ctrl-W> (Speichern) eingibt.

      Mit der  <F1> - Funktionstaste läßt sich der Hilfsbildschirm am
      oberen Bildschirmrand jederzeit ein- bzw. ausblenden.
               ENDTEXT

      CASE hilf = 2
           CLEAR
           TEXT
                     Hilfsbildschirm 2 : ÄNDERN
                     ==========================

      Um einen bestehenden Datensatz zu ändern, gibt man dessen Nummer
      (Recordnummer) ein. Falls diese nicht genau bekannt ist, so kann
      mit Hilfe der PgUp- bzw. PgDown-Tasten die Datenbank durchblättert
      werden und der jeweilige Artikel gesucht werden.
      (Hierbei ist allerdings Vorsicht geboten, da Änderungen der Feld-
      inhalte abgespeichert werden.)

      Um die Felder zu bearbeiten stehen neben den Pfeiltasten die
      Wordstar Editier-Befehle (Ctrl-A,S,D,F,G,Y,T,X) zur Verfügung.
      Das ABSTRACT-Feld wird mit der Tastenkombination <Ctrl-Home> geöffnet
      und mit <Ctrl-End> geschlossen. Hier läßt sich ein beliebiger Text
      (max. 1024 Zeichen) eingeben. Die Escape-Taste <ESC> bricht die Eingabe
      ab, die Daten werden dann  n i c h t  abgespeichert. Das Abspeichern
      der neuen Daten erfolgt indem man eine neue Eingabemaske erreicht
      (PgDown bzw. <RETURN>) oder <Ctrl-W> (Speichern) eingibt.
               ENDTEXT

      CASE hilf = 3
           CLEAR
           TEXT
                     Hilfsbildschirm 3 : LISTE
                     =========================

      Um einen schnellen Überblick über den Inhalt der Datenbank zu erhalten,
      ist es möglich sie in Form einer Liste darstellen zu lassen.
      Hierbei werden folgende Datenbank-Felder angezeigt:

         KÜRZEL, GEBIET, SUBGEBIET, AUTOREN, ZEITSCHRFT, TITEL, JAHRGANG

      Mit Hilfe der Pfeiltasten bzw. PgUp und PgDown kann die Liste nach vorn
      und hinten durchgeblättert, mit Hilfe der Tastenkombination <Ctrl-Pfeil-
      tasten> links und rechts verschoben werden.
      Die Feldinhalte (bis auf JAHRGANG) sind hierbei nicht änderbar.

      Mit der  <F1> - Funktionstaste läßt sich der Hilfsbildschirm am oberen
      Bildschirmrand jederzeit ein- bzw. ausblenden.
               ENDTEXT

      CASE hilf = 4
           CLEAR
           TEXT
                     Hilfsbildschirm 4 : AUTOR
                     =========================

      Unter Programmpunkt 1 kann eine AUTOREN-Recherche erfolgen, nachdem man
      den Autorennamen oder einen Teilstring eingegeben hat. Die recherchierten
      Daten werden bei der Suche auf dem Bildschirm einzeilig dargestellt,
      anschließend in der temporären Datei SUCH1.DBF zwischengespeichert.

      Unter Programmpunkt 2 kann die recherchierte Suchdatei SUCH1.DBF erneut
      angeschaut werden.

      Unter Programmpunkt 3 kann eine bereits früher recherchierte, externe
      Datei eingelesen und angezeigt werden. Hierzu wird der Dateiname (evtl.
      mit Laufwerksangabe, z.B.: A:RECH.DBF) eingegeben.

      Anmerkung:
      ==========
      Die externe DBF-Datei (einschließlich zugehöriger DBT-Datei) muß auf
      Diskette bzw. Platte vorhanden sein und die  g l e i c h e  Datenbank-
      struktur wie LIT.DBF besitzen, sonst erfolgt eine Fehlermeldung.
               ENDTEXT

      CASE hilf = 5
           CLEAR
           TEXT
                     Hilfsbildschirm 5 : TITEL&KEY
                     =============================

      Unter Programmpunkt 1 kann eine kombinierte Recherche nach den Feldern
      TITEL und KEYWORDn (n = 1 - 8) erfolgen. Hierzu ist ein Suchbegriff bzw.
      ein Teilstring einzugeben. Die recherchierten Daten werden bei der Suche
      auf dem Bildschirm dargestellt, abhängig davon ob sie im Feld TITEL oder
      bei den Stichworten (KEYWORD) enthalten sind. Anschließend werden sie in
      der temporären Datei SUCH2.DBF zwischengespeichert. Der Suchbegriff wird
      automatisch nach Klein-  u n d   Groáschrift recherchiert.

      Unter Programmpunkt 2 kann die recherchierte Suchdatei SUCH2.DBF erneut
      angeschaut werden.
               ENDTEXT


      CASE hilf = 6
           CLEAR
           TEXT
                     Hilfsbildschirm 6 : GENERIEREN
                     ==============================

      Dieser Programmpunkt bietet die Möglichkeit anhand der recherchierten
      Daten (Artikel) eine Literaturliste  SUCHE.TXT  zu generieren, die im
      ASCII-Format auf Diskette bzw. Platte gespeichert wird. Somit ist die
      Datei SUCHE.TXT von beliebigen Texteditoren (z.B. WordPerfect, etc.)
      anschließend weiter bearbeitbar.

      Es können verschiedene Recherchen (AUTOR- und TITEL&KEYWORD-Recherche)
      zusammengefaát werden, sofern sie bereits durchgeführt wurden und in
      e i n e r  Literaturliste abgespeichert werden.

      Das Format der Literaturliste setzt sich aus den beiden Datenbank-
      feldern AUTOREN und ZEITSCHRFT zusammen.


      Ein typisches Feld hat z.B. die Form:

      A.Einstein,H.Hertz,I. Newton Phys.Rev.Lett.12,10,3422 (1988)
               ENDTEXT


      CASE hilf = 7
           CLEAR
           TEXT
                     Hilfsbildschirm 7 : SICHERN
                     ===========================

      Dieser Programmpunkt bietet die Möglichkeit Dateien aus dem
      laufenden Anwenderprogramm  IPADS.PRG  auf Diskette zu sichern.

      Unter Punkt 1 (bzw. 2) werden die Datenbankdateien  LIT.DB?  auf dem
      Laufwerk A: (bzw. B:) und unter Punkt 3 die recherchierten Daten
      in Form einer Literaturliste  SUCHE.TXT  gesichert.
      Eine Sicherheitskopie (Backup) der Datenbankdateien  LIT.DB?  sollte
      nach Eingabe neuer Daten auf jeden Fall  i m m e r  erfolgen.

      Anmerkung:
      ==========
      Die temporären Suchdateien (SUCH1.DBF bzw. SUCH2.DBF bzw. TEMP.DBF
      und die zugehörigen DBT-Dateien) können bei Bedarf auf DOS-Ebene
      ebenfalls gesichert werden, um sie später erneut zu bearbeiten.
      Allerdings sollten sie dann umbenannt werden, da IPADS.PRG diese
      Dateinamen verwendet und beim Programmstart (IPADS.BAT) die Dateien
      automatisch überschreibt.
               ENDTEXT


      CASE hilf = 8
           CLEAR
           TEXT
                     Hilfsbildschirm 8 : HILFE
                     =========================


      Unter Punkt 1 sind die Hilfsbildschirme (dieser Programmpunkt)
      zum IPADS-Literaturverwaltungsprogramm einzeln abrufbar.

      Unter Punkt 2 wird die Hilfefunktion  HELP  von  dBASE III Plus
      aufgerufen, die ausführliche Informationen zur Benutzung der
      Datenbank bereithält. Durch Drücken der Escape-Taste <ESC> gelangt
      man zurück in das Literaturverwaltungsprogramm IPADS.
          ENDTEXT


      CASE hilf = 9
           CLEAR
           TEXT
                     Hilfsbildschirm 9 : ASSIST
                     ==========================

      Bei Aufruf dieser Programmoption wird die dBASE-Benutzeroberfläche
      ASSIST aktiviert, welche eine Menüführung aller dBASE-Befehle zur
      Verfügung stellt.

      So lassen sich zum Beispiel mit Hilfe von  ASSIST  komplexere
      Suchkriterien und Verknüpfungen realisieren, wie sie in den
      Standard-Recherchekriterien (AUTOR und TITEL&KEY) zur Verfügung
      stehen.

      Bei Aufruf von ASSIST ist Vorsicht geboten, da das Anwenderprogramm
      IPADS.PRG  verlassen wird. (Diese Programmoption sollte nur von
      'erfahrenen' Datenbankanwendern aufgerufen werden...)

      Soll anschließend in der Literaturverwaltung fortgefahren werden,
      so  m u ß  ASSIST  mit der Escape-Taste <ESC> verlassen werden.
               ENDTEXT

  ENDCASE
