import 'package:demo_provider/ui/core/i18n/app_lang.dart';
import 'package:flutter/cupertino.dart';

class AppLangDelegate extends LocalizationsDelegate<AppLang> {


  @override
  bool isSupported(Locale locale) {
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLang> load(Locale locale) async {
    return AppLang(locale.languageCode);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) {
    return false;
  }

}