DROP TABLE IF EXISTS "PCviewdb"."UitlegComponent";
DROP TABLE IF EXISTS "PCviewdb"."AntwoordHighscore";
DROP TABLE IF EXISTS "PCviewdb"."Highscore";
DROP TABLE IF EXISTS "PCviewdb"."Antwoord";
DROP TABLE IF EXISTS "PCviewdb"."Vraag";
DROP SCHEMA IF EXISTS "PCviewdb";

CREATE SCHEMA IF NOT EXISTS "PCviewdb";

CREATE TABLE IF NOT EXISTS "PCviewdb"."Vraag"(
    "vraagId" SERIAL NOT NULL PRIMARY KEY,
    "vraag" VARCHAR(1024) NOT NULL
);

CREATE TABLE IF NOT EXISTS "PCviewdb"."Antwoord"(
    "antwoordId" SERIAL NOT NULL PRIMARY KEY,
    "antwoord" VARCHAR(1024) NOT NULL,
    "correct" BOOLEAN NOT NULL,
    "score" INT,
    "vraagId" INT NOT NULL,
    CONSTRAINT FK_vraagId
        FOREIGN KEY ("vraagId")
        REFERENCES "PCviewdb"."Vraag" ("vraagId")
);

CREATE TABLE IF NOT EXISTS "PCviewdb"."Highscore"(
    "highscoreId" SERIAL NOT NULL PRIMARY KEY,
    "gebruikersnaam" VARCHAR(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS "PCviewdb"."AntwoordHighscore"(
    "antwoordId" SERIAL NOT NULL,
    "highscoreId" SERIAL NOT NULL,
    PRIMARY KEY ("antwoordId", "highscoreId"),
    CONSTRAINT FK_antwoordId
        FOREIGN KEY ("antwoordId")
        REFERENCES "PCviewdb"."Antwoord" ("antwoordId"),
    CONSTRAINT FK_highscoreId
        FOREIGN KEY ("highscoreId")
        REFERENCES "PCviewdb"."Highscore" ("highscoreId")
);

CREATE TABLE IF NOT EXISTS "PCviewdb"."UitlegComponent"(
    "uitlegComponentId" SERIAL NOT NULL PRIMARY KEY,
    "componentNaam" VARCHAR(32) NOT NULL,
    "uitlegComponent" VARCHAR(2048) NOT NULL
);

INSERT INTO "PCviewdb"."UitlegComponent" ("componentNaam", "uitlegComponent")
VALUES ('Behuizing', 'De behuizing dient om je componenten te beschermen. De vormen lopen ver uiteen afhankelijk van de toepassing of voorkeur.'),
    ('Processor', 'De processor in het Engels is Central Processing Unit, afgekort CPU. De processor is het brein van de computer.\nKort door de bocht, een processor is een klein plaatje gemaakt van zand. Met behulp van UV-straling kunnen we kanalen maken met sluizen. Deze sluizen kunnen open en dicht, respectievelijk in computer term een 1 en een 0. Zonder dit kan de computer niet opstarten.'),
    ('Processor koeler', 'Processoren verbruiken relatief gezien veel elektriciteit en worden dus warm. Daarom moeten deze gekoeld worden.\nVormen en manier van koelen lopen ver uiteen. De meest voorkomende manier is luchtkoeling, want het is goedkoop en gaan erg lang mee. Ze hebben alleen de ventilator als bewegende onderdeel. Als de ventilator toch kapot gaan is dit ook makkelijk te vervangen.\nEen andere vorm is waterkoeling. Je kan dit kant-en-klaar of elk onderdeel apart kopen.\nDe all-in-one of AIO-waterkoeler is kant-en-klaar, een doorsnee AIO-waterkoeler is beter dan een doorsnee luchtkoeler. Het nadeel is dat ze niet modulair zijn en minder lang mee gaan. Als de waterpomp kapot is moet de hele waterkoeling systeem vervangen worden.\nEen custom waterloop is een waterkoeling systeem dat de gebruiker zelf in elkaar steekt. Dit bestaat uit waterpomp, de coldplate (dit maakt contact met de processor), de buizen en het reservoir. Het voordeel is dat dit langer meegaan dan de AIO. Maar heeft meer onderhoud en initiële investering nodig.'),
    ('Videokaart', 'Een videokaart zorgt ervoor dat je als eerst een beelduitgang hebt om je monitor hebt om aan te sluiten. Vervolgens zorgt die ervoor dat er beeld wordt verwerkt. De vorm en grootte verschilt enorm. Niet elke computer heeft een aparte videokaart nodig. De meeste processoren hebben een kleine videokaart ingebouwd.\nAls de meest intensieve taak een grafiek tonen in excel is een ingebouwde grafische kaart meer dan genoeg.\nAls je iemand bent die video spellen speelt, lokaal AI draait of 3D-animaties maakt, is een aparte sterke grafische kaart aangeraden.'),
    ('Harde schijf', 'Een opslagmedia die een naald gebruikt om data te lezen en schrijven op een ronddraaiende schijf.\nHet voordeel is dat dit goedkoop is en in belachelijk grote capaciteiten beschikbaar zijn, tot wel 26 TB (terabytes).\nHet nadeel is dat dit traag is, want er is een naald dat fysiek moet draaien naar een specifiek locatie en dat kost tijd. Vaak staan gegevens verspreid en zal de naald heen en weer moeten springen. En stel de bestanden staan netjes op een rij, zijn we nog steeds gelimiteerd op de snelheid dat de schijf ronddraait.\nWe raden aan dit alleen te kopen als je **veel** en goedkoop opslag nodig hebt en als snelheid niet essentieel is.'),
    ('Moederbord', 'Dit is een essentieel onderdeel, want dit is het kruispunt tussen alle andere onderdelen. Alles wordt met het moederbord verbonden.'),
    ('Netwerk kaart', 'Een netwerk kaart dient om verbinding te maken met het internet. Een netwerk kaart heeft een ethernet poort dat rechtstreeks connectie maakt met het moederbord via een PCI-E slot.\nVaak hebben de computers dit niet meer nodig, want tegenwoordig zijn de ingebouwde ethernet poorten snel genoeg en betrouwbaar.'),
    ('Voeding', 'Een voeding zorgt dat 240 V omgezet worden naar veilige voltages voor de computer onderdelen, bijvoorbeeld 12 V, 5 V en 3,3 V.'),
    ('RAM stick', 'RAM of wel Random Access Memory is het interne geheugen van computers. Hoe meer interne geheugen, hoe meer programma''s je tegelijkertijd open kan hebben.\nDit is een van de makkelijkste onderdelen om te upgraden, maar jammer genoeg zijn we in de laptop industrie dat er meer en meer RAM worden gesoldeerd op het moederbord. Dit valt niet te upgraden.\nDaarom raden we je aan om niet minder dan 16 GB aan RAM te kopen.'),
    ('SSD', 'Solid state drive of SSD is een opslagmedium zonder bewegende onderdelen. Data wordt gelezen door elektronen te verplaatsen in "cellen". Als er geen elektron in een cel zit is het een 0, als dat wel zo is het een 1.\nHet voordeel ten opzichte van een harde schijf is dat deze heel snel zijn, in sommige gevallen honderden keren sneller.\nHet nadeel is dat deze duurder zijn dan harde schijven.')
;

INSERT INTO "PCviewdb"."Vraag" ("vraag") 
VALUES
	('Kan een computer zonder opslagmediums (SSD, HDD, USB-stick, ...) opstarten?'),
	('Waar staat RAM voor?'),
	('Welke onderdeel steek je eerst op een moederbord?'),
	('Wat doet een CPU?'),
	('Wat gebeurt er met je data als de stroom wordt onderbroken?'),
	('Drie jaar geleden kocht ik een computer met Windows 7. De computer is snel genoeg voor mijn taken, maar software wordt niet meer ondersteunt. Ik wil een ander besturingssysteem op installeren. Kan dit? (Negeer Windows 11 TPM vereisten)'),
	('Mijn oude computer is heel traag. Wanneer ik Word wil starten moet ik een minuut wachten. Ik zie in taakbeheer dat mijn processor niet veel doet. Voor intern geheugen is er 5 van de 16 GB in gebruik, maar mijn harde schijf draait continu op 100%. Welke upgrade heb ik nodig?'),
	('Kan elke computer een server zijn?'),
	('Moet je de laatste versie kopen van processors als je alleen YouTube, e-mails en Word gebruikt?'),
	('Welke componenten heb je zéker nodig om in de BIOS van een PC te geraken?')
;

INSERT INTO "PCviewdb"."Antwoord" ("antwoord", "correct", "score", "vraagId") 
VALUES
    ('Ja', false, 0, 1),
    ('Nee', true, 1, 1),
    ('Een dier', false, 0, 2),
    ('Random Access Memory', true, 1, 2),
    ('Restricted Access Management', false, 0, 2),
    ('Remote Application Management', false, 0, 2),
    ('CPU', false, 0, 3),
    ('RAM', false, 0, 3),
    ('SSD', false, 0, 3),
    ('Maakt niet uit', true, 1, 3),
    ('Uitvoer voor beeld', false, 0, 4),
    ('Gegevens opslaan', false, 0, 4),
    ('Berekeningen uitvoeren', true, 1, 4),
    ('Stroom voorzien', false, 0, 4),
    ('Al het data wordt opgeslagen', false, 0, 5),
    ('Al het data in RAM is veilig, maar gegevens op extern geheugen is weg', false, 0, 5),
    ('Al het data in RAM is weg, maar gegevens op extern geheugen is veilig', true, 1, 5),
    ('Al het data is weg', false, 0, 5),
    ('Ja', true, 1, 6),
    ('Ja, alleen als alle onderdelen hetzelfde zijn', true, 0, 6),
    ('Nee', false, 0, 6),
    ('CPU', false, 0, 7),
    ('RAM', false, 0, 7),
    ('GPU', false, 0, 7),
    ('Snellere opslag (SSD)', true, 1, 7),
    ('Ja', true, 1, 8),
    ('Ja, enkel als het in een server rek past', false, 0, 8),
    ('Nee', false, 0, 8),
    ('Neen, behalve als je Linux gebruikt', false, 0, 8),
    ('Ja', false, 0, 9),
    ('Nee', true, 1, 9),
    ('PC-behuizing', false, 0, 10),
    ('RAM', true, 1, 10),
    ('Voeding', true, 1, 10),
    ('CPU', true, 1, 10),
    ('GPU', false, 0, 10),
    ('Een opslagmedium', false, 0, 10),
    ('Moederbord', true, 1, 10),
    ('CPU-koeler', false, 0, 10),
    ('Behuizing ventilator', false, 0, 10)
;



