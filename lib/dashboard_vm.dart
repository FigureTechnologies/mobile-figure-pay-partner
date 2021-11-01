import 'dart:async';
import 'dart:developer';

import 'package:global_configuration/global_configuration.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_figure_pay_partner/models/partner.dart';

import 'services/deep_link_service.dart';

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

  void setup() async {
    _streamSubscription = _deepLinkService.linkStream.listen(
      _onData,
      onError: (error) => state = AsyncError(error),
    );

    final initialUri = await DeepLinkService().initialUri;
    if (initialUri != null) {
      _onData(initialUri);
    }
  }

  Future<void> _onData(Uri? uri) async {
    // Use the uri and warn the user, if it is not correct
    print('_onData: $uri');

    if (uri == null) {
      state = AsyncError('Missing Uri');
      return;
    }

    state = const AsyncLoading();

    if (uri.path.startsWith('/figurepaypartner/getUser')) {
      final accountUuid = _getAccountUuidFromUri(uri);
      final callbackUri = _getCallbackUri(deepLinkUri: uri);
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
