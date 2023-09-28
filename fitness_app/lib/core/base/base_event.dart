part of 'base_bloc.dart';

class BaseEvent {}

class EventLoading extends BaseEvent {}

class EventNoData extends BaseEvent {}

class EventInternetError extends BaseEvent {}

class EventOnSuccess<T> extends BaseEvent {
  T response;
  EventOnSuccess(this.response);
}

class EventErrorGeneral extends BaseEvent {
  String errorMessage;
  EventErrorGeneral(this.errorMessage);
}

/*
* only for pagination
* */
class PaginationSuccess<T> extends BaseEvent {
  T response;
  PaginationSuccess(this.response);
}

class PaginationInternetError extends BaseEvent {
  PaginationInternetError();
}

class PaginationServerError extends BaseEvent {
  PaginationServerError();
}



