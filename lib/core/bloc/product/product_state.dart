import 'package:equatable/equatable.dart';
import 'package:kedatonkomputer/core/models/product_model.dart';
import 'package:meta/meta.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object> get props => [];
}

class ProductUninitialized extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> data;
  final bool hasReachedMax;

  const ProductLoaded({
    @required this.data,
    @required this.hasReachedMax,
  });

  ProductLoaded copyWith({
    List<Product> data,
    bool hasReachedMax,
  }) {
    return ProductLoaded(
      data: data ?? this.data,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [data, hasReachedMax];
}

class ProductDetailLoaded extends ProductState {
  final Product data;

  const ProductDetailLoaded({@required this.data});

  @override
  List<Object> get props => [data];
}

class ProductCreated extends ProductState {}

class ProductUpdated extends ProductState {}

class ProductDeleted extends ProductState {}

class ProductFailure extends ProductState {
  final String error;

  const ProductFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
