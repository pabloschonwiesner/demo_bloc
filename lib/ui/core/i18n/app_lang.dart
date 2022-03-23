import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AppLang {
  final String localeName;
  final Map<String, dynamic> _translates = {};

  AppLang(this.localeName);


  static AppLang of(BuildContext context) {
    return Localizations.of<AppLang>(context, AppLang)!;
  }

  Future<bool> load() async {

    for(String path in loadFiles()) {
      String data = await rootBundle.loadString(path);
      Map<String, dynamic> _result = json.decode(data);
      _result.forEach((key, value) => _translates[key] = _result[key].toString() );
    }


    return true;
  }

  String translate(String key) {
    return _translates[key];
  }

  List<String> loadFiles() {
    return [
      'assets/lang/home_page.json',
      'assets/lang/person_page.json',
    ];
  } 
  
}