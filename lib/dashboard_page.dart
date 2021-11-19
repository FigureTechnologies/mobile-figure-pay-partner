import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_figure_pay_partner/services/deep_link_service.dart';
import 'package:mobile_figure_pay_partner/widgets/banner.dart';
import 'package:mobile_figure_pay_partner/widgets/recent_activity_list.dart';

import '../theme.dart';
import 'dashboard_vm.dart';
import 'widgets/authorization_dialog.dart';

class DashboardPage extends HookWidget {
  // Used to inform of non-functional elements
  final _snackBar = SnackBar(
    content: Text('Not available in this version of the app.'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.black,
        brightness: Brightness.dark,
        bottom: _bottomAppBar(context),
      ),
      // When a deeplink has been launched from another app and its parameters have been
      // processed by the _dashboardViewModel, the _dashboardViewModel's state will be updated.
      // The UI is then updated here according to the new state. This is handled by the ProviderListener
      body: ProviderListener<AsyncValue<DeepLinkEvent?>>(
        provider: deepLinkeEventProvider,
        onChange: (context, value) async {
          if (value is AsyncData) {
            final event = value.data!.value;
            if (event == null) return;

            if (event is DeepLinkErrorEvent) {
              FpDialog.showError(context, message: event.message);
            } else if (event is DeepLinkGetReferenceUuidEvent) {
              // A deeplink has been launched and we were able to successfully parse its parameters
              // So now we can show the dialog pop up to allow user authorization
              FpDialog.showAuthorization(
                context,
                username: '@annie',
                appName: event.requestingApp,
                onAuthorize: () async {
                  // Launch the callbackUri if the users taps on Authorize
                  await DeepLinkService().launchCallbackWithUserInfo(
                      event.callbackUri,
                      referenceUuid: event.referenceUuid);
                  Navigator.pop(context);
                },
              );
            } else if (event is DeepLinkInvoiceEvent) {
              print('DeepLinkInvoiceEvent');
            }
          } else if (value is AsyncError) {
            // Show the error received from trying to parse the deeplink
            FpDialog.showError(context,
                message: (value as AsyncError).error.toString());
          }
        },
        child: _body(context),
      ),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  // Displays mock user data
  PreferredSize _bottomAppBar(BuildContext context) {
    return PreferredSize(
      child: Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            GestureDetector(
              onTap: () =>
                  ScaffoldMessenger.of(context).showSnackBar(_snackBar),
              child: Align(
                alignment: Alignment.centerRight,
                child: SvgPicture.asset(
                  'assets/settings.svg',
                  color: Theme.of(context).colorScheme.white,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('\$2,2657.79',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Theme.of(context).colorScheme.white)),
            const SizedBox(height: 8),
            Text('Available Account Balance',
                style: Theme.of(context)
                    .textTheme
                    .medium
                    .copyWith(color: Theme.of(context).colorScheme.white)),
            const SizedBox(height: 24),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        GestureDetector(
                            onTap: () => ScaffoldMessenger.of(context)
                                .showSnackBar(_snackBar),
                            child: Image.asset('assets/add_money.png',
                                height: 56)),
                        const SizedBox(height: 12),
                        Text('Add Money',
                            style: Theme.of(context).textTheme.small.copyWith(
                                color: Theme.of(context).colorScheme.white))
                      ]),
                      Column(children: [
                        GestureDetector(
                            onTap: () => ScaffoldMessenger.of(context)
                                .showSnackBar(_snackBar),
                            child: Image.asset('assets/send_money.png',
                                height: 56)),
                        const SizedBox(height: 12),
                        Text('Send Money',
                            style: Theme.of(context).textTheme.small.copyWith(
                                color: Theme.of(context).colorScheme.white))
                      ]),
                      Column(children: [
                        GestureDetector(
                            onTap: () => ScaffoldMessenger.of(context)
                                .showSnackBar(_snackBar),
                            child: Image.asset('assets/scan_code.png',
                                height: 56)),
                        const SizedBox(height: 12),
                        Text('Scan QR',
                            style: Theme.of(context).textTheme.small.copyWith(
                                color: Theme.of(context).colorScheme.white)),
                      ])
                    ]))
          ])),
      preferredSize: const Size.fromHeight(
        216,
      ),
    );
  }

  // Displays limited functional dashboard
  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DirectDepositBanner(
              onTap: () =>
                  ScaffoldMessenger.of(context).showSnackBar(_snackBar),
            ),
            const SizedBox(height: 32),
            RecentActivityList(
              onTap: () =>
                  ScaffoldMessenger.of(context).showSnackBar(_snackBar),
            ),
          ],
        ),
      ),
    );
  }

  // Displays limited functional navigation bar
  Widget _bottomNavigationBar(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(height: 2, color: Theme.of(context).colorScheme.lightGrey),
        Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _tabItem(context, 'Home', 'home_selected'),
                _tabItem(context, 'My Account', 'account'),
                _tabItem(context, 'Rewards', 'shop'),
              ],
            ))
      ],
    );
  }

  Widget _tabItem(BuildContext context, String tabName, String tabAsset) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 10),
          GestureDetector(
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(_snackBar),
            child: SizedBox(
                width: 24.0,
                height: 24.0,
                child: SvgPicture.asset('assets/$tabAsset.svg')),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 28),
            child: Text(
              tabName,
              style: Theme.of(context)
                  .textTheme
                  .extraSmallBold
                  .copyWith(color: Theme.of(context).colorScheme.darkGrey),
            ),
          )
        ],
      ),
    );
  }
}
