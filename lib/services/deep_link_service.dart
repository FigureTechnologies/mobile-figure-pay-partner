import 'dart:developer';

import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class DeepLinkService {
  static const myScheme = 'figurepaypartner';

  Stream<Uri?> get linkStream => uriLinkStream;

  bool initialLinkHandled = false;

  Future<Uri?> get initialUri async {
    if (initialLinkHandled) return null;
    initialLinkHandled = true;

    try {
      // Use the uri and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
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
