* Program..: SERVICE.PRG  -  Programmverbund IPADS             * Author...: Thomas Fabula                                     * Datum....: 11.06.88                                          * Notiz....: Copyright (c) 1988, Institut f��r Angewandte Physik *                                Universit��t Bonn              * Letzte ��nderung:  8.09.88                                    * 
* Bemerkung:� ��>�
� �Dieses Programm stellt die Serviceroutinen zur Pflege derLiteratur-Datenbank LIT.DBF �Verf��gung. Es sollte in regel�m������i�gen Abst��nden �aktiviert wer�den, um den Datenbankinhaltund die Stichwortliste zu ak�tualisieren bzw. die �Datenbankzu erwei�tern. Hierbei ist es m��glich eine Ver�eini�gungs�menge von zwei beliebigen Daten�banken zu bilden (mergen),ohne da��� Doppel�eintr��ge vorkom�men. Das Unter�scheidungs�kriterium ist das Datenbank�feld  �ZEITSCHRFT.�>�
 
* Dateien:   
	SERVICE.PRG  -  diese dBASE-Programmdatei                	SERVICE.BAT  -  DOS-Stapeldatei (Batch)
	KEYPACK.COM  -  Filter-Programm, um dop�pelte                           		 Stichworteintragungen zu ver�hinde�rn.
	KEYPACK.PAS  -  Turbo-Pascal Quelldatei (s.o.)
	FILTER.TXT   -  temporre Stichwortdatei
	ARTIKEL.TXT  -  Textdatei aller Artikel
	KEYWORDS.TXT -  alphabetisch sortierte Stichwort�datei
	TEMPKEY.DBF  -  Ursprungsdatei (Structure-Init.)
	�LITCONV.COM  -  Konvertierungsprogramm, um ausf��hr-                            liche Literaturliste  LIT.ADI zu
				 generieren.
	LITCONV.PAS  -  Turbo-Pascal Quelldatei (s.o.)
 	ADI-DB3.COM  -  Konvertierungsprogramm, um ADIMENS
				 Literaturliste (*.MRG) einzulesen
	ADI-DB3.PAS  -  Turbo-Pascal Quelldatei (s.o.)
	DB3-ADI.COM  -  Konvertierungsprogramm, um dBASE
       			 Literaturliste (*.LST) nach
				 ADIMENS trans�ferieren zu k��nnen
	DB3-ADI.PAS  -  Turbo-Pascal Quelldatei (s.o.)

* tempor��re Dateien:
	KEYn.DBF     -  tempor��re dBASE-Einzelstichwort�datei
	KEYn.TXT     -  tempor��re Text-Einzelstichwortdatei
	WORT.DBF     -  tempor��re Gesamt-Stichwortdatei
	KEYSORT.DBF  -  temp. sortierte Gesamt-Stichwort�datei


SET TALK OFF 
SET BELL OFF 
SET STATUS ON 
SET ESCAPE OFF 
SET CONFIRM ON 
USE lit INDEX lit 
 
DO WHILE .T. 
 
   * ---Zentrierte Anzeige der Men��auswahl auf dem Bildschirm, 
   *    Rahmen zeichnen und ��berschrift ausgeben. 
   CLEAR �r      ܌   CLEAR GETS 
   @ 2,0 TO 14,79 DOUBLE 
   @ 3,17 SAY [S e r v i c e r o u t i n e n   zu   I P A D S]
   @ 4,1 TO 4,78 DOUBLE 
   * ---display detail lines 
   @  6,27 SAY [1. LIT-Datenbank  sortieren] 
   @  7,27 SAY [2. Datenbankliste erstellen] 
   @  8,27 SAY [3. Stichwortliste erstellen] 
   @  9,27 SAY [4. LIT-Datenbank  erweitern] 
   @ 10,27 SAY [5. Hilfe  zu Servicepunkten] 
   @ 11,27 SAY [���������������������������]
   @ 12,27 SAY '0. Ser�vice-Programm beenden' 
   STORE 5 TO selectnum 
   @ 15,33 SAY " Auswahl    " 
   @ 15,42 GET selectnum PICTURE "9" RANGE 0,5 
   READ 
 
   DO CASE 
      CASE selectnum = 0 
         SET BELL ON 
         SET TALK ON 
         CLEAR ALL 
         QUIT 
 
      CASE selectnum = 1 
      *  DO Sortieren der Datenbank 
         * SET TALK OFF 
         USE lit 
         CLEAR 
         @ 8,20 SAY 'Sortieren der Literatur-Datenbank  
				 LIT.DBF !' 
         ? 
         ? 
         SORT ON k��rzel TO sort 
         CLOSE DATABASES 
         @ 9,20 SAY 'Dateien auf Platte umbenennen & 
				 umordnen !' 
         ERASE lit.dbf 
         ERASE lit.dbt 
         COPY FILE sort.dbf TO lit.dbf 
         COPY FILE sort.dbt TO lit.dbt 
         ERASE sort.dbf 
         ERASE sort.dbt 
         USE lit 
         ERASE lit.ndx 
         @ 10,20 SAY 'Indizieren der Literatur-Datenbank 
				  LIT.DBF !' 
         INDEX ON k��rzel TO lit 
         SET CONFIRM OFF 
         STORE ' ' TO wait_subst 
         @ 23,0 SAY 'Eine Taste f��r weiter....' GET wait_subst 
         READ 
         SET CONFIRM ON 
 �l      �
      CASE selectnum = 2 
      *  DO Datenbankinhalt auflisten 
         CLEAR 
         SET TALK OFF 
         USE lit INDEX lit 
         @  0,25 SAY [Datenbankliste erstellen:] 
         @  1,25 SAY [��Ą��Ą��##Ą��((Ą��-+�] �
         @  6,23 SAY [1. Kurze        Datenbankliste] 
         @  7,23 SAY [2. Ausf��hrliche Datenbankliste] 
         @  8,23 SAY [��Ą��Ą��##Ą��((Ą��--Ą��20�] �
         @  9,23 SAY '0. Zur     Hauptauswahl zur��ck' 
         STORE 1 TO xx 
         @ 11,30 SAY " Auswahl    " 
         @ 11,39 GET xx PICTURE "9" RANGE 0,2 
         READ 
 
         DO CASE 
 
         CASE xx = 0 
 
         CASE xx = 1 
           @ 15,15 SAY 'Inhaltsverzeichnis der 
				    Literatur-Daten�bank  LIT.DBF' 
           @ 16,15 SAY 'wird in die ASCII-Datei  
				    ARTIKEL.TXT  geschrieben.' 
           @ 18,15 SAY 'Dateiformat:  K��RZEL, �ZEITSCHRFT' 
           ERASE artikel.txt 
           COPY TO artikel FIELDS k��rzel,zeitschrft 
			delimited with blank 
 
         CASE xx = 2 
           @ 15,15 SAY 'Inhaltsverzeichnis der 
				    Literatur-Daten�bank  LIT.DBF' 
           @ 16,15 SAY 'wird in die ASCII-Datei  
				    LIT.LST  geschrieben.' 
           @ 17,15 SAY 'Dateiformat (delimited with #):' 
           @ 19,15 SAY 'K��RZEL, GEBIET, SUBGEBIET, TITEL,
				    �AUTOREN, ZEITSCHRFT' 
           ERASE lit.lst 
           COPY TO lit.lst FIELDS k��rzel,gebiet,subgebiet,
			tit�el,autoren,zeitschrft delimited with # 
           * Anschlie����e�nd konvertieren mit LITCONV 
         ENDCASE 
 
         SET CONFIRM OFF 
         STORE ' ' TO wait_subst 
         @ 23,0 SAY 'Eine Taste f��r weiter....' GET wait_subst 
         READ 
         SET CONFIRM ON 
 
      CASE selectnum = 3 
      *  DO Stichwortliste erstellen 
         SET TALK OFF 
         clear 
         use lit 
         @ 0,25 SAY 'Erstellen der Stichwortliste:' 
         @ 1,25 SAY '��Ą��Ą��##Ą��((Ą��--Ą��21� ��r      ܌         ? 
         ? 
         ? 'Kopieren der Stichworte in Einzeldateien...:' 
         copy to key1 fields keyword1 
         copy to key2 fields keyword2 
         copy to key3 fields keyword3 
         copy to key4 fields keyword4 
         copy to key5 fields keyword5 
         copy to key6 fields keyword6 
         copy to key7 fields keyword7 
         copy to key8 fields keyword8 
         ? 'Generieren der Einzelstichwortlisten.......:' 
         use key1 
         copy to key1.txt delimited with blank 
         use key2 
         copy to key2.txt delimited with blank 
         use key3 
         copy to key3.txt delimited with blank 
         use key4 
         copy to key4.txt delimited with blank 
         use key5 
         copy to key5.txt delimited with blank 
         use key6 
         copy to key6.txt delimited with blank 
         use key7 
         copy to key7.txt delimited with blank 
         use key8 
         copy to key8.txt delimited with blank 
         ? 'Generieren der Gesamtstichwortlisten.......!' 
         use tempkey 
         copy structure to wort 
         use wort 
         ? 'Einlesen aus Einzelstichwortlisten.........:' 
         append from key1.txt delimited 
         append from key2.txt delimited 
         append from key3.txt delimited 
         append from key4.txt delimited 
         append from key5.txt delimited 
         append from key6.txt delimited 
         append from key7.txt delimited 
         append from key8.txt delimited 
         ? 'Sortieren der Gesamtstichwortliste.........:' 
         index on keywords to wort 
         sort on keywords to keysort 
         use keysort 
         ? 'Leereintragungen beseitigen................:' 
         delete for keywords=" " 
         pack 
         ? 
         ? 
         ? 'Generieren und abspeichern der Liste: KEYWORDS.TXT'         ? 
         ERASE keywords.txt 
         copy to keywords.txt delimited with blank 

	* Die Datei  KEYWORDS.TXT  enth��lt noch Doppeleintr��ge,
	* welche vom Turbo-Pascal Programm  KEYPACK.COM  
	* heraus gefiltert werden. �r      ܌
         SET CONFIRM OFF 
         STORE ' ' TO wait_subst 
         @ 23,0 SAY 'Eine Taste f��r weiter....' GET wait_subst 
         READ 
         SET CONFIRM ON 
 
 
      CASE selectnum = 4 
      *  DO Datenbankinhalte zusammenfassen 
         CLEAR 
         SET TALK OFF 
         USE lit INDEX lit 
 
         @ 1,25 SAY 'Zusammenfassen von Datenbanken:' 
         @ 2,25 SAY '��Ą��Ą��##Ą��((Ą��--Ą��22Ą�'77Ą
         @ 4,0  SAY 'Inhalt der Literatur-Datenbank  
				 LIT.DBF  wird erweitert.' 
         @ 5,0  SAY 'Hierzu bitte eine Datenbank eingeben...' 
         ? 
         ACCEPT "Dateinamen bitte eingeben 
			  (z.B.: A:TEMP.DBF)  : " TO datei 
         READ 
         ? 
         IF .NOT. FILE("&datei") 
          @ 12,10 SAY 'ACHTUNG:  Datei  n i c h t  vorhanden !'          READ 
         ENDIF 
 
         IF FILE("&datei") 
          USE lit 
          STORE 0 TO doppel 
          @ 8,0 SAY 'Einlesen der  n e u e n  
				 Daten..........�.:' 
          APPEND FROM &datei 
          ERASE ssort.ndx 
          ? 'Indizieren der Datenbank.................:' 
          INDEX ON k��rzel TO ssort 
          ERASE ssort.dbf 
          ERASE ssort.dbt 
          ? 'Sortieren der Datenbank..................:' 
          SORT ON k��rzel TO ssort 
          USE ssort 
          SET TALK OFF 
          GO TOP 
          ? 'Suchen der Doppeleintr��ge................:' 
          DO WHILE .NOT. EOF() 
             STORE zeitschrft TO alt 
             SKIP 
             STORE zeitschrft TO neu 
             IF (alt=neu) 
                DELETE 
                * Z��hlen der Dopeleintragungen
			 doppel = doppel + 1 
		   ENDIF 
          ENDDO 
          ? 'Eliminieren der Doppeleintr��ge...........:' 
          PACK �r      ܌          ? 'Anzahl der neuen 
		   Datens��tze              : �',reccount() 
          
		? 'Anzahl der 
		Doppeleintr��ge                : �',doppel,' �gel��scht' 
          ERASE lit.dbf 
          ERASE lit.dbt 
          ? 'Dateien auf Platte umbenennen & umordnen :' 
          ? 
          CLOSE DATABASES 
          COPY FILE ssort.dbf TO lit.dbf 
          COPY FILE ssort.dbt TO lit.dbt 
          ? 'Literaturdatei:  LIT.DBF  wurde 
		   erfolgreich er�weitert.' 
        ENDIF 
 
         SET CONFIRM OFF 
         STORE ' ' TO wait_subst 
         @ 23,0 SAY 'Eine Taste f��r weiter....' GET wait_subst 
         READ 
         SET CONFIRM ON 

      CASE selectnum = 5 
         SET TALK OFF 
         CLEAR 
         TEXT 
                                 H i l f e: 

� �Unter Punkt 1 wird die Literaturdatenbank  LIT.DBF  ein�gelesen und nach dem Feld  K��RZEL  alphabetisch sor�tiert. �>�

� �Unter Punkt 2 wird der gesamte Inhalt der Literaturdaten�bank LIT.DBF in eine ASCII-Datei abgespeichert. Man hatdie Wahl �zwischen einer kurzen (ARTIKEL.TXT) und einerausf��hrlichen (LIT.LST) Datenbankliste. Die Datei  LIT.LST wird anschlie����e�nd zu  LIT.ADI  konver�tiert. Die Da�teienARTIKEL.TXT und LIT.ADI sind dann mit beliebigen Textedi�toren (z.B.: WordPerfect) bearbeitbar. �>�

� �Unter Punkt 3 wird eine Liste aller Stichworteintr��gegene�riert. Die ASCII-Datei  KEYWORDS.TXT  enth��lt alleEintr��ge der Daten�bankfelder KEYWORDn (n=1-8) alphabe�tischsortiert. Kommt ein Stichwort doppelt vor, so wird es nur e i n m a l  aufgef��hrt. �>�

� �Unter Punkt 4 werden zwei Datenbanken zur Literatur-Daten�bank  LIT.DBF  zusammengefa����t�, doppelte Eintr��ge werdennur  e i n m a l  aufgenommen. �>�
� �(W i c h t i g: Vergleichskriterium ist das Daten�bankfeld:ZEITSCHRFT) �>�
         ENDTEXT 
         SET CONFIRM OFF 
         STORE ' ' TO wait_subst 
         @ 23,0 SAY 'Eine Taste f��r weiter....' GET wait_subst 
         READ 
         SET CONFIRM ON 

ENDCASE �r      ܌ENDDO T 
RETURN 
* EOF: SERVICE.PRG 
