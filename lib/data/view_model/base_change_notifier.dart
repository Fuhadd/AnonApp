import 'package:anon/data/repositories/community_repo.dart';
import 'package:flutter/foundation.dart';
import '../../components/app_logger.dart';
import '../../locator.dart';
import '../../utils/navigator_handler.dart';
import '../local_cache/local_cache.dart';
import '../repositories/chat_repo.dart';
import '../repositories/user_repo.dart';

class BaseChangeNotifier extends ChangeNotifier {
  late UserRepository userRepository;
  late ChatRepository chatRepository;
  late LocalCache localCache;
  late NavigationHandler navigationHandler;
  late CommunityRepository communityRepository;

  BaseChangeNotifier({
    UserRepository? userRepository,
    ChatRepository? chatRepository,
    CommunityRepository? communityRepository,
    LocalCache? localCache,
    NavigationHandler? navigationHandler,
  }) {
    this.userRepository = userRepository ?? locator();
    this.localCache = localCache ?? locator();
    this.navigationHandler = navigationHandler ?? locator();
    this.communityRepository = communityRepository ?? locator();
    this.chatRepository = chatRepository ?? locator();
  }

  // ignore: prefer_final_fields
  bool _loading = false;

  bool get loading => _loading;
  void log(Object? e) {
    AppLogger.log("$e");
  }
}
