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
   @  5,21 SAY [1. ANH��NGEN    -        neuer Datens��tze] 
   @  6,21 SAY [2. ��NDERN      -  vorhandener Datens��tze] 
   @  7,21 SAY [3. LISTE       -     der Datensatzfelder] 
   @  8,21 SAY [4. AUTOR       -     Recherche vornehmen] 
   @  9,21 SAY [5. TITEL&KEY   -     Recherche vornehmen] 
   @ 10,21 SAY [6. GENERIEREN  -    einer Literaturliste] 
   @ 11,21 SAY [7. SICHERN     -           der Datenbank] 
   @ 12,21 SAY [8. HILFE       -                aufrufen] 
   @ 13,21 SAY [9. ASSISTENT   -       Programm aufrufen] 
   @ 14,21 SAY [��Ą��Ą��Ą��##Ą��((Ą��--Ą��22Ą��75�] �
 
   @ 15,21 SAY [0. ZUR��CK      -        zur Hauptauswahl] 
   STORE 0 TO hilf 
   @ 18,33 SAY "Auswahl :" 
   @ 18,43 GET hilf PICTURE "9" RANGE 0,9 
   READ 
 
    DO CASE 
      CASE hilf = 0 
 
      CASE hilf = 1 
           CLEAR 
           TEXT 
                     Hilfsbildschirm 1 : ANH��NGEN 
                     ��Ą��Ą��##Ą��((Ą��--Ą��21� �
� �F���r die Neueingabe von Daten (Artikel) steht die Stan�dard�-�Ein�gabemaske des dBASE-Interpreters zur Verf��gung. Dieneu ein�gegebenen Daten werden an die bestehende Daten�bankangeh��ngt und beim Verlassen des Programms nach dem FeldK��RZEL indiziert (LIT.NDX). Auf Wunsch k��nnen die Datenalphabetisch nach K��RZEL sortiert werden. Um die Felder zubearbeiten stehen neben den Pfeiltasten die   WordstarEditier-Befehle (Ctrl-A,S,D,F,G,Y,T,X) zur Ver�f��gung. �>�

� �Das ABSTRACT-Feld wird mit der Tastenkombination�<Ctrl-Home> ge��ffnet und mit <Ctrl-End> geschlossen. Hierl������t� sich ein �beliebiger Text (max. 1024 Zeichen) ein�ge�ben. Die Escape-Taste <ESC> bricht die Eingabe ab, dieDaten werden dann  n i c h t  abgespeichert. Das Abspei�chern der neuen Daten erfolgt indem man eine neue Ein�gabe�maske erreicht (PgDown bzw. <RETURN>) oder <Ctrl-W> (Spei�chern) eingibt. �>�

� �Mit der  <F1> - Funktionstaste l������t� sich der Hilfs�bild�schirm am oberen Bildschirmrand jederzeit ein- bzw. aus�blenden. �>�
               ENDTEXT 
 �r      ܌      CASE hilf = 2 
           CLEAR 
           TEXT 
                     Hilfsbildschirm 2 : ��NDERN 
� �Um einen bestehenden Datensatz zu ��ndern, gibt man dessenNummer (Recordnummer) ein. Falls diese nicht genau bekanntist, so kann mit Hilfe der PgUp- bzw. PgDown-Tasten dieDatenbank durchbl��ttert werden und der jeweilige Artikelgesucht werden. (Hierbei ist allerdings Vorsicht geboten,da ��nderungen der Feldinhalte abgespeichert werden.) �>�

� �Um die Felder zu bearbeiten stehen neben den Pfeiltastendie Wordstar Editier-Befehle (Ctrl-A,S,D,F,G,Y,T,X) zurVerf��gung. Das ABSTRACT-Feld wird mit der Tastenkom�bina�tion <Ctrl-H�ome> ge��ffnet und mit <Ctrl-End> ge�schlossen.Hier l������t� sich ein beliebi�ger Text (max. 1024 Zeich�en)eingeben. Die Escape-Taste <ESC> bricht die Eingabe ab,die Daten werden dann  n i c h t  abgespeichert. Das Ab�speichern der neuen Daten erfolgt indem man eine neueEingabemaske erreicht (PgDown bzw. <RETURN>) oder <Ctrl-W>(Speichern) eingibt. �>�
               ENDTEXT 


 
      CASE hilf = 3 
           CLEAR 
           TEXT 
                     Hilfsbildschirm 3 : LISTE 
                     ��Ą��Ą��##Ą��((Ą��-,� �
� �Um einen schnellen ��berblick ber den Inhalt der Datenbankzu erhalten, ist es mglich sie in Form einer Liste dar�stellen zu lassen. Hierbei werden folgende Daten�bank-Fel�der angezeigt: �>�
 
		K��RZEL, GEBIET, SUBGEBIET, 
		AUTOREN, ZEITSCHRFT, TITEL, JAHRGANG 

� �Mit Hilfe der Pfeiltasten bzw. PgUp und PgDown kann dieListe nach vorn und hinten durchgebl��ttert, mit Hilfe derTastenkombina�tion <Ctrl-Pfeiltasten> links und rechtsverschoben werden. Die Feldinhalte (bis auf JAHR�GANG) sindhierbei nicht ��nderbar. �>�

� �Mit der  <F1> - Funktionstaste l�t�sich der Hilfsbildschirmam oberen Bildschirmrand jederzeit ein- bzw. aus�blenden. �>�
               ENDTEXT 
 
�`      �      CASE hilf = 4 
           CLEAR 
           TEXT 
                     Hilfsbildschirm 4 : AUTOR 
                     ��Ą��Ą��##Ą��((Ą��-,� �

� �Unter Programmpunkt 1 kann eine AUTOREN-Recherche erfol�gen, nachdem man den Autorennamen oder einen Teil�stringeingegeben hat. Die recherchierten Daten werden bei derSuche auf dem Bildschirm einzeilig dargestellt, anschlie�����e�nd in der tempor��ren Datei SUCH1.DBF zwischen�ge�spei�ch�ert. �>�
 
� �Unter Programmpunkt 2 kann die recherchierte SuchdateiSUCH1.�DBF erneut angeschaut werden. �>�

� �Unter Programmpunkt 3 kann eine bereits fr��her recher�c�hier�te, externe Datei eingelesen und angezeigt werden.Hierzu wird der Dateiname (evtl. mit Laufwerksan�gabe,z.B.: A:RECH.DBF) eingegeben. �>�

� �Anmerkung: �>�
� �Die externe DBF-Datei (einschlie����l�ich zugeh��riger DBT-�>�
� �D�atei) mu��� auf Diskette bzw. Platte vorhanden sein und die g l e i c h e  Datenbankstruktur wie LIT.DBF besit�zen,sonst erfolgt eine Fehlermeldung. �>�
               ENDTEXT 


 
      CASE hilf = 5 
           CLEAR 
           TEXT 
                     Hilfsbildschirm 5 : TITEL&KEY 
                     ��Ą��Ą��##Ą��((Ą��--Ą��22Ą

� �Unter Programmpunkt 1 kann eine kombinierte Recherche nachden Feldern TITEL und KEYWORDn (n = 1 - 8) erfolgen. Hier�zu ist ein Suchbegriff bzw. ein Teilstring einzugeben.Die recherchierten Daten werden bei der Suche auf demBildschirm dargestellt, abh��ngig davon ob sie im FeldTITEL oder bei den Stichworten (KEYWORD) enthalten sind.Anschlie����e�d werden sie in der tempor��ren Datei SUCH2�.DBFzwischengespeichert. Der Suchbegriff wird automati�sch nachKlein-  u n d   Gro����s�chrift recherchiert. �>�

� �Unter Programmpunkt 2 kann die recherchierte SuchdateiSUCH2.�DBF erneut angeschaut werden. �>�
               ENDTEXT 
 
 
�f      �      CASE hilf = 6 
           CLEAR 
           TEXT 
                     Hilfsbildschirm 6 : GENERIEREN 
                     ��Ą��Ą��##Ą��((Ą��--Ą��21� �

� �Dieser Programmpunkt bietet die M��glichkeit anhand derrecher�chierten Daten (Artikel) eine Literaturliste  �>�
� �SUCHE�.TXT  zu gener�ieren, die im ASCII-Format auf Diskettebzw. Platte gespeichert wird. Somit ist die Datei�SUCHE.TXT von beliebigen Texteditoren (z.B. WordPe�rfect,etc.) anschlie����e�nd weiter bearbeitbar. �>�

� �Es k��nnen verschiedene Recherchen (AUTOR- und TITEL&��KEYWORD-Re�cherche) zusammengefa����t� werden, sofern sie be�reits durchgef��hrt wurden und in  e i n e r  Litera�tur�liste abgespeichert werden. �>�

� �Das Format der Literaturliste setzt sich aus den beidenDaten�bankfeldern AUTOREN und ZEITSCHRFT zusammen. �>�
 
 
      Ein typisches Feld hat z.B. die Form: 
 
      A.Einstein,H.Hertz,I. Newton 
	 Phys.Rev.Lett.12,10,3422 (1988) 
               ENDTEXT 

 
 
      CASE hilf = 7 
           CLEAR 
           TEXT 
                     Hilfsbildschirm 7 : SICHERN 
                     ��Ą��Ą��##Ą��((Ą��--Ą��22Ą

� �Dieser Programmpunkt bietet die M��glichkeit Dateien ausdem laufenden Anwenderprogramm  IPADS.PRG  auf Diskette zusichern. �>�

� �Unter Punkt 1 (bzw. 2) werden die Datenbankdateien �LIT.DB?  auf dem Laufwerk A: (bzw. B:) und unter Punkt 3die recherchier�ten Daten in Form einer Literatur�liste SUCHE.TXT  gesichert. Eine Sicherheitskopie (Backup) derDatenbankdateien  LIT.DB?  sollte nach Eingabe neuer Datenauf jeden Fall  i m m e r  erfolgen. �>�

� �Anmerkung: �>�
� �Die tempor��ren Suchdateien (SUCH1.DBF bzw. SUCH2.DBF bzw.�TEMP.DBF und die zugeh��rigen DBT-Dateien) k��nnen bei Bed�arf auf DOS-Ebene ebenfalls gesichert werden, um sie sp��ter erneut zu bear�beiten. Allerdings sollten sie dannumbenannt werden, da IPADS.�PRG diese Dateinamen verwendetund beim Programmstart (IPADS.BAT) die Dateien automa�tisch��berschreibt. �>�
               ENDTEXT 
 
 �r      ܌      CASE hilf = 8 
           CLEAR 
           TEXT 
                     Hilfsbildschirm 8 : HILFE 
                     ��Ą��Ą��##Ą��((Ą��-,� �
 
� �Unter Punkt 1 sind die Hilfsbildschirme (dieser Program�mpunkt) zum IPADS-Literaturverwaltungsprogramm einzelnabrufbar. �>�

� �Unter Punkt 2 wird die Hilfefunktion  HELP  von  dBASE IIIPlus aufgerufen, die ausf��hrliche Informationen zur Benut�zung der Datenbank bereith��lt. Durch Dr��cken der Escape-�>�
� ̬Taste <ESC> gelangt man zurck in das Literaturver�waltungs�programm IPADS. �>�
          ENDTEXT 
 
 
      CASE hilf = 9 
           CLEAR 
           TEXT 
                     Hilfsbildschirm 9 : ASSIST 

� �Bei Aufruf dieser Programmoption wird die dBASE-Benut�zer�ober�fl��che ASSIST aktiviert, welche eine Men��f��h�rung allerdBASE-�Befehle zur Verf��gung stellt. So lassen sich zumBeispiel mit Hilfe von  ASSIST  kompl�exere Suchkri�terienund Verkn��pfungen realisieren, wie sie in den Standard-Re�cherchekriterien (AUTOR und TITEL&KEY) zur Verf��gung ste�hen. �>�

� �Bei Aufruf von ASSIST ist Vorsicht geboten, da das An�wen�der�programm  IPADS.PRG  verlassen wird. (Diese Pro�gramm�option sollte nur von 'erfahrenen' Datenbankan�wendernaufgerufen werden...) �>�

� �Soll anschlie����e�nd in der Literaturverwaltung fortgefahrenwerden, so  m u ��� � �ASSIST  mit der Escape-Taste <ESC> ver�lassen werden. �>�
               ENDTEXT 
 
  ENDCASE 
