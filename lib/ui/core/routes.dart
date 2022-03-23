import 'package:flutter/material.dart';
import 'package:demo_provider/ui/features/home/home_page.dart';
import 'package:demo_provider/ui/features/person/detail_page.dart';

final Map<String, WidgetBuilder> routes = {
  'home': (context) => const HomePage(),
  'detail': (context) => const DetailPage(),
};