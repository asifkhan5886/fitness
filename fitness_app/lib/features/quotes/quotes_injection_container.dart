import 'package:get_it/get_it.dart';
import 'package:fitness_app/features/quotes/data/datasources/quotes_data_source.dart';
import 'package:fitness_app/features/quotes/data/datasources/quotes_data_source_impl.dart';
import 'package:fitness_app/features/quotes/presentation/bloc/quotes_bloc.dart';

import 'data/repositories/quotes_repository_impl.dart';
import 'domain/repositories/quotes_repository.dart';
import 'domain/usecase/quotes_usecase.dart';

final quotesSl = GetIt.instance;

Future<void> init() async {

  // bloc
  quotesSl.registerFactory(() => QuotesBloc(quotesUseCase: quotesSl()));

  // Use cases
  quotesSl.registerLazySingleton(() => QuotesUseCase(quotesSl()));

  // Repository
  quotesSl.registerLazySingleton<QuotesRepository>(
        () => QuotesRepositoryImpl(
            seriesRemoteDataSource: quotesSl()),
  );

  // Local Data sources
  quotesSl.registerLazySingleton<QuotesRemoteDataSource>(
        () => QuotesRemoteDataSourceImpl(),
  );
}
