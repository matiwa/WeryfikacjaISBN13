program WeryfikacjaISBN13;
uses
SysUtils;



var
ISBN : String;
prefiks : String;
kodKraju : String;
kodWydawcy : String;
kodKsiazki : String;
sumaKontrolna : String;
dodatkowy : String;
poprawnosc : Boolean;

kodyKrajow : array[0..143] of Integer = (
0, 1, 2, 3, 4, 5, 7, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 950, 951,
952, 953, 954, 955, 956, 957, 958, 959, 960, 961, 962, 963, 964, 965, 966, 967, 968,
969, 970, 971, 972, 973, 974, 975, 976, 977, 978, 979, 980, 981, 982, 983, 984, 985,
986, 987, 988, 989, 9946, 9947, 9948, 9949, 9951, 9952, 9953, 9954, 9955, 9956, 9957,
9958, 9959, 9960, 9961, 9962, 9963, 9964, 9965, 9966, 9967, 9968, 9970, 9971,
9972, 9973, 9974, 9975, 9976, 9977, 9978, 9979, 9980, 9981, 9982, 9983, 9984,
9985, 9986, 9987, 9988, 9989, 99901, 99902, 99903, 99904, 99905, 99906, 99908,
99909, 99910, 99911, 99912, 99913, 99914, 99915, 99916, 99917, 99918, 99919,
99920, 99921, 99922, 99923, 99924, 99925, 99926, 99927, 99928, 99929, 99930,
99931, 99932, 99933, 99934, 99935, 99936, 99937, 99938, 99939, 99940, 99941, 99942
);

kraje : array [0..143] of String = (
'Obszar anglojęzyczny: Australia, Kanada, Gibraltar, Irlandia, (Namibia), Nowa Zelandia, Puerto Rico, Republika Południowej Afryki, Swaziland, UK, USA, Zimbabwe',
'Obszar anglojęzyczny: Australia, Kanada, Gibraltar, Irlandia, (Namibia), Nowa Zelandia, Puerto Rico, Republika Południowej Afryki, Swaziland, UK, USA, Zimbabwe',
'Obszar francuskojęzyczny: Francja, Belgia, Kanada, Luksemburg, Szwajcaria',
'Obszar niemieckojęzyczny: Austria, Niemcy, Szwajcaria', 'Japonia',
'Federacja Rosyjska, Ukraina, Bialoruś, Estonia, Litwa, Kazahstan, Kirgistan, Mołdawia, Łotwa, Georgia, Armenia',
'Chiny', 'Czechy, Słowacja', 'Indie', 'Norwegia', 'Polska', 'Hiszpania', 'Brazylia',
'Bośnia i Hercegowina, Chorwacja, Macedonia, Słowenia', 'Dania',
'Obszar włoskojęzyczny: Włochy, Szwajcaria', 'Korea', 'Holandia', 'Holandia, Belgia, Szwecja',
'Wydawcy międzynarodowi (UNESCO, UE), Organizacje Wspólnoty Europejskiej', 'Indie', 'Argentyna',
'Finlandia', 'Finlandia', 'Chorwacja', 'Bułgaria', 'Sri Lanka', 'Chile', 'Tajwan, Chiny', 'Columbia',
'Kuba', 'Grecja', 'Słowenia', 'Hong Kong', 'Węgry', 'Iran', 'Izrael', 'Ukraina', 'Malezja', 'Meksyk',
'Pakistan', 'Meksyk', 'Filipiny', 'Portugalia', 'Rumunia', 'Tajlandia', 'Turcja', 'Karaiby', 'Egipt',
'Nigeria', 'Indonezja', 'Wenezuela', 'Singapur', 'Południowy Pacyfik', 'Malezja', 'Bangladesz',
'Białoruś', 'Tajwan, Chiny', 'Argentyna', 'Hongkonga', 'Portugalia', 'Korea', 'Algieria', 'Estonia',
'Palestyna', 'Kosowo', 'Azerbejdżan', 'Liban', 'Maroko', 'Litwa', 'Kamerun', 'Jordania',
'Bośnia i Hercegowina', 'Libia', 'Arabia Saudyjska', 'Algieria', 'Panama', 'Cypr', 'Ghana',
'Kazachstan ', 'Kenia', 'Kirgistan', 'Kostaryka', 'Uganda', 'Singapur', 'Peru', 'Tunezja', 'Urugwaj',
'Mołdawia', 'Tanzania', 'Kostaryka', 'Ekwador', 'Islandia', 'Papua Nowa Gwinea', 'Maroko', 'Zambia',
'Gambia', 'Łotwa', 'Estonia', 'Litwa', 'Tanzania', 'Ghana', 'Macedonia', 'Bahrain', 'Gabon',
'Mauritius', 'Antyle Holenderskie', 'Boliwia', 'Kuwejt', 'Malawi', 'Malta', 'Sierra Leone',
'Lesoto', 'Botswana', 'Andora', 'Suriname', 'Malediwy', 'Namibia',  'Brunei Darussalam',
'Wyspy Faroe', 'Benin', 'Andora', 'Katar', 'Gwatemala', 'El Salvador', 'Nikaragua', 'Paragwaj',
'Honduras', 'Albania', 'Georgia', 'Mongolia', 'Armenia', 'Seszele', 'Malta', 'Nepal',
'Republika Dominikany', 'Haiti', 'Butan', 'Makao', 'Serbia', 'Gwatemala', 'Georgia',
'Armenia', 'Sudan'
);

function  usunSpacjeWISBN(ISBN : String) : String;
var
wyjscieISBN : String;
i : Integer;
begin
wyjscieISBN := '';
for i:=1 to length(ISBN) do
if ISBN[i] <> ' ' then
wyjscieISBN := wyjscieISBN + ISBN[i];
Result := wyjscieISBN;
end;

function wypelnianiePol(ISBN : String) : Integer;
var
i : Integer;
pole : Integer;
begin
pole := 0;
prefiks := '';
kodKraju := '';
kodWydawcy := '';
kodKsiazki := '';
sumaKontrolna := '';
dodatkowy := '';
for i:=1 to length(ISBN) do
begin
if ISBN[i] = '-' then
pole := pole + 1
else
case pole of
0 : prefiks := prefiks + ISBN[i];
1 : kodKraju := kodKraju + ISBN[i];
2 : kodWydawcy := kodWydawcy + ISBN[i];
3 : kodKsiazki := kodKsiazki + ISBN[i];
4 : sumaKontrolna := sumaKontrolna + ISBN[i];
end;
end;
Result := pole;
end;

function sprawdzanieSumyKontrolnej(): Boolean;
var
licznik, suma, i : Integer;
begin
licznik := 0;
suma := 0;
if (length(sumaKontrolna) <> 1) then
begin
result := false;
end
else
begin
for i:=1 to length(prefiks) do
begin
licznik := licznik + 1;
if (licznik mod 2) = 0 then
suma := suma + (StrToInt(prefiks[i]) * 3)
else
suma := suma + StrToInt(prefiks[i]);
end;
for i:=1 to length(kodKraju) do
begin
licznik := licznik + 1;
if (licznik mod 2) = 0 then
suma := suma + (StrToInt(kodKraju[i]) * 3)
else
suma := suma + StrToInt(kodKraju[i]);
end;
for i:=1 to length(kodWydawcy) do
begin
licznik := licznik + 1;
if (licznik mod 2) = 0 then
suma := suma + (StrToInt(kodWydawcy[i]) * 3)
else
suma := suma + StrToInt(kodWydawcy[i]);
end;
for i:=1 to length(kodKsiazki) do
begin
licznik := licznik + 1;
if (licznik mod 2) = 0 then
suma := suma + (StrToInt(kodKsiazki[i]) * 3)
else
suma := suma + StrToInt(kodKsiazki[i]);
end;
suma := suma mod 10;
suma := 10 - suma;
suma := suma mod 10;
if suma = StrToInt(sumaKontrolna) then
result := true
else
result := false;
end;
end;

function zwrocKraj(): String;
var
kod, i, j: Integer;
begin
result := 'nieznany';
kod := 0;
for  i:=1 to length(kodKraju) do
begin
kod := kod * 10;
kod := kod + StrToInt(kodKraju[i]);

for j:=0 to 143 do
begin
if kodyKrajow[j] = kod then
begin
result := kraje[j];
exit;
end;
end;
end;
end;


begin
write('Podaj numer ISBN: ');
readln(ISBN);
ISBN := usunSpacjeWISBN(ISBN);

if (wypelnianiePol(ISBN) = 4) and
((length(ISBN) = 17) or (length(ISBN) = 22) and
(length(prefiks) = 3) and
(length(kodKraju) > 0) and
(length(kodKraju) < 6)) then
begin
if (length(sumaKontrolna) = 6) and
(length(ISBN) = 18) then
begin
dodatkowy := Copy(sumaKontrolna, 2, 6);
sumaKontrolna := sumaKontrolna[1];
end;
poprawnosc := sprawdzanieSumyKontrolnej();
end
else
poprawnosc := False;

if poprawnosc = True then
begin
writeln('Numer ISBN jest prawidlowy');
writeln('Prefiks: ' + prefiks);
writeln('kodKraju/jezyk: ' + zwrocKraj);
writeln('Kod kraju: ' + kodKraju);
writeln('Kod wydawcy: ' + kodWydawcy);
writeln('Kod ksiazki: ' + kodKsiazki);
writeln('Suma kontrolna: ' + sumaKontrolna);
end
else
writeln('Numer ISBN jest nieprawidlowy');

readln;
end.
