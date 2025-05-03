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
    "uitlegComponentNaam" VARCHAR(64) NOT NULL,
    "uitlegComponent" VARCHAR(2048) NOT NULL
);
