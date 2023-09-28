import 'package:fitness_app/core/base/base_bloc.dart';
import 'package:fitness_app/features/quotes/data/models/quote_model.dart';

class GetQuotesState extends BaseState {
  List<Quotes>? quotesList;
  GetQuotesState({this.quotesList,});
}