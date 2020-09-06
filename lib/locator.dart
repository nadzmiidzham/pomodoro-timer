import 'package:get_it/get_it.dart';
import 'package:pomodoro_timer/core/services/cache.service.dart';
import 'package:pomodoro_timer/core/services/github-api.service.dart';
import 'package:pomodoro_timer/core/services/social-media.service.dart';
import 'package:pomodoro_timer/core/services/timer.service..dart';
import 'package:pomodoro_timer/ui/viewmodels/about.viewmodel.dart';
import 'package:pomodoro_timer/ui/viewmodels/timer.viewmodel.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // service
  locator.registerLazySingleton(() => TimerService());
  locator.registerLazySingleton(() => GithubApiService());
  locator.registerLazySingleton(() => CacheService());
  locator.registerLazySingleton(() => SocialMediaService());

  // view models
  locator.registerLazySingleton(() => TimerViewModel());
  locator.registerLazySingleton(() => AboutViewModel());
}
