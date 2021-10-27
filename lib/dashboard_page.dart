import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.black,
        brightness: Brightness.light,
        bottom: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
            child: Column(
              children: [
                // SvgPicture.asset(
                //   'assets/v2/icons/here.svg',
                // ),
              ],
            ),
          ),
          preferredSize: const Size.fromHeight(
            271,
          ),
        ),
      ),
      body: Container(),
    );
  }
}
