{ ADI-DB3   :  Konvertierprogramm fuer IPADS

Programm konvertiert Literaturdaten von ST-ADIMENS in dBASE III+  lesbare ASCII-Dateien (delimited with #).
Die Eingabedatei muá die Endung .MRG tragen (z.B.: name.MRG) und folgendes Format besitzen:

1. Zeile : Beliebiges ASCII-Zeichen  (z.B.: = )
2. Zeile : Kuerzel                   (max.   6 Zeichen)
3. Zeile : Index                     (max.   8 Zeichen)
4. Zeile : Titel                     (max. 100 Zeichen)
5. Zeile : Autoren                   (max. 100 Zeichen)
6. Zeile : Journal1                  (max.  80 Zeichen)
7. Zeile : Journal2                  (max.  80 Zeichen)
8. Zeile : Anmerkungen               (max.  80 Zeichen)
9. Zeile : Keywords                  (max.  30 Zeichen)
10.Zeile : Leerzeile

Anschliessend folgen beliebig viele Eintraege (Records) nach obigen Format. Die konvertierte Textdatei  name.TXT  laesst sich dann von dBASE III aus, nachdem eine Datenbank mit der entsprechenden Struktur (siehe IPADS: LIT.DBF) angewaehlt wurde, mit folgendem Befehl einlesen:

      APPEND FROM  name  DELIMITED WITH #

Hiernach kann die primaere Literaturdatenbank  LIT.DBF  von IPADS  mit Hilfe des  SERVICE  dBASE-Programms erweitert werden.

}

program convert;

const   century        =  '19';

var     dummy          :  string[80];
        kurzel         :  string[6];
        index          :  string[8];
        gebiet         :  string[25];
        subgebiet      :  string[25];
        titel          :  string[100];
        autoren        :  string[100];
        journal1       :  string[80];
        journal2       :  string[80];
        jahr,jahrgang  :  string[4];
        anmerkungen    :  string[80];
        key            :  array [1..8] of string[30];
        keywords       :  string[30];
        infile,outfile :  text;
        namein,nameout :  string[12];
        i,ii,j,k       :  integer;
        ausgabe        : boolean;


procedure sortiere_forschungsgebiet;
var i1,i2,i3,i5 : char;
begin
  subgebiet:=' ';
  i1:=copy(index,1,1);
  i2:=copy(index,2,1);

  if (i1='1')  then
    begin
      gebiet:='Laser Cooling';
      i3:=copy(index,3,1);
      if ((i3='1') or (i3='3') or (i3='9')) then subgebiet:='General';
      if ((i3='4') or (i3='5'))             then subgebiet:='Deflection';
      if (i3='2')                           then subgebiet:='Theory';
      if (i3='6')                           then subgebiet:='Focussing';
      if (i3='7')                           then subgebiet:='Deceleration';
      if (i3='8') then
        begin
          i5:=copy(index,5,1);
          if (i5='1')                       then subgebiet:='Magnetic Traps';
          if ((i5='2') or (i5='3'))          then subgebiet:='Optical Traps';
        end;
    end;

  if (i1='2')  then                  gebiet:='Atomic Physics';
  if (i1='5')  or
     ((i1='1') and (i2='1'))  then   gebiet:='Quantum Optics';
  if ((i1='6') or  (i1='7'))  then   gebiet:='Ion Traps';
  if ((i1='8') or  (i1='9')   or
      (i1='3') or
     ((i1='1') and (i2='2'))  or
     ((i1='1') and (i2='3'))) then   gebiet:='Laser Tech';
end;

procedure sortiere_keywords;
begin
  {
    Hier koennten eventuell die Keyword-Abkuerzungen
    ausgewertet werden...
  }
end;

begin
  ausgabe:=TRUE;
  clrscr;
  writeln('Dateikonvertierung:          ADI -> DB3');
  writeln('===================');
  write('Eingabedatei (.MRG wird gesetzt) : ');
  readln(namein);
  nameout := namein + '.TXT';
  namein  := namein + '.MRG';
  assign(infile,namein);
  assign(outfile,nameout);
  reset(infile);
  rewrite(outfile);
  writeln('Konvertierung in Arbeit...');
  i:=1;
  repeat
    if not ausgabe then
      begin
        gotoxy(1,5);
        write('Record-No.: ',i:5);
      end;
    { Einen Record einlesen }
    readln(infile,dummy);         { = Zeichen }
    readln(infile,kurzel);
    readln(infile,index);
    readln(infile,titel);
    readln(infile,autoren);
    readln(infile,journal1);
    readln(infile,journal2);
    readln(infile,anmerkungen);
    readln(infile,keywords);
    readln(infile,dummy);         { Leerzeile }

    if ausgabe then writeln(i:5,' : ',kurzel,' - ',gebiet,' =  ',subgebiet);

    sortiere_forschungsgebiet;
    sortiere_keywords;
    jahr:=copy(kurzel,4,2);
    jahrgang:=century + jahr;

    { Einen Record schreiben }
    write(outfile,  '#',kurzel,'#,#',titel,'#,#',gebiet,'#,#',subgebiet,'#,#');
    write(outfile,  autoren,'#,#',journal1,'#,#',journal2,'#,',jahrgang,',##,#');
    writeln(outfile,anmerkungen,'#,#',keywords,'#,##,##,##,##,##,##,##');
    i:=i+1;
  until EOF(infile);
  close(infile);
  close(outfile);
  if not ausgabe then gotoxy(1,6);
  writeln(#7,'Konvertierung beendet !');
  writeln('Datei  ',nameout,'  wurde ordungsgemaess erzeugt.');
end.

