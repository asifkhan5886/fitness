part of 'base_bloc.dart';

abstract class BaseState {}

class StateInitial extends BaseState implements Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];

  @override
  // TODO: implement stringify
  bool get stringify => false;
}

class StateLoading extends BaseState implements Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];

  @override
  // TODO: implement stringify
  bool get stringify => false;
}

class StateNoData extends BaseState {}

class StateInternetError extends BaseState {}

class StateErrorServer extends BaseState {}

class StateErrorGeneral extends BaseState {
  String errorMessage;

  StateErrorGeneral(this.errorMessage);
}

class StatePaginationSuccess extends BaseState implements Equatable {
  List data;
  bool isEndOfList;
  bool isServerError;
  bool isInternetError;

  StatePaginationSuccess(this.data, this.isEndOfList,
      {this.isServerError = false, this.isInternetError = false});

  StatePaginationSuccess copyWith({
    List? data,
    bool? isEndOfList,
    bool? isServerError,
    bool? isInternetError,
  }) =>
      StatePaginationSuccess(
        data ?? this.data,
        isEndOfList ?? this.isEndOfList,
        isServerError: isServerError ?? this.isServerError,
        isInternetError: isInternetError ?? this.isInternetError,
      );

  @override
  // TODO: implement props
  List<Object> get props => [data, isEndOfList, isServerError, isInternetError];

  @override
  // TODO: implement stringify
  bool get stringify => false;
}
