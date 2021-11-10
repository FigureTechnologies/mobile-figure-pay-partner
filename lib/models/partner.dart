/// Responsible for holding data related to deeplinks and their callbacks
class Partner {
  final String identityUuid;
  final Uri callbackUri;
  final String appName;
  final String referenceUuid;

  Partner(
      {required this.identityUuid,
      required this.callbackUri,
      required this.appName,
      required this.referenceUuid});
}
