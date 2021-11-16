/// Configuration file for Figure Pay Partner
///
/// Do not leave these values empty
final Map<String, String> config = {
  'app_name': 'Partner App',
  'reference_uuid': '', // provided by Figure for each partner
};

void validateConfig() {
  _validateEntry('app_name');
  _validateEntry('reference_uuid');
}

void _validateEntry(String entry) {
  if (config[entry]?.isEmpty ?? true) {
    throw ('config[$entry] can not be empty');
  }
}
