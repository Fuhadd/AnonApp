import 'package:anon/data/repositories/community_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/local_cache/local_cache.dart';
import 'data/local_cache/local_cache_impl.dart';
import 'data/repositories/chat_repo.dart';
import 'data/repositories/user_repo.dart';
import 'utils/navigator_handler.dart';

GetIt locator = GetIt.instance;

///Registers dependencies
Future<void> setupLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton(sharedPreferences);

  //Local storage

  // //Local storage
  locator.registerLazySingleton<NavigationHandler>(
    () => NavigationHandlerImpl(),
  );
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      cache: locator(),
    ),
  );
  locator.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      cache: locator(),
    ),
  );
  locator.registerLazySingleton<CommunityRepository>(
    () => CommunityRepositoryImpl(
      cache: locator(),
    ),
  );

  locator.registerLazySingleton<LocalCache>(
    () => LocalCacheImpl(
      sharedPreferences: locator(),
    ),
  );
}
