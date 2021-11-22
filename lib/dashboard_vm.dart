import 'dart:async';
import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_figure_pay_partner/top_providers.dart';

import 'services/deep_link_service.dart';

final deepLinkeEventProvider = StateNotifierProvider.autoDispose<
    DeepLinkEventNotifier, AsyncValue<DeepLinkEvent?>>((ref) {
  final deepLinkService = ref.watch(deepLinkServiceProvider);
  return DeepLinkEventNotifier(deepLinkService);
});

/// Notifier checks for an initial valid URI event that could have launched the app
/// and also subsribes to stream to receive events in case app is already running
/// or new event comes in. The Dashboard listens to this notifier via provider and acts accordingly
class DeepLinkEventNotifier extends StateNotifier<AsyncValue<DeepLinkEvent?>> {
  DeepLinkEventNotifier(this._deepLinkService) : super(AsyncData(null)) {
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
    _streamSubscription = _deepLinkService.eventStream.listen((event) {
      state = AsyncData(event);
    }, onError: (e) {
      log('Failed to parse the unilink', error: e);
      state = AsyncError(e);
    });

    final initialEvent = await _deepLinkService.initialEvent;
    if (initialEvent != null) {
      state = AsyncData(initialEvent);
    }
  }
}
