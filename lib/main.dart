import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_figure_pay_partner/dashboard_page.dart';
import 'package:mobile_figure_pay_partner/theme.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Figure Pay Partner',
      debugShowCheckedModeBanner: false,
      theme: FigurePayThemeData.themeData,
      home: DashboardPage(),
    );
  }
}
