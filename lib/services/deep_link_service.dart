import 'dart:async';
import 'dart:developer';

import 'package:global_configuration/global_configuration.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

enum DeepLinkEventType { payInvoice, getReferenceUuid, error }

// Events

abstract class DeepLinkEvent {
  final DeepLinkEventType type;
  DeepLinkEvent(this.type);
}

class DeepLinkInvoiceEvent extends DeepLinkEvent {
  final String invoiceUuid;
  final Uri callbackUri;
  DeepLinkInvoiceEvent(this.invoiceUuid, this.callbackUri)
      : super(DeepLinkEventType.payInvoice);
}

class DeepLinkGetReferenceUuidEvent extends DeepLinkEvent {
  final Uri callbackUri;
  final String requestingApp;
  final String referenceUuid;
  DeepLinkGetReferenceUuidEvent(
      this.callbackUri, this.requestingApp, this.referenceUuid)
      : super(DeepLinkEventType.getReferenceUuid);
}

class DeepLinkErrorEvent extends DeepLinkEvent {
  String message;
  DeepLinkErrorEvent({required this.message}) : super(DeepLinkEventType.error);
}

// Service

class DeepLinkService {
  static DeepLinkService? _instance;
  DeepLinkService._();
  factory DeepLinkService() => _instance ??= DeepLinkService._();

  static bool _initialLinkHandled = false;

  late final eventStream = uriLinkStream.transform<DeepLinkEvent>(
    StreamTransformer<Uri?, DeepLinkEvent>.fromHandlers(
      handleData: (uri, sink) async {
        log('uri: ${uri.toString()}');
        if (uri == null) return;

        final event = await _eventFor(uri: uri);
        if (event != null) {
          sink.add(event);
        }
      },
    ),
  );

  Future<DeepLinkEvent?> get initialEvent async {
    final uri = await _initialUri;
    log('initialUri: $uri');
    if (uri != null) {
      return _eventFor(uri: uri);
    }
  }

  Future<DeepLinkEvent?> _eventFor({required Uri uri}) async {
    if (uri.path.startsWith('/figurepay/invoices/')) {
      final invoiceId = _getInvoiceIdFromUri(uri);
      final callbackUri = _getCallbackUri(deepLinkUri: uri);
      if (invoiceId != null && callbackUri != null) {
        return DeepLinkInvoiceEvent(invoiceId, callbackUri);
      } else {
        return DeepLinkErrorEvent(
            message:
                'Malformed Uri: Could not retrieve invoiceId and/or callback_uri');
      }
    } else if (uri.path.startsWith('/figurepay/getUser')) {
      final callbackUri = _getCallbackUri(deepLinkUri: uri);
      if (callbackUri == null) {
        return DeepLinkErrorEvent(
            message: 'Malformed Uri: Could not retrieve callback_uri');
      }

      final identityUuid = _getIdentityUuidFromUri(deepLinkUri: uri);
      if (identityUuid == null) {
        log('identityUuid is null');
        return DeepLinkErrorEvent(
            message: 'Malformed Uri: Could not retrieve identity_id');
      }

      // Normally we would retreive reference_uuid via an API call
      final referenceUuid = GlobalConfiguration().getValue('reference_uuid');

      if (referenceUuid == null || referenceUuid?.isEmpty) {
        log('referenceUuid is null');
        return DeepLinkErrorEvent(
            message:
                'Incorrect config:\nBe sure to include the key \'reference_uuid\' inside the file:\nlib/config/config.dart');
      }

      // Normally we would retreive partner meta data via an API call
      final requestingAppName = GlobalConfiguration().getValue('app_name');

      if (requestingAppName == null) {
        log('requestingAppName is null');
        return DeepLinkErrorEvent(
            message:
                'Incorrect config:\nBe sure to include the key \'app_name\' inside the file:\nlib/config/config.dart');
      }

      return DeepLinkGetReferenceUuidEvent(
          callbackUri, requestingAppName, referenceUuid);
    }

    return null;
  }

  Future<Uri?> get _initialUri async {
    if (_initialLinkHandled) return null;
    _initialLinkHandled = true;

    try {
      final initialUri = await getInitialUri();
      print('initialUri: $initialUri');
      return initialUri;
    } on FormatException catch (e) {
      print(e);
      return null;
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

  Future<bool> launchCallbackUri(Uri callbackUri) async {
    final uriString = callbackUri.toString();

    log('canLaunch: ${await canLaunch(uriString)}');
    log('Launching: $uriString');
    return launch(uriString);
  }

  /// https://figuretechnologies.github.io/docs-figurepay-partner-api/getting-user-account
  Future<bool> launchCallbackWithUserInfo(Uri callbackUri,
      {required String referenceUuid}) {
    final uri =
        callbackUri.replace(queryParameters: {'reference_uuid': referenceUuid});
    return launchCallbackUri(uri);
  }

  String? _getInvoiceIdFromUri(Uri uri) {
    if (uri.path.startsWith('/figurepay/invoices/') &&
        uri.pathSegments.length == 3) {
      return uri.pathSegments[2];
    }

    log('Unable to get InvoiceId from Uri');
    return null;
  }

  String? _getIdentityUuidFromUri({required Uri deepLinkUri}) {
    return deepLinkUri.queryParameters['identity_id'];
  }
}
