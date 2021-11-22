import 'package:flutter/material.dart';
import 'package:mobile_figure_pay_partner/extensions/double_ext.dart';
import 'package:mobile_figure_pay_partner/fp_design/fp_design.dart';
import 'package:mobile_figure_pay_partner/services/deep_link_service.dart';
import 'package:mobile_figure_pay_partner/transaction_complete_screen.dart';

class PayInvoiceScreen extends StatelessWidget {
  const PayInvoiceScreen({
    Key? key,
    required this.event,
    required this.availableBalance,
  }) : super(key: key);

  final DeepLinkInvoiceEvent event;
  final double availableBalance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FpAppBar(),
      body: Column(
        children: [
          Container(
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    VerticalSpacer.medium(),
                    FpText(event.amount.toCurrency(),
                        style: FpTextStyle.h1, color: FpColor.white),
                    FpText('Transaction Amount',
                        style: FpTextStyle.h4, color: FpColor.white),
                    FpText(event.appName, color: FpColor.white),
                    VerticalSpacer.xLarge(),
                  ],
                ),
              ],
            ),
          ),
          VerticalSpacer.large(),
          Padding(
            padding: const EdgeInsets.all(Spacing.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FpText('Select Payment Method'),
                VerticalSpacer.xSmall(),
                FpRadioButtonList<bool>(
                  radioButtonList: [
                    FpRadioButton(
                      title: FpText(
                        'Figure Pay Cash Account: ${event.amount.toCurrency()}',
                        style: FpTextStyle.h6,
                      ),
                      description: FpText(
                        'Available Balance: ${availableBalance.toCurrency()}',
                        color: FpColor.darkGrey,
                      ),
                      value: true,
                      groupValue: true,
                      onTap: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: FlatBottomAppBar(
        child: FpPrimaryButton(
          text: 'Pay Now',
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return TransactionCompleteScreen(
                    amount: event.amount,
                    date: DateTime.now(),
                    name: event.appName,
                    callbackUri: event.callbackUri,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
