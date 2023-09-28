import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/core/base/base_bloc.dart';
import 'package:fitness_app/core/failure/failures.dart';
import 'package:fitness_app/core/utils/strings.dart';
import 'package:fitness_app/features/quotes/data/models/quote_model.dart';
import 'package:fitness_app/features/quotes/domain/usecase/quotes_usecase.dart';
import 'package:fitness_app/features/quotes/presentation/bloc/quotes_event.dart';

import 'quotes_state.dart';

class QuotesBloc extends Bloc<BaseEvent, BaseState> {
  QuotesUseCase quotesUseCase;
  List<QuoteModel> episodeList = [];


  QuotesBloc({required this.quotesUseCase}) : super(StateInitial()) {
    on<SeriesEvent>((event, emit) {
      emit(StateLoading());
      _getQuotes();
    });
    on<QuotesSuccessEvent>((event, emit) {
      emit(GetQuotesState(quotesList: event.quotes));
    });
  }

  void _getQuotes() {
    quotesUseCase.call(NoParams()).listen((isSingUp) {
      isSingUp.fold((onError) {
        add(EventErrorGeneral(_mapFailureToMessage(onError) ?? ''));
      }, (response) {
        if (response?.data != null) {
          QuoteModel quoteModel=QuoteModel.fromJson(response?.data);
          add(QuotesSuccessEvent(quotes: quoteModel.quotes));
        }
      });
    });
  }

  String? _mapFailureToMessage(Failure failure) {
    if (failure.runtimeType == ServerFailure) {
      return Strings.serverFailurePleaseTryAgain;
    } else if (failure.runtimeType == CacheFailure) {
      return Strings.cacheFailure;
    } else if (failure.runtimeType == FailureMessage) {
      if (failure is FailureMessage) {
        return failure.message;
      }
    }
  }
}
