class Partner {
  final String accountId;
  final Uri callbackUri;
  final String appName;
  final String referenceId;

  Partner(
      {required this.accountId,
      required this.callbackUri,
      required this.appName,
      required this.referenceId});
}
