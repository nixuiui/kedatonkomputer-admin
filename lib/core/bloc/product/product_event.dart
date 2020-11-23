import 'package:equatable/equatable.dart';
import 'package:kedatonkomputer/core/models/product_model.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductEvent {
  final String search;
  final int page;
  final int limit;
  final bool isRefresh;
  final bool isLoadMore;

  const LoadProducts({
    this.search = "",
    this.page,
    this.limit,
    this.isRefresh = false,
    this.isLoadMore = false,
  });

  @override
  List<Object> get props => [search, page, limit, isRefresh, isLoadMore];
}

class LoadProductDetail extends ProductEvent {
  final String id;

  const LoadProductDetail({
    this.id
  });

  @override
  List<Object> get props => [id];
}

class CreateProduct extends ProductEvent {
  final ProductPost data;

  const CreateProduct({
    this.data
  });

  @override
  List<Object> get props => [data];
}

class UpdateProduct extends ProductEvent {
  final ProductPost data;

  const UpdateProduct({
    this.data
  });

  @override
  List<Object> get props => [data];
}

class DeleteProduct extends ProductEvent {
  final String id;

  const DeleteProduct({
    this.id
  });

  @override
  List<Object> get props => [id];
}