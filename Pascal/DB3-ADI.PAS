{ DB3-ADI   :  Konvertierprogramm fr IPADS

Programm konvertiert Literaturdaten von dBASE III+ in
eine ASCII-Datei, welche von ADIMENS gelesen werden kann. Die entsprechende Literatur-Datenbank muá in der Form (delimited with #)vorliegen.

Die Eingabedatei muss die Endung .LST tragen (z.B.: name.LST) und folgende Felder enthalten:

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
  WRITE(' : ',KURZEL);

  stelle:=stelle+2;
  gebiet:=' ';
  repeat
    dummy:=copy(zeilex,stelle,1);
    stelle:=stelle+1;
    gebiet:=gebiet + dummy;
  until (dummy='#');
  pos:=length(gebiet);
  delete(gebiet,pos,1);
  WRITE('  - ',GEBIET,' - ');

  stelle:=stelle+2;
  subgebiet:=' ';
  repeat
    dummy:=copy(zeilex,stelle,1);
    stelle:=stelle+1;
    subgebiet:=subgebiet + dummy;
  until (dummy='#');
  pos:=length(subgebiet);
  delete(subgebiet,pos,1);
  WRITELN(SUBGEBIET);

  stelle:=stelle+2;
  titel:=' ';
  repeat
    dummy:=copy(zeilex,stelle,1);
    stelle:=stelle+1;
    titel:=titel + dummy;
  until (dummy='#');
  pos:=length(titel);
  delete(titel,pos,1);
  { WRITELN('=',titel,'='); }

  stelle:=stelle+2;
  autoren:=' ';
  repeat
    dummy:=copy(zeilex,stelle,1);
    stelle:=stelle+1;
    autoren:=autoren + dummy;
  until (dummy='#');
  pos:=length(autoren);
  delete(autoren,pos,1);
  { WRITELN('=',autoren,'='); }

  stelle:=stelle+2;
  zeitschrft:=' ';
  repeat
    dummy:=copy(zeilex,stelle,1);
    stelle:=stelle+1;
    zeitschrft:=zeitschrft + dummy;
  until (dummy='#');
  pos:=length(zeitschrft);
  delete(zeitschrft,pos,1);
  { WRITELN('=',zeitschrft,'='); }
end;

begin
  ausgabe:=TRUE;
  clrscr;
  writeln('Dateikonvertierung:          DB3 -> ADI');
  writeln('===================');
  write('Eingabedatei (.LST wird gesetzt) : ');
  readln(namein);
  nameout := namein + '.ADI';
  namein  := namein + '.LST';
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
    readln(infile,zeile);
    write(i:5);
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
  if not ausgabe then gotoxy(1,6);
  writeln(#7,'Konvertierung beendet !');
  writeln('Datei  ',nameout,'  wurde ordungsgemaess erzeugt.');
end.
