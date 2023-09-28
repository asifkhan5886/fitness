
import 'package:fitness_app/core/base/base_bloc.dart';
import 'package:fitness_app/features/quotes/data/models/quote_model.dart';

class SeriesEvent extends BaseEvent {

  SeriesEvent();
  @override
  bool get stringify => true;
}

class QuotesSuccessEvent extends BaseEvent {
  List<Quotes>? quotes;
  QuotesSuccessEvent({this.quotes,});
  @override
  bool get stringify => true;
}

class EpisodesEvent extends BaseEvent {
  QuoteModel episodeModel;
  EpisodesEvent({required this.episodeModel,});
  @override
  bool get stringify => true;
}