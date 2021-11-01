/// Responsible for holding data related to deeplinks and their callbacks
class Partner {
  final String accountUuid;
  final Uri callbackUri;
  final String appName;
  final String referenceUuid;

  Partner(
      {required this.accountUuid,
      required this.callbackUri,
      required this.appName,
      required this.referenceUuid});
}
