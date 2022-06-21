echo=off
dbase service
if exist key?.* del key?.*
rem if exist lit.lst del lit.lst
if exist keysort.* del keysort.*
if exist wort.* del wort.*
if exist keywords.txt keypack
if exist keywords.txt del keywords.txt
if exist filter.txt ren filter.txt keywords.txt
rem Konvertieren der Literaturliste
if exist lit.lst litconv
if exist *.txt dir *.txt/w
if exist *.adi dir *.adi
echo=on
