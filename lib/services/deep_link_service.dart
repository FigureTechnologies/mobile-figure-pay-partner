import 'package:uni_links/uni_links.dart';

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
}
