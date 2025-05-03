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
