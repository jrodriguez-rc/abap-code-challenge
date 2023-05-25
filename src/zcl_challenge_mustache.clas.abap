CLASS zcl_challenge_mustache DEFINITION
  PUBLIC
  INHERITING FROM zcl_challenge_adt_base
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

  PROTECTED SECTION.
    METHODS execute REDEFINITION.

  PRIVATE SECTION.
    TYPES:
      BEGIN OF ty_race_result,
        position TYPE i,
        driver   TYPE string,
        time     TYPE string,
        team     TYPE string,
      END OF ty_race_result,
      ty_race_results TYPE SORTED TABLE OF ty_race_result WITH UNIQUE KEY position.

    TYPES:
      BEGIN OF ty_qualifying_position,
        position TYPE i,
        driver   TYPE string,
        time_q1  TYPE string,
        time_q2  TYPE string,
        time_q3  TYPE string,
        team     TYPE string,
      END OF ty_qualifying_position,
      ty_qualifying TYPE SORTED TABLE OF ty_qualifying_position WITH UNIQUE KEY position.

    TYPES:
      BEGIN OF ty_grand_prix,
        race_places TYPE ty_race_results,
        qualifying  TYPE ty_qualifying,
      END OF ty_grand_prix.

ENDCLASS.



CLASS zcl_challenge_mustache IMPLEMENTATION.


  METHOD execute.

    DATA(sep) = cl_abap_char_utilities=>horizontal_tab.

    DATA(race_places) =
        VALUE ty_race_results(
            ( position = 1  driver = `Max Verstappen·` time = `-------` team = `Red Bull` )
            ( position = 2  driver = `Sergio Pérez···` time = `+ 5"384` team = `Red Bull` )
            ( position = 3  driver = `Fernando Alonso` time = `+26"305` team = `Aston Martin` )
            ( position = 4  driver = `George Russell·` time = `+33"229` team = `Mercedes` )
            ( position = 5  driver = `Carlos Sainz···` time = `+42"511` team = `Ferrari` )
            ( position = 6  driver = `Lewis Hamilton·` time = `+51"249` team = `Mercedes` )
            ( position = 7  driver = `Charles Leclerc` time = `+52"988` team = `Ferrari` )
            ( position = 8  driver = `Pierre Gasly···` time = `+55"670` team = `Alpine` )
            ( position = 9  driver = `Esteban Ocon···` time = `+58"123` team = `Alpine` )
            ( position = 10 driver = `Kevin Magnussen` time = `+62"945` team = `Haas` )
            ( position = 11 driver = `Yuki Tsunoda···` time = `+64"309` team = `AlphaTauri` )
            ( position = 12 driver = `Lance Stroll···` time = `+64"754` team = `Aston Martin` )
            ( position = 13 driver = `Valtteri Bottas` time = `+71"637` team = `Alfa Romeo Racing` )
            ( position = 14 driver = `Alex Albon·····` time = `+72"861` team = `Williams` )
            ( position = 15 driver = `Nico Hülkenberg` time = `+74"950` team = `Haas` )
            ( position = 16 driver = `Guanyu Zhou····` time = `+78"440` team = `Alfa Romeo Racing` )
            ( position = 17 driver = `Lando Norris···` time = `+87"717` team = `McLaren` )
            ( position = 18 driver = `Nyck de Vries··` time = `+88"949` team = `AlphaTauri` )
            ( position = 19 driver = `Oscar Piastri··` time = `+1 lap·`  team = `McLaren` )
            ( position = 20 driver = `Logan Sargeant·` time = `+1 lap·`  team = `Williams` ) ).

    DATA(qualifying) =
        VALUE ty_qualifying(
            ( position = 1  driver = `Sergio Pérez···` time_q1 = `1'27"713` time_q2 = `1'27"328` time_q3 = `1'26"841` team = `R. Bull` )
            ( position = 2  driver = `Fernando Alonso` time_q1 = `1'28"179` time_q2 = `1'27"097` time_q3 = `1'27"202` team = `A. Martin` )
            ( position = 3  driver = `Carlos Sainz···` time_q1 = `1'27"686` time_q2 = `1'27"148` time_q3 = `1'27"349` team = `Ferrari` )
            ( position = 4  driver = `Kevin Magnussen` time_q1 = `1'27"809` time_q2 = `1'27"674` time_q3 = `1'27"767` team = `Haas` )
            ( position = 5  driver = `Pierre Gasly···` time_q1 = `1'28"061` time_q2 = `1'27"612` time_q3 = `1'27"789` team = `Alpine` )
            ( position = 6  driver = `George Russell·` time_q1 = `1'28"086` time_q2 = `1'27"743` time_q3 = `1'27"804` team = `Mercedes` )
            ( position = 7  driver = `Charles Leclerc` time_q1 = `1'27"713` time_q2 = `1'26"964` time_q3 = `1'27"861` team = `Ferrari` )
            ( position = 8  driver = `Esteban Ocon···` time_q1 = `1'27"872` time_q2 = `1'27"444` time_q3 = `1'27"935` team = `Alpine` )
            ( position = 9  driver = `Max Verstappen·` time_q1 = `1'27"363` time_q2 = `1'26"814` time_q3 = `········` team = `R. Bull` )
            ( position = 10 driver = `Valtteri Bottas` time_q1 = `1'27"864` time_q2 = `1'27"564` time_q3 = `········` team = `A. Romeo` )
            ( position = 11 driver = `Alexander Albon` time_q1 = `1'28"234` time_q2 = `1'27"795` time_q3 = `········` team = `Williams` )
            ( position = 12 driver = `Nico Hulkenberg` time_q1 = `1'27"945` time_q2 = `1'27"903` time_q3 = `········` team = `Haas` )
            ( position = 13 driver = `Lewis Hamilton·` time_q1 = `1'27"846` time_q2 = `1'27"975` time_q3 = `········` team = `Mercedes` )
            ( position = 14 driver = `Gyanyu Zhou····` time_q1 = `1'28"180` time_q2 = `1'28"091` time_q3 = `········` team = `A. Romeo` )
            ( position = 15 driver = `Nyck de Vries··` time_q1 = `1'28"394` time_q2 = `1'28"395` time_q3 = `········` team = `AlphaTauri` )
            ( position = 16 driver = `Lando Norris···` time_q1 = `1'28"394` time_q2 = `········` time_q3 = `········` team = `McLaren` )
            ( position = 17 driver = `Yuki Tsunoda···` time_q1 = `1'28"429` time_q2 = `········` time_q3 = `········` team = `AlphaTauri` )
            ( position = 18 driver = `Lance Stroll···` time_q1 = `1'28"476` time_q2 = `········` time_q3 = `········` team = `A. Martin` )
            ( position = 19 driver = `Oscar Piastri··` time_q1 = `1'28"484` time_q2 = `········` time_q3 = `········` team = `McLaren` )
            ( position = 20 driver = `Logan Sargeant·` time_q1 = `1'28"577` time_q2 = `········` time_q3 = `········` team = `Williams` ) ).

    DATA(mustache) =
        zcl_mustache=>create(
            `GP Miami - Race positions` &&
            cl_abap_char_utilities=>newline &&
            `Pos.` && sep && ` Driver` && sep && sep && sep && ` Time` && sep && sep && ` Team` &&
            cl_abap_char_utilities=>newline &&
            `{{#race_places}}` &&
            cl_abap_char_utilities=>newline &&
            `  {{position}}` && sep && ` {{driver }}` && sep && ` {{time}}` && sep && ` {{team}}` &&
            cl_abap_char_utilities=>newline &&
            `{{/race_places}}` &&
            `GP Miami - Qualifying` &&
            cl_abap_char_utilities=>newline &&
            `Pos.` && sep && ` Driver` && sep && sep && sep && ` Time Q1` && sep && ` Time Q2` && sep && ` Time Q3` && sep && ` Team` &&
            cl_abap_char_utilities=>newline &&
            `{{#qualifying}}` &&
            cl_abap_char_utilities=>newline &&
            `  {{position}}` && sep && ` {{driver }}` && sep && ` {{time_q1}}` && sep && ` {{time_q2}}` && sep && ` {{time_q3}}` && sep && ` {{team}}` &&
            cl_abap_char_utilities=>newline &&
            `{{/qualifying}}` ).

    write( mustache->render( VALUE ty_grand_prix( race_places = race_places qualifying = qualifying ) ) ).

  ENDMETHOD.


ENDCLASS.
