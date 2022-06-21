{ Scanprogramm fuer IPADS.

  Programm scannt Literaturdaten
  von ADIMENS nach Keywords...
}

program scanner;

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
        i,ii,j,k          :  integer;

procedure initialisiere;
begin
  subgebiet:=' ';
  for k:=1 to 8 do key[k]:=' ';
end;

procedure sortiere_forschungsgebiet;
var i1,i2 : char;
begin
  i1:=copy(index,1,1);
  i2:=copy(index,2,1);

  if (i1='1')  then                  gebiet:='Laser Cooling';
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


end;

begin
  clrscr;
  writeln('Keywordscan:');
  writeln('============');
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
    initialisiere;
  {  gotoxy(1,5);
    write('Record-No.: ',i:5);
  }
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

    writeln(i:3,' - ',keywords);

    readln(infile,dummy);         { Leerzeile }

    sortiere_forschungsgebiet;
    sortiere_keywords;
    jahr:=copy(kurzel,4,2);
    jahrgang:=century + jahr;

    { Einen Record schreiben }
    write(outfile,  '#',kurzel,'#,#',titel,'#,#',gebiet,'#,#',subgebiet,'#,#');
    write(outfile,  autoren,'#,#',journal1,'#,#',journal2,'#,',jahrgang,',##,#');
    writeln(outfile,anmerkungen,'#');
    for j:=1 to 8 do write(outfile,',#',key[j],'#');
    writeln(outfile);
    i:=i+1;
  until EOF(infile);
  close(infile);
  close(outfile);
{  gotoxy(1,6);     }
  writeln('Konvertierung beendet !');
  writeln('Datei  ',nameout,'  wurde ordungsgemaess erzeugt.');
end.
