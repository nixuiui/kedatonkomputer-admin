import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class LoadCategories extends CategoryEvent {
  final String search;
  final int page;
  final int limit;
  final bool isRefresh;
  final bool isLoadMore;

  const LoadCategories({
    this.search = "",
    this.page,
    this.limit,
    this.isRefresh = false,
    this.isLoadMore = false,
  });

  @override
  List<Object> get props => [search, page, limit, isRefresh, isLoadMore];
}

class CreateCategory extends CategoryEvent {
  final String name;

  const CreateCategory({
    this.name
  });

  @override
  List<Object> get props => [name];
}

class UpdateCategory extends CategoryEvent {
  final String id;
  final String name;

  const UpdateCategory({
    this.id,
    this.name,
  });

  @override
  List<Object> get props => [id, name];
}

class DeleteCategory extends CategoryEvent {
  final String id;

  const DeleteCategory({
    this.id,
  });

  @override
  List<Object> get props => [id];
}