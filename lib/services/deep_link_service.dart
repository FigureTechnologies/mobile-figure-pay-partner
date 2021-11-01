import 'dart:developer';

import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

/// Service for handling deeplinks
class DeepLinkService {
  static const myScheme = 'figurepaypartner';

  Stream<Uri?> get linkStream => uriLinkStream;

  bool initialLinkHandled = false;

  // Used to retrieve the initial uri if the deeplink is called when the app is not already open
  Future<Uri?> get initialUri async {
    if (initialLinkHandled) return null;
    initialLinkHandled = true;

    try {
      final initialUri = await getInitialUri();
      print('initialUri: $initialUri');
      return initialUri;
    } on FormatException catch (e) {
      // Handle exception by warning the user their action did not succeed
      print(e);
      return null;
    }
  }

  Future<bool> launchCallbackUri(Uri callbackUri) async {
    final uriString = callbackUri.toString();

    log('canLaunch: ${await canLaunch(uriString)}');
    log('Launching: $uriString');
    return launch(uriString);
  }

  // https://figuretechnologies.github.io/docs-figurepay-partner-api/getting-user-account
  Future<bool> launchCallbackWithUserInfo(Uri callbackUri,
      {required String referenceUuid}) {
    final uri = callbackUri.replace(queryParameters: {
      'reference_uuid': referenceUuid,
    });
    return launchCallbackUri(uri);
  }
}
