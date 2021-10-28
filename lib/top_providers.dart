import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_figure_pay_partner/services/deep_link_service.dart';

final deepLinkServiceProvider = Provider((_) => DeepLinkService());
