class Strings {



  /*Un-categorized strings*/

  // ignore: non_constant_identifier_names
  static get str_accountName => "Vilokan Labs";
  // ignore: non_constant_identifier_names
  static get str_accountEmail => "VilokanLabs@gmail.com";
  // ignore: non_constant_identifier_names
  static get str_drawerItem => "Drawer item ";
  // ignore: non_constant_identifier_names
  static get str_drawerItems => ["a", "b"];
  // ignore: non_constant_identifier_names
  static String get str_gone => "I am gone";



  /*App meta*/

  // ignore: non_constant_identifier_names
  static get app_title => 'Vilokan Dictionary';



  /*Routes paths*/

  // ignore: non_constant_identifier_names
  static const route_home = "/";
  // ignore: non_constant_identifier_names
  static const route_search = "/search";
  static const route_result = "/result";



  /*SQL queries*/

  // ignore: non_constant_identifier_names
  static get SQL_SELECT_100_WORDS => "select * from entries limit 0,100";
  // ignore: non_constant_identifier_names
  static get SQL_SELECT_ALL_TABLES => "SELECT name FROM sqlite_master WHERE type=\'table\'";
  // ignore: non_constant_identifier_names
  static get SQL_SELECT_WORDS_STARTING_WITH => "select * from entries where UPPER(word) like UPPER(\"INPUT_1%\") limit INPUT_2";
  // ignore: non_constant_identifier_names
  static get SQL_VAR_INPUT1 => r"INPUT_1";
  // ignore: non_constant_identifier_names
  static get SQL_VAR_INPUT2 => r"INPUT_2";
  // ignore: non_constant_identifier_names
  static get SQL_VAR_LIMIT => "30";



  /*Widgets Tags*/

  // ignore: non_constant_identifier_names
  static get widgetTag_prefix => "tag_";
  // ignore: non_constant_identifier_names
  static get widgetTag_searchBar => widgetTag_prefix+"SearchBar";



  /*Locale Keys*/

  // ignore: non_constant_identifier_names
  static get localeKey_title => "title";
  // ignore: non_constant_identifier_names
  static get localeKey_sheet => "sheet";
  // ignore: non_constant_identifier_names
  static get localeKey_showSheet => "showSheet";



  /*Traces tags*/

  // ignore: non_constant_identifier_names
  static get tracesTag_quickTest => "quickTest";



  /*Traces*/

  // ignore: non_constant_identifier_names
  static get trace_searchView => "SearchView:";
}