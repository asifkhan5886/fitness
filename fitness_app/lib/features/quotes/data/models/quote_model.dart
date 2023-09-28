class QuoteModel {
  List<Quotes>? _quotes;
  int? _total;
  int? _skip;
  int? _limit;

  QuoteModel({List<Quotes>? quotes, int? total, int? skip, int? limit}) {
    if (quotes != null) {
      _quotes = quotes;
    }
    if (total != null) {
      _total = total;
    }
    if (skip != null) {
      _skip = skip;
    }
    if (limit != null) {
      _limit = limit;
    }
  }

  List<Quotes>? get quotes => _quotes;
  set quotes(List<Quotes>? quotes) => _quotes = quotes;
  int? get total => _total;
  set total(int? total) => _total = total;
  int? get skip => _skip;
  set skip(int? skip) => _skip = skip;
  int? get limit => _limit;
  set limit(int? limit) => _limit = limit;

  QuoteModel.fromJson(Map<String, dynamic> json) {
    if (json['quotes'] != null) {
      _quotes = <Quotes>[];
      json['quotes'].forEach((v) {
        _quotes!.add(Quotes.fromJson(v));
      });
    }
    _total = json['total'];
    _skip = json['skip'];
    _limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_quotes != null) {
      data['quotes'] = _quotes!.map((v) => v.toJson()).toList();
    }
    data['total'] = _total;
    data['skip'] = _skip;
    data['limit'] = _limit;
    return data;
  }
}

class Quotes {
  int? _id;
  String? _quote;
  String? _author;

  Quotes({int? id, String? quote, String? author}) {
    if (id != null) {
      _id = id;
    }
    if (quote != null) {
      _quote = quote;
    }
    if (author != null) {
      _author = author;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get quote => _quote;
  set quote(String? quote) => _quote = quote;
  String? get author => _author;
  set author(String? author) => _author = author;

  Quotes.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _quote = json['quote'];
    _author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['quote'] = _quote;
    data['author'] = _author;
    return data;
  }
}
