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
