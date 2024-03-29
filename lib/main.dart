import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_figure_pay_partner/dashboard_page.dart';

import 'config/config.dart';
import 'fp_design/fp_design.dart';

void main() {
  // Ensures that configuation is valid. Throws exception otherwise.
  validateConfig();

  // Used to load the config file
  GlobalConfiguration().loadFromMap(config);

  // entry point for Figure Pay Partner
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
