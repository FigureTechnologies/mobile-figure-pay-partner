import 'dart:async';
import 'dart:developer';

import 'package:global_configuration/global_configuration.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_figure_pay_partner/models/partner.dart';

import 'services/deep_link_service.dart';

/// ViewModel handles the interactions between UI and deeplinks. Through the use of states,
/// we are able to communicate with the UI when a widget needs to be updated or shown.
class DashboardViewModel extends StateNotifier<AsyncValue<Partner?>> {
  DashboardViewModel(this._deepLinkService) : super(AsyncValue.data(null)) {
    setup();
  }

  final DeepLinkService _deepLinkService;
  StreamSubscription? _streamSubscription;

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  // Setups up our deeplink service to listen for incoming deeplinks
  void setup() async {
    _streamSubscription = _deepLinkService.linkStream.listen(
      _onData,
      onError: (error) => state = AsyncError(error),
    );

    // Used to catch a deeplink that was called if the app was not already open
    final initialUri = await DeepLinkService().initialUri;
    if (initialUri != null) {
      _onData(initialUri);
    }
  }

  // Used to determine the state of the view model when data is received from a deeplink
  Future<void> _onData(Uri? uri) async {
    print('_onData: $uri');

    if (uri == null) {
      state = AsyncError('Missing Uri');
      return;
    }

    state = const AsyncLoading();

    if (uri.path.startsWith('/figurepaypartner/getUser')) {
      // parse query parameters
      final accountUuid = _getAccountUuidFromUri(uri);
      final callbackUri = _getCallbackUri(deepLinkUri: uri);
      // retrieve config values
      final appName = GlobalConfiguration().getValue('app_name');
      final referenceUuid = GlobalConfiguration().getValue('reference_uuid');

      if (accountUuid == null) {
        state = AsyncError('Malformed Uri: Could not retrieve account_uuid');
      } else if (callbackUri == null) {
        state = AsyncError('Malformed Uri: Could not retrieve callback_uri');
      } else if (appName == null) {
        state = AsyncError(
            'Incorrect config:\nBe sure to include the key \'app_name\' inside the file:\nlib/config/config.dart');
      } else if (referenceUuid == null) {
        state = AsyncError(
            'Incorrect config:\nBe sure to include the key \'reference_uuid\' inside the file:\nlib/config/config.dart');
      } else {
        // query parameters and config values have been successfully parsed
        // we set the state and pass the model housing our data to the UI (dashboard_page)
        state = AsyncData(Partner(
            accountUuid: accountUuid,
            callbackUri: callbackUri,
            appName: appName,
            referenceUuid: referenceUuid));
      }
    } else {
      state = AsyncError('Malformed Uri: Incorrect path');
    }
  }

  Uri? _getCallbackUri({required Uri deepLinkUri}) {
    final callbackUriString = deepLinkUri.queryParameters['callback_uri'];
    if (callbackUriString == null) {
      log('missing callback_uri');
      return null;
    }

    final callbackUri = Uri.tryParse(callbackUriString);
    if (callbackUri == null) log('invalid Uri');
    return callbackUri;
  }

  String? _getAccountUuidFromUri(Uri uri) {
    return uri.queryParameters['account_uuid'];
  }
}
