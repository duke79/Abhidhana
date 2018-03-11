import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/data/Strings.dart';

class MyLocale {
  MyLocale(this.locale);

  final Locale locale;

  static MyLocale of(BuildContext context) {
    return Localizations.of<MyLocale>(context, MyLocale);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      Strings.localeKey_title: 'Vilokan Dictionary',
      Strings.localeKey_sheet: 'bottomSheet',
      Strings.localeKey_showSheet: 'showSheet',
    },
    'es': {
      Strings.localeKey_title: 'Vilokan Dictionary',
    },
  };

  String value(key) {
    return _localizedValues[locale.languageCode][key];
  }
}

class MyLocalizationDelegate extends LocalizationsDelegate<MyLocale> {
  const MyLocalizationDelegate();

  @override
  bool isSupported(Locale locale) =>
      [
        'en',
        'es',
      ].contains(locale.languageCode);

  @override
  Future<MyLocale> load(Locale locale) {
    return new SynchronousFuture<MyLocale>(
        new MyLocale(locale)
    );
  }

  @override
  bool shouldReload(MyLocalizationDelegate old) => false;
}
