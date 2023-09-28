import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/failure/failures.dart';
import 'package:fitness_app/core/networking/base_response.dart';
import 'package:fitness_app/features/quotes/domain/repositories/quotes_repository.dart';

import '../../../../core/usecase/usecase.dart';

class QuotesUseCase implements UseCase<BaseResponse?, NoParams>  {
  QuotesRepository seriesRepository;
  QuotesUseCase(this.seriesRepository);

  @override
  Stream<Either<Failure, BaseResponse?>> call(NoParams params) {
    return seriesRepository.getSeriesList();
  }
}

// This will be used by the code calling the use case whenever the use case
// doesn't accept any parameters.
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}