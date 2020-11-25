import 'package:equatable/equatable.dart';
import 'package:kedatonkomputer/core/models/user_model.dart';
import 'package:meta/meta.dart';

abstract class UserState extends Equatable {
  const UserState();
  @override
  List<Object> get props => [];
}

class UserUninitialized extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> data;
  final bool hasReachedMax;

  const UserLoaded({
    @required this.data,
    @required this.hasReachedMax,
  });

  UserLoaded copyWith({
    List<User> data,
    bool hasReachedMax,
  }) {
    return UserLoaded(
      data: data ?? this.data,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [data, hasReachedMax];
}

class UserDetailLoaded extends UserState {
  final User data;

  const UserDetailLoaded({@required this.data});

  @override
  List<Object> get props => [data];
}

class UserDeleted extends UserState {}

class UserPasswordWasReset extends UserState {}

class UserFailure extends UserState {
  final String error;

  const UserFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
