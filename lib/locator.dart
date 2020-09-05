import 'package:get_it/get_it.dart';
import 'package:pomodoro_timer/core/services/github-api.service.dart';
import 'package:pomodoro_timer/core/services/timer.service..dart';
import 'package:pomodoro_timer/ui/viewmodels/timer.viewmodel.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // service
  locator.registerLazySingleton(() => TimerService());
  locator.registerLazySingleton(() => GithubApiService());

  // view models
  locator.registerLazySingleton(() => TimerViewModel());
}
