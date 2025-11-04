import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Domain
import '../../domain/repositories/counter_repository.dart';
import '../../domain/usecases/get_counter.dart';
import '../../domain/usecases/increment_counter.dart';
import '../../domain/usecases/decrement_counter.dart';
import '../../domain/usecases/reset_counter.dart';

// Data
import '../../data/datasources/counter_local_datasource.dart';
import '../../data/repositories/counter_repository_impl.dart';

// Presentation
import '../../presentation/bloc/counter_bloc.dart';

/// حاوية Dependency Injection - تدير جميع التبعيات في التطبيق
final sl = GetIt.instance;

/// تهيئة جميع التبعيات
Future<void> init() async {
  //! Features - Counter
  // Bloc
  sl.registerFactory(
    () => CounterBloc(
      getCounter: sl(),
      incrementCounter: sl(),
      decrementCounter: sl(),
      resetCounter: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCounter(sl()));
  sl.registerLazySingleton(() => IncrementCounter(sl()));
  sl.registerLazySingleton(() => DecrementCounter(sl()));
  sl.registerLazySingleton(() => ResetCounter(sl()));

  // Repository
  sl.registerLazySingleton<CounterRepository>(
    () => CounterRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<CounterLocalDataSource>(
    () => CounterLocalDataSourceImpl(sl()),
  );

  //! Core
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
