import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends UserEvent {
  final String search;
  final int page;
  final int limit;
  final bool isRefresh;
  final bool isLoadMore;

  const LoadUsers({
    this.search = "",
    this.page,
    this.limit,
    this.isRefresh = false,
    this.isLoadMore = false,
  });

  @override
  List<Object> get props => [search, page, limit, isRefresh, isLoadMore];
}

class LoadUserDetail extends UserEvent {
  final String id;

  const LoadUserDetail({
    this.id
  });

  @override
  List<Object> get props => [id];
}

class DeleteUser extends UserEvent {
  final String id;

  const DeleteUser({
    this.id
  });

  @override
  List<Object> get props => [id];
}

class ResetPassword extends UserEvent {
  final String id;

  const ResetPassword({
    this.id
  });

  @override
  List<Object> get props => [id];
}