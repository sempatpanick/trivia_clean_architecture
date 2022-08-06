import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:trivia_clean_architecture/data/datasources/trivia_local_data_source.dart';
import 'package:trivia_clean_architecture/data/datasources/trivia_remote_data_source.dart';
import 'package:trivia_clean_architecture/data/repositories/trivia_repository_impl.dart';
import 'package:trivia_clean_architecture/domain/repositories/trivia_repository.dart';
import 'package:trivia_clean_architecture/domain/usecases/get_concrete_number_trivia.dart';
import 'package:trivia_clean_architecture/domain/usecases/get_random_number_trivia.dart';
import 'package:trivia_clean_architecture/presentation/provider/number_trivia_notifier.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => NumberTriviaNotifier(
      getConcreteNumberTrivia: locator(),
      getRandomNumberTrivia: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetConcreteNumberTrivia(locator()));
  locator.registerLazySingleton(() => GetRandomNumberTrivia(locator()));

  //repository
  locator.registerLazySingleton<TriviaRepository>(
    () => TriviaRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<TriviaRemoteDataSource>(
    () => TriviaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton<TriviaLocalDataSource>(
    () => TriviaLocalDataSourceImpl(),
  );

  // helper

  // external
  locator.registerLazySingleton(() => http.Client());
}
