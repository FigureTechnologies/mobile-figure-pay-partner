import 'dart:async';
import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_figure_pay_partner/models/partner.dart';

import 'services/deep_link_service.dart';

class DashboardViewModel extends StateNotifier<AsyncValue<Partner?>> {
  DashboardViewModel(this._deepLinkService) : super(AsyncValue.data(null)) {
    setup();
  }

  final DeepLinkService _deepLinkService;
  // final FlowController<OrderFlowState> _flowState;
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
      final requestingAppName = _getAppNameFromUri(uri);
      final callbackUri = _getCallbackUri(deepLinkUri: uri);
      if (requestingAppName == null) {
        state = AsyncError('Malformed Uri: Could not retrieve app_name');
      } else if (callbackUri == null) {
        state = AsyncError('Malformed Uri: Could not retrieve callback_uri');
      } else {
        state = AsyncData(
            Partner(appName: requestingAppName, callbackUri: callbackUri));
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

  String? _getAppNameFromUri(Uri uri) {
    return uri.queryParameters['app_name'];
  }
}
