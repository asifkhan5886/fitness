import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitness_app/core/failure/failures.dart';
import 'package:fitness_app/core/networking/base_response.dart';
import 'package:fitness_app/features/quotes/domain/repositories/quotes_repository.dart';

import '../datasources/quotes_data_source.dart';

class QuotesRepositoryImpl implements QuotesRepository{
  QuotesRemoteDataSource  seriesRemoteDataSource;
  QuotesRepositoryImpl({required this.seriesRemoteDataSource});

  @override
  Stream<Either<Failure, BaseResponse?>> getSeriesList() async* {
    try {
      BaseResponse? problemResponse = await seriesRemoteDataSource.getSeries();
      if ( problemResponse?.statusCode==200 && problemResponse?.data != null) {

        yield Right(problemResponse!);
      } else {
        yield (Left(FailureMessage(message: problemResponse?.message)));
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 400) {
          yield (Left(FailureMessage(message: e.response?.data.toString())));
        } else if (e.response?.statusCode == 500) {
          yield (Left(FailureMessage(message:"Internal Server Error")));
        } else {
          yield (Left(FailureMessage(message: e.response?.data["error"])));
        }
      } else {
        yield (Left(FailureMessage(message: 'Something went wrong')));
      }
    }
  }

}