import 'package:dartz/dartz.dart';
import 'package:fitness_app/core/failure/failures.dart';
import 'package:fitness_app/core/networking/base_response.dart';

abstract class QuotesRepository{
  Stream<Either<Failure, BaseResponse?>> getSeriesList();
}