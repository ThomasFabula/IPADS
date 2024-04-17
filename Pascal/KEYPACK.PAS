program keypack;

const max    = 1000;

type  str25  = string[25];

var   infile,out : text;
      i      : integer;
      dummy  : str25;
      sting  : array [0..max] of str25;

begin
  highvideo;
  writeln('Programm KEYPACK:');
  writeln('-----------------');
  lowvideo;
  writeln('Herausfiltern der Doppeleintraege von  KEYWORDS.TXT !');
  assign(infile,'KEYWORDS.TXT');
  reset(infile);
  assign(out,'FILTER.TXT');
  rewrite(out);
  for i:=1 to 3 do
  begin
    readln(infile,dummy);
    writeln(out,dummy);
  end;
  i:=1;
  readln(infile,sting[0]);
  writeln(out,sting[0]);
  repeat
   readln(infile,sting[i]);
   if (sting[i]<>sting[i-1])
     then writeln(out,sting[i]);
   i:=i+1;
  until EOF(infile);
  close(infile);
  close(out);
  writeln('Anzahl der Stichwortstrings: ',i:5);
end.
