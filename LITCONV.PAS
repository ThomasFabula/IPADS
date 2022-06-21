{ DB3-ADI   :  Konvertierprogramm fuer IPADS

geaendert:  feste Eingabedatei   LIT.LST  --> LIT.ADI

Programm konvertiert Literaturdaten von dBASE III+ in
eine ASCII-Datei, welche von ADIMENS gelesen werden kann. Die ent sprechende Literatur-Datenbank muss in der Form (delimited with #) vorliegen.

Die Eingabedatei muss die Endung .LST tragen (z.B.: name.LST) und  folgende Felder enthalten:

        KUERZEL, GEBIET, SUBGEBIET, TITEL, AUTOREN, ZEITSCHRFT

  Von dBASE aus kann sie generiert werden, indem man eingibt:

        COPY TO name.LST FIELDS (obige Liste) DELIMITED WITH #

Die konvertierte Textdatei  name.ADI  laesst sich dann von ADIMENS einlesen, oder als Textdatei (z.B.: mit WordPerfect) ausdrucken.

}

program convert;

type    long           =  string[255];

var     zeile          :  long;
        kurzel         :  string[6];
        gebiet         :  string[25];
        subgebiet      :  string[25];
        titel          :  string[80];
        autoren        :  string[80];
        zeitschrft     :  string[80];
        infile,outfile :  text;
        namein,nameout :  string[12];
        i              :  integer;
        ausgabe        :  boolean;
        pos,stelle     :  integer;
        dummy          :  string[1];


procedure felder_zuordnen(var zeilex:long);
begin
  stelle:=2;
  kurzel:=' ';
  repeat
    dummy:=copy(zeilex,stelle,1);
    kurzel:=concat(kurzel,dummy);
    stelle:=stelle+1;
  until (dummy='#');

  stelle:=stelle+2;
  gebiet:=' ';
  repeat
    dummy:=copy(zeilex,stelle,1);
    stelle:=stelle+1;
    gebiet:=gebiet + dummy;
  until (dummy='#');
  pos:=length(gebiet);
  delete(gebiet,pos,1);

  stelle:=stelle+2;
  subgebiet:=' ';
  repeat
    dummy:=copy(zeilex,stelle,1);
    stelle:=stelle+1;
    subgebiet:=subgebiet + dummy;
  until (dummy='#');
  pos:=length(subgebiet);
  delete(subgebiet,pos,1);

  stelle:=stelle+2;
  titel:=' ';
  repeat
    dummy:=copy(zeilex,stelle,1);
    stelle:=stelle+1;
    titel:=titel + dummy;
  until (dummy='#');
  pos:=length(titel);
  delete(titel,pos,1);

  stelle:=stelle+2;
  autoren:=' ';
  repeat
    dummy:=copy(zeilex,stelle,1);
    stelle:=stelle+1;
    autoren:=autoren + dummy;
  until (dummy='#');
  pos:=length(autoren);
  delete(autoren,pos,1);

  stelle:=stelle+2;
  zeitschrft:=' ';
  repeat
    dummy:=copy(zeilex,stelle,1);
    stelle:=stelle+1;
    zeitschrft:=zeitschrft + dummy;
  until (dummy='#');
  pos:=length(zeitschrft);
  delete(zeitschrft,pos,1);
end;

begin
  clrscr;
  ausgabe:=TRUE;
  writeln('L I T C O N V:');
  writeln('==============');
  writeln('Eingabedatei  LIT.LST  wird konvertiert zu  LIT.ADI...');
  nameout := 'LIT.ADI';
  namein  := 'LIT.LST';
  assign(infile,namein);
  assign(outfile,nameout);
  reset(infile);
  rewrite(outfile);
  i:=1;
  repeat
    { Einen Record einlesen }
    gotoxy(1,4);write('Record : ',i:5);
    readln(infile,zeile);
    felder_zuordnen(zeile);
    { Einen Record schreiben }
    writeln(outfile,kurzel);
    writeln(outfile,gebiet,' - ',subgebiet);
    writeln(outfile,titel);
    writeln(outfile,autoren);
    writeln(outfile,zeitschrft);
    writeln(outfile);
    i:=i+1;
  until EOF(infile);
  close(infile);
  close(outfile);
  writeln(#7);
  write('Konvertierung beendet');
  writeln(' - Datei  ',nameout,'  wurde ordungsgemaess erzeugt.');
end.
