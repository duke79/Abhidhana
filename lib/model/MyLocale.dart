import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyLocale {
  MyLocale(this.locale);

  final Locale locale;

  static MyLocale of(BuildContext context) {
    return Localizations.of<MyLocale>(context, MyLocale);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Hello World',
    },
    'es': {
      'title': 'Hola Mundo',
    },
  };

  String get title {
    return _localizedValues[locale.languageCode]['title'];
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
