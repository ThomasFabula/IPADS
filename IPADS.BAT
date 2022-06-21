echo=off
cls
rem  ***********************************
rem  Stapeldatei fÅr Literaturverwaltung
rem  *****    I   P   A   D   S    *****
rem  ***********************************
type ipads.sgn
pause
cls
type ipads.doc
pause
if exist such?.db? del such?.db?
if exist temp.db?  del temp.db?
if exist suche.txt del suche.txt
..\dbase ipads
cls
type ipads.end
rem  Datenbank-Dateien auf Platte:
if exist such?.dbf dir such?.dbf/w
rem  Dokumentations-Textdatei auf Platte:  SUCHE.TXT
type ipads.bac
rem if exist sort.dbf copy sort.dbf lit.dbf
rem if exist sort.dbt copy sort.dbt lit.dbt
rem if exist sort.ndx copy sort.ndx lit.ndx
rem if exist sort.* del sort.*
echo=on
