import 'package:flutter/material.dart';
import 'package:mobile_figure_pay_partner/extensions/date_time_ext.dart';
import 'package:mobile_figure_pay_partner/extensions/double_ext.dart';
import 'package:mobile_figure_pay_partner/fp_design/fp_design.dart';

import 'services/deep_link_service.dart';

class TransactionCompleteScreen extends StatelessWidget {
  const TransactionCompleteScreen({
    Key? key,
    required this.amount,
    required this.date,
    required this.name,
    this.callbackUri,
  }) : super(key: key);

  final double amount;
  final DateTime date;
  final String name;
  final Uri? callbackUri;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(Spacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VerticalSpacer.xxLarge(),
            const VerticalSpacer.xxLarge(),
            FpText(
              'Transaction Complete',
              style: FpTextStyle.h6,
            ),
            const VerticalSpacer.small(),
            FpText(
              'You have successfully sent funds for the following:',
              style: FpTextStyle.m,
            ),
            const VerticalSpacer.xxLarge(),
            FpText(
              name,
              style: FpTextStyle.mBold,
            ),
            const VerticalSpacer.medium(),
            FpDivider(),
            const VerticalSpacer.medium(),
            // CompleteTableDataWidget(items),
            TransferRow('Date', date.toMonthDayYear()),
            VerticalSpacer.medium(),
            TransferRow('Transaction Amount', amount.toCurrency()),
            VerticalSpacer.medium(),
          ],
        ),
      ),
      bottomNavigationBar: FlatBottomAppBar(
        child: FpPrimaryButton(
          text: callbackUri != null ? 'Back to $name' : 'Go to dashboard',
          onPressed: () async {
            if (callbackUri != null) {
              DeepLinkService().launchCallbackUri(callbackUri!);
            }
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
