quiz_explanation_query = 'SELECT "uitlegComponent" FROM "PCviewdb"."UitlegComponent" WHERE "componentNaam" = %s'

quiz_query = 'SELECT v."vraag", v."uitlegWaaromGoed", a."correct", a."antwoord" FROM "PCviewdb"."Vraag" v JOIN "PCviewdb"."Antwoord" a ON a."vraagId" = v."vraagId" JOIN "PCviewdb"."Categorie" c ON c."categorieId" = v."categorieId" WHERE c."naam" = ''%s'''
