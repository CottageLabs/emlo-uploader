--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET escape_string_warning = off;

--
-- Roles
--

CREATE ROLE burgess;
ALTER ROLE burgess WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofk021;
ALTER ROLE cofk021 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofk036;
ALTER ROLE cofk036 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofk1;
ALTER ROLE cofk1 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofk101;
ALTER ROLE cofk101 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofk2;
ALTER ROLE cofk2 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofk3;
ALTER ROLE cofk3 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofk4;
ALTER ROLE cofk4 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofk5;
ALTER ROLE cofk5 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofk6;
ALTER ROLE cofk6 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofk_read;
ALTER ROLE cofk_read WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkadmin;
ALTER ROLE cofkadmin WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkajmosley;
ALTER ROLE cofkajmosley WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkalex;
ALTER ROLE cofkalex WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkalexandra;
ALTER ROLE cofkalexandra WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkalexandre;
ALTER ROLE cofkalexandre WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkana;
ALTER ROLE cofkana WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkanita;
ALTER ROLE cofkanita WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkanna;
ALTER ROLE cofkanna WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkannamarie;
ALTER ROLE cofkannamarie WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkanton;
ALTER ROLE cofkanton WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkantonia;
ALTER ROLE cofkantonia WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkantonio;
ALTER ROLE cofkantonio WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkarno;
ALTER ROLE cofkarno WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkaron;
ALTER ROLE cofkaron WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkbenjamin;
ALTER ROLE cofkbenjamin WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkblse1;
ALTER ROLE cofkblse1 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkborbala;
ALTER ROLE cofkborbala WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkbse;
ALTER ROLE cofkbse WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkbsed1;
ALTER ROLE cofkbsed1 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkbsed2;
ALTER ROLE cofkbsed2 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkbsed3;
ALTER ROLE cofkbsed3 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkbsed4;
ALTER ROLE cofkbsed4 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkbsed5;
ALTER ROLE cofkbsed5 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkbsed6;
ALTER ROLE cofkbsed6 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkbsed7;
ALTER ROLE cofkbsed7 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkbsed8;
ALTER ROLE cofkbsed8 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkcharlotte;
ALTER ROLE cofkcharlotte WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkcomenius;
ALTER ROLE cofkcomenius WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkcontributor;
ALTER ROLE cofkcontributor WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkcottage;
ALTER ROLE cofkcottage WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkcristiano;
ALTER ROLE cofkcristiano WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkcristina;
ALTER ROLE cofkcristina WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkdavid;
ALTER ROLE cofkdavid WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkdewitt;
ALTER ROLE cofkdewitt WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkdf1;
ALTER ROLE cofkdf1 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkdirk;
ALTER ROLE cofkdirk WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkee;
ALTER ROLE cofkee WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkeero;
ALTER ROLE cofkeero WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkeetu;
ALTER ROLE cofkeetu WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkema;
ALTER ROLE cofkema WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkerik;
ALTER ROLE cofkerik WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkffion;
ALTER ROLE cofkffion WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkfrancesco;
ALTER ROLE cofkfrancesco WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkgabor;
ALTER ROLE cofkgabor WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkgraham;
ALTER ROLE cofkgraham WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkhartlib;
ALTER ROLE cofkhartlib WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkhelen;
ALTER ROLE cofkhelen WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkhendrijke;
ALTER ROLE cofkhendrijke WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkhoward;
ALTER ROLE cofkhoward WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkineke;
ALTER ROLE cofkineke WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkiva;
ALTER ROLE cofkiva WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkjetze;
ALTER ROLE cofkjetze WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkjohn;
ALTER ROLE cofkjohn WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkjouni;
ALTER ROLE cofkjouni WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkjudith;
ALTER ROLE cofkjudith WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkjustine;
ALTER ROLE cofkjustine WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkkaren;
ALTER ROLE cofkkaren WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkkat;
ALTER ROLE cofkkat WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkkathleen;
ALTER ROLE cofkkathleen WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkkim;
ALTER ROLE cofkkim WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkkirsten;
ALTER ROLE cofkkirsten WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkkristi;
ALTER ROLE cofkkristi WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofklaura;
ALTER ROLE cofklaura WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofklizzy;
ALTER ROLE cofklizzy WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofklucie;
ALTER ROLE cofklucie WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofklucy;
ALTER ROLE cofklucy WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkmanuel;
ALTER ROLE cofkmanuel WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkmarc;
ALTER ROLE cofkmarc WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkmarcela;
ALTER ROLE cofkmarcela WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkmark;
ALTER ROLE cofkmark WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkmarkherraghty;
ALTER ROLE cofkmarkherraghty WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkmat;
ALTER ROLE cofkmat WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkmellon;
ALTER ROLE cofkmellon WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkmike;
ALTER ROLE cofkmike WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkmikkel;
ALTER ROLE cofkmikkel WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkmilo;
ALTER ROLE cofkmilo WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkmiranda;
ALTER ROLE cofkmiranda WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkmzuber;
ALTER ROLE cofkmzuber WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkneil;
ALTER ROLE cofkneil WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkoscar;
ALTER ROLE cofkoscar WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkpaola;
ALTER ROLE cofkpaola WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkphilip;
ALTER ROLE cofkphilip WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkread;
ALTER ROLE cofkread WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkrenhart;
ALTER ROLE cofkrenhart WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkrhodri;
ALTER ROLE cofkrhodri WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkrichard;
ALTER ROLE cofkrichard WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkroberto;
ALTER ROLE cofkroberto WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkrobin;
ALTER ROLE cofkrobin WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkrosie;
ALTER ROLE cofkrosie WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkrusher;
ALTER ROLE cofkrusher WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkruth;
ALTER ROLE cofkruth WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkss1;
ALTER ROLE cofkss1 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkss10;
ALTER ROLE cofkss10 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkss11;
ALTER ROLE cofkss11 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkss12;
ALTER ROLE cofkss12 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkss13;
ALTER ROLE cofkss13 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkss14;
ALTER ROLE cofkss14 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkss15;
ALTER ROLE cofkss15 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkss16;
ALTER ROLE cofkss16 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkss2;
ALTER ROLE cofkss2 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkss3;
ALTER ROLE cofkss3 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkss4;
ALTER ROLE cofkss4 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkss5;
ALTER ROLE cofkss5 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkss6;
ALTER ROLE cofkss6 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkss7;
ALTER ROLE cofkss7 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkss8;
ALTER ROLE cofkss8 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkss9;
ALTER ROLE cofkss9 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofksue;
ALTER ROLE cofksue WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofksueh;
ALTER ROLE cofksueh WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofksuper;
ALTER ROLE cofksuper WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofktanya;
ALTER ROLE cofktanya WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofktest;
ALTER ROLE cofktest WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofktest1;
ALTER ROLE cofktest1 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofktest2;
ALTER ROLE cofktest2 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofktoby;
ALTER ROLE cofktoby WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofktom;
ALTER ROLE cofktom WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkvittoria;
ALTER ROLE cofkvittoria WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkvivienne;
ALTER ROLE cofkvivienne WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkvladimir;
ALTER ROLE cofkvladimir WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkwebformts;
ALTER ROLE cofkwebformts WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkwilliam;
ALTER ROLE cofkwilliam WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkyvonne;
ALTER ROLE cofkyvonne WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE cofkzeljka;
ALTER ROLE cofkzeljka WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE collector_role_cofk;
ALTER ROLE collector_role_cofk WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE editor_role_cofk;
ALTER ROLE editor_role_cofk WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE editor_role_impt;
ALTER ROLE editor_role_impt WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE imptabuyaqub;
ALTER ROLE imptabuyaqub WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE imptertugrul;
ALTER ROLE imptertugrul WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE imptfarasat;
ALTER ROLE imptfarasat WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE imptguest;
ALTER ROLE imptguest WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE imptjames;
ALTER ROLE imptjames WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE imptjudith;
ALTER ROLE imptjudith WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE imptmin;
ALTER ROLE imptmin WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE imptneil;
ALTER ROLE imptneil WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE imptsue;
ALTER ROLE imptsue WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE imptsuper;
ALTER ROLE imptsuper WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE imptwahid;
ALTER ROLE imptwahid WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE imptwoods;
ALTER ROLE imptwoods WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE matthew;
ALTER ROLE matthew WITH SUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN REPLICATION NOBYPASSRLS;
CREATE ROLE minimal;
ALTER ROLE minimal WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS;
CREATE ROLE super_role_cofk;
ALTER ROLE super_role_cofk WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE super_role_impt;
ALTER ROLE super_role_impt WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE viewer_role_cofk;
ALTER ROLE viewer_role_cofk WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE viewer_role_impt;
ALTER ROLE viewer_role_impt WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE webuser;
ALTER ROLE webuser WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;


--
-- Role memberships
--

GRANT collector_role_cofk TO cofkcontributor GRANTED BY postgres;
GRANT collector_role_cofk TO editor_role_cofk GRANTED BY postgres;
GRANT collector_role_cofk TO super_role_cofk GRANTED BY postgres;
GRANT editor_role_cofk TO cofk021 GRANTED BY postgres;
GRANT editor_role_cofk TO cofk036 GRANTED BY postgres;
GRANT editor_role_cofk TO cofk1 GRANTED BY postgres;
GRANT editor_role_cofk TO cofk101 GRANTED BY postgres;
GRANT editor_role_cofk TO cofk2 GRANTED BY postgres;
GRANT editor_role_cofk TO cofk3 GRANTED BY postgres;
GRANT editor_role_cofk TO cofk4 GRANTED BY postgres;
GRANT editor_role_cofk TO cofk5 GRANTED BY postgres;
GRANT editor_role_cofk TO cofk6 GRANTED BY postgres;
GRANT editor_role_cofk TO cofk_read GRANTED BY postgres;
GRANT editor_role_cofk TO cofkajmosley GRANTED BY postgres;
GRANT editor_role_cofk TO cofkalex GRANTED BY postgres;
GRANT editor_role_cofk TO cofkalexandra GRANTED BY postgres;
GRANT editor_role_cofk TO cofkalexandre GRANTED BY postgres;
GRANT editor_role_cofk TO cofkana GRANTED BY postgres;
GRANT editor_role_cofk TO cofkanita GRANTED BY postgres;
GRANT editor_role_cofk TO cofkanna GRANTED BY postgres;
GRANT editor_role_cofk TO cofkannamarie GRANTED BY postgres;
GRANT editor_role_cofk TO cofkanton GRANTED BY postgres;
GRANT editor_role_cofk TO cofkantonia GRANTED BY postgres;
GRANT editor_role_cofk TO cofkantonio GRANTED BY postgres;
GRANT editor_role_cofk TO cofkarno GRANTED BY postgres;
GRANT editor_role_cofk TO cofkaron GRANTED BY postgres;
GRANT editor_role_cofk TO cofkbenjamin GRANTED BY postgres;
GRANT editor_role_cofk TO cofkblse1 GRANTED BY postgres;
GRANT editor_role_cofk TO cofkborbala GRANTED BY postgres;
GRANT editor_role_cofk TO cofkbse GRANTED BY postgres;
GRANT editor_role_cofk TO cofkbsed1 GRANTED BY postgres;
GRANT editor_role_cofk TO cofkbsed2 GRANTED BY postgres;
GRANT editor_role_cofk TO cofkbsed3 GRANTED BY postgres;
GRANT editor_role_cofk TO cofkbsed4 GRANTED BY postgres;
GRANT editor_role_cofk TO cofkbsed5 GRANTED BY postgres;
GRANT editor_role_cofk TO cofkbsed6 GRANTED BY postgres;
GRANT editor_role_cofk TO cofkbsed7 GRANTED BY postgres;
GRANT editor_role_cofk TO cofkbsed8 GRANTED BY postgres;
GRANT editor_role_cofk TO cofkcharlotte GRANTED BY postgres;
GRANT editor_role_cofk TO cofkcomenius GRANTED BY postgres;
GRANT editor_role_cofk TO cofkcottage GRANTED BY postgres;
GRANT editor_role_cofk TO cofkcristiano GRANTED BY postgres;
GRANT editor_role_cofk TO cofkcristina GRANTED BY postgres;
GRANT editor_role_cofk TO cofkdavid GRANTED BY postgres;
GRANT editor_role_cofk TO cofkdewitt GRANTED BY postgres;
GRANT editor_role_cofk TO cofkdf1 GRANTED BY postgres;
GRANT editor_role_cofk TO cofkdirk GRANTED BY postgres;
GRANT editor_role_cofk TO cofkee GRANTED BY postgres;
GRANT editor_role_cofk TO cofkeero GRANTED BY postgres;
GRANT editor_role_cofk TO cofkeetu GRANTED BY postgres;
GRANT editor_role_cofk TO cofkema GRANTED BY postgres;
GRANT editor_role_cofk TO cofkerik GRANTED BY postgres;
GRANT editor_role_cofk TO cofkffion GRANTED BY postgres;
GRANT editor_role_cofk TO cofkfrancesco GRANTED BY postgres;
GRANT editor_role_cofk TO cofkgabor GRANTED BY postgres;
GRANT editor_role_cofk TO cofkgraham GRANTED BY postgres;
GRANT editor_role_cofk TO cofkhartlib GRANTED BY postgres;
GRANT editor_role_cofk TO cofkhelen GRANTED BY postgres;
GRANT editor_role_cofk TO cofkhendrijke GRANTED BY postgres;
GRANT editor_role_cofk TO cofkhoward GRANTED BY postgres;
GRANT editor_role_cofk TO cofkineke GRANTED BY postgres;
GRANT editor_role_cofk TO cofkiva GRANTED BY postgres;
GRANT editor_role_cofk TO cofkjetze GRANTED BY postgres;
GRANT editor_role_cofk TO cofkjohn GRANTED BY postgres;
GRANT editor_role_cofk TO cofkjouni GRANTED BY postgres;
GRANT editor_role_cofk TO cofkjudith GRANTED BY postgres;
GRANT editor_role_cofk TO cofkjustine GRANTED BY postgres;
GRANT editor_role_cofk TO cofkkaren GRANTED BY postgres;
GRANT editor_role_cofk TO cofkkat GRANTED BY postgres;
GRANT editor_role_cofk TO cofkkathleen GRANTED BY postgres;
GRANT editor_role_cofk TO cofkkim GRANTED BY postgres;
GRANT editor_role_cofk TO cofkkirsten GRANTED BY postgres;
GRANT editor_role_cofk TO cofkkristi GRANTED BY postgres;
GRANT editor_role_cofk TO cofklaura GRANTED BY postgres;
GRANT editor_role_cofk TO cofklizzy GRANTED BY postgres;
GRANT editor_role_cofk TO cofklucie GRANTED BY postgres;
GRANT editor_role_cofk TO cofklucy GRANTED BY postgres;
GRANT editor_role_cofk TO cofkmanuel GRANTED BY postgres;
GRANT editor_role_cofk TO cofkmarc GRANTED BY postgres;
GRANT editor_role_cofk TO cofkmarcela GRANTED BY postgres;
GRANT editor_role_cofk TO cofkmark GRANTED BY postgres;
GRANT editor_role_cofk TO cofkmarkherraghty GRANTED BY postgres;
GRANT editor_role_cofk TO cofkmat GRANTED BY postgres;
GRANT editor_role_cofk TO cofkmellon GRANTED BY postgres;
GRANT editor_role_cofk TO cofkmike GRANTED BY postgres;
GRANT editor_role_cofk TO cofkmikkel GRANTED BY postgres;
GRANT editor_role_cofk TO cofkmilo GRANTED BY postgres;
GRANT editor_role_cofk TO cofkmiranda GRANTED BY postgres;
GRANT editor_role_cofk TO cofkmzuber GRANTED BY postgres;
GRANT editor_role_cofk TO cofkneil GRANTED BY postgres;
GRANT editor_role_cofk TO cofkoscar GRANTED BY postgres;
GRANT editor_role_cofk TO cofkpaola GRANTED BY postgres;
GRANT editor_role_cofk TO cofkphilip GRANTED BY postgres;
GRANT editor_role_cofk TO cofkread GRANTED BY postgres;
GRANT editor_role_cofk TO cofkrenhart GRANTED BY postgres;
GRANT editor_role_cofk TO cofkrhodri GRANTED BY postgres;
GRANT editor_role_cofk TO cofkrichard GRANTED BY postgres;
GRANT editor_role_cofk TO cofkroberto GRANTED BY postgres;
GRANT editor_role_cofk TO cofkrobin GRANTED BY postgres;
GRANT editor_role_cofk TO cofkrosie GRANTED BY postgres;
GRANT editor_role_cofk TO cofkrusher GRANTED BY postgres;
GRANT editor_role_cofk TO cofkruth GRANTED BY postgres;
GRANT editor_role_cofk TO cofkss1 GRANTED BY postgres;
GRANT editor_role_cofk TO cofkss10 GRANTED BY postgres;
GRANT editor_role_cofk TO cofkss11 GRANTED BY postgres;
GRANT editor_role_cofk TO cofkss12 GRANTED BY postgres;
GRANT editor_role_cofk TO cofkss13 GRANTED BY postgres;
GRANT editor_role_cofk TO cofkss14 GRANTED BY postgres;
GRANT editor_role_cofk TO cofkss15 GRANTED BY postgres;
GRANT editor_role_cofk TO cofkss16 GRANTED BY postgres;
GRANT editor_role_cofk TO cofkss2 GRANTED BY postgres;
GRANT editor_role_cofk TO cofkss3 GRANTED BY postgres;
GRANT editor_role_cofk TO cofkss4 GRANTED BY postgres;
GRANT editor_role_cofk TO cofkss5 GRANTED BY postgres;
GRANT editor_role_cofk TO cofkss6 GRANTED BY postgres;
GRANT editor_role_cofk TO cofkss7 GRANTED BY postgres;
GRANT editor_role_cofk TO cofkss8 GRANTED BY postgres;
GRANT editor_role_cofk TO cofkss9 GRANTED BY postgres;
GRANT editor_role_cofk TO cofksue GRANTED BY postgres;
GRANT editor_role_cofk TO cofksueh GRANTED BY postgres;
GRANT editor_role_cofk TO cofktanya GRANTED BY postgres;
GRANT editor_role_cofk TO cofktest GRANTED BY postgres;
GRANT editor_role_cofk TO cofktest1 GRANTED BY postgres;
GRANT editor_role_cofk TO cofktest2 GRANTED BY postgres;
GRANT editor_role_cofk TO cofktoby GRANTED BY postgres;
GRANT editor_role_cofk TO cofktom GRANTED BY postgres;
GRANT editor_role_cofk TO cofkvittoria GRANTED BY postgres;
GRANT editor_role_cofk TO cofkvivienne GRANTED BY postgres;
GRANT editor_role_cofk TO cofkvladimir GRANTED BY postgres;
GRANT editor_role_cofk TO cofkwebformts GRANTED BY postgres;
GRANT editor_role_cofk TO cofkwilliam GRANTED BY postgres;
GRANT editor_role_cofk TO cofkyvonne GRANTED BY postgres;
GRANT editor_role_cofk TO cofkzeljka GRANTED BY postgres;
GRANT editor_role_cofk TO super_role_cofk GRANTED BY postgres;
GRANT editor_role_impt TO imptabuyaqub GRANTED BY postgres;
GRANT editor_role_impt TO imptertugrul GRANTED BY postgres;
GRANT editor_role_impt TO imptfarasat GRANTED BY postgres;
GRANT editor_role_impt TO imptguest GRANTED BY postgres;
GRANT editor_role_impt TO imptjames GRANTED BY postgres;
GRANT editor_role_impt TO imptjudith GRANTED BY postgres;
GRANT editor_role_impt TO imptmin GRANTED BY postgres;
GRANT editor_role_impt TO imptneil GRANTED BY postgres;
GRANT editor_role_impt TO imptsue GRANTED BY postgres;
GRANT editor_role_impt TO imptwahid GRANTED BY postgres;
GRANT editor_role_impt TO imptwoods GRANTED BY postgres;
GRANT editor_role_impt TO super_role_impt GRANTED BY postgres;
GRANT super_role_cofk TO cofk6 GRANTED BY postgres;
GRANT super_role_cofk TO cofkcottage GRANTED BY postgres;
GRANT super_role_cofk TO cofkeetu GRANTED BY postgres;
GRANT super_role_cofk TO cofkjohn GRANTED BY postgres;
GRANT super_role_cofk TO cofklucy GRANTED BY postgres;
GRANT super_role_cofk TO cofkmat GRANTED BY postgres;
GRANT super_role_cofk TO cofkmiranda GRANTED BY postgres;
GRANT super_role_cofk TO cofksuper GRANTED BY postgres;
GRANT super_role_cofk TO cofktanya GRANTED BY postgres;
GRANT super_role_impt TO imptjudith GRANTED BY postgres;
GRANT super_role_impt TO imptsuper GRANTED BY postgres;
GRANT viewer_role_cofk TO burgess GRANTED BY postgres;
GRANT viewer_role_cofk TO cofk021 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofk036 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofk1 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofk101 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofk2 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofk3 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofk4 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofk5 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofk6 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofk_read GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkajmosley GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkalex GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkalexandra GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkalexandre GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkana GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkanita GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkanna GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkannamarie GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkanton GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkantonia GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkantonio GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkarno GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkaron GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkbenjamin GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkblse1 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkborbala GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkbse GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkbsed1 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkbsed2 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkbsed3 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkbsed4 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkbsed5 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkbsed6 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkbsed7 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkbsed8 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkcharlotte GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkcomenius GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkcottage GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkcristiano GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkcristina GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkdavid GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkdewitt GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkdf1 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkdirk GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkee GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkeero GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkeetu GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkema GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkerik GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkffion GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkfrancesco GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkgabor GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkgraham GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkhartlib GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkhelen GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkhendrijke GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkhoward GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkineke GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkiva GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkjetze GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkjohn GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkjouni GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkjudith GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkjustine GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkkaren GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkkat GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkkathleen GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkkim GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkkirsten GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkkristi GRANTED BY postgres;
GRANT viewer_role_cofk TO cofklaura GRANTED BY postgres;
GRANT viewer_role_cofk TO cofklizzy GRANTED BY postgres;
GRANT viewer_role_cofk TO cofklucie GRANTED BY postgres;
GRANT viewer_role_cofk TO cofklucy GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkmanuel GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkmarc GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkmarcela GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkmark GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkmarkherraghty GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkmat GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkmellon GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkmike GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkmikkel GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkmilo GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkmiranda GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkmzuber GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkneil GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkoscar GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkpaola GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkphilip GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkread GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkrenhart GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkrhodri GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkrichard GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkroberto GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkrobin GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkrosie GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkrusher GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkruth GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkss1 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkss10 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkss11 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkss12 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkss13 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkss14 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkss15 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkss16 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkss2 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkss3 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkss4 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkss5 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkss6 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkss7 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkss8 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkss9 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofksue GRANTED BY postgres;
GRANT viewer_role_cofk TO cofksueh GRANTED BY postgres;
GRANT viewer_role_cofk TO cofktanya GRANTED BY postgres;
GRANT viewer_role_cofk TO cofktest GRANTED BY postgres;
GRANT viewer_role_cofk TO cofktest1 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofktest2 GRANTED BY postgres;
GRANT viewer_role_cofk TO cofktoby GRANTED BY postgres;
GRANT viewer_role_cofk TO cofktom GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkvittoria GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkvivienne GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkvladimir GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkwebformts GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkwilliam GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkyvonne GRANTED BY postgres;
GRANT viewer_role_cofk TO cofkzeljka GRANTED BY postgres;
GRANT viewer_role_cofk TO editor_role_cofk GRANTED BY postgres;
GRANT viewer_role_cofk TO super_role_cofk GRANTED BY postgres;
GRANT viewer_role_cofk TO webuser GRANTED BY postgres;
GRANT viewer_role_impt TO burgess GRANTED BY postgres;
GRANT viewer_role_impt TO imptabuyaqub GRANTED BY postgres;
GRANT viewer_role_impt TO imptertugrul GRANTED BY postgres;
GRANT viewer_role_impt TO imptfarasat GRANTED BY postgres;
GRANT viewer_role_impt TO imptguest GRANTED BY postgres;
GRANT viewer_role_impt TO imptjames GRANTED BY postgres;
GRANT viewer_role_impt TO imptjudith GRANTED BY postgres;
GRANT viewer_role_impt TO imptmin GRANTED BY postgres;
GRANT viewer_role_impt TO imptneil GRANTED BY postgres;
GRANT viewer_role_impt TO imptsue GRANTED BY postgres;
GRANT viewer_role_impt TO imptwahid GRANTED BY postgres;
GRANT viewer_role_impt TO imptwoods GRANTED BY postgres;
GRANT viewer_role_impt TO super_role_impt GRANTED BY postgres;




--
-- PostgreSQL database cluster dump complete
--

