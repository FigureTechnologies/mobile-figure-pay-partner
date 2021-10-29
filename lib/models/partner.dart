class Partner {
  final String accountId;
  final Uri callbackUri;
  final String appName;
  final String referenceId;
  final String username;

  Partner(
      {required this.accountId,
      required this.callbackUri,
      required this.appName,
      required this.username,
      required this.referenceId});
}
