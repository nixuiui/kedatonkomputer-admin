import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:kedatonkomputer/core/api/product_api.dart';
import 'package:kedatonkomputer/core/bloc/product/product_event.dart';
import 'package:kedatonkomputer/core/bloc/product/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final api = ProductApi();
  int page = 1;
  int limit = 10;

  ProductBloc() : super(ProductUninitialized());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    final currentState = state;
    
    if (event is LoadProducts) {
      page = event.page ?? page;
      limit = event.limit ?? limit;
      if(event.isRefresh || currentState is ProductUninitialized) {
          page = event.page ?? 1;
      } else if(currentState is ProductLoaded){
          int length = currentState.data.length;
          if(length%limit > 0)  
            yield currentState.copyWith(hasReachedMax: true);
          page = (currentState.data.length/limit).ceil() + 1;
      }

      try {
        yield ProductLoading();
        final response = await api.loadProducts(
          search: event.search,
          page: page,
          limit: limit
        );
        if(event.isRefresh || currentState is ProductUninitialized) {
          yield ProductLoaded(data: response, hasReachedMax: response.length < limit);
        } else if(currentState is ProductLoaded){
          if(response.length > 0)
            yield ProductLoaded(data: currentState.data + response, hasReachedMax: response.length < limit);
          else
            yield currentState.copyWith(hasReachedMax: true);
        }
      } catch (error) {
        print("ERROR: $error");
        yield ProductFailure(error: error.toString());
      }
    }

    if (event is LoadProductDetail) {
      yield ProductLoading();
      try {
        var response = await api.loadProductDetail(id: event.id);
        yield ProductDetailLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield ProductFailure(error: error.toString());
      }
    }
    
    if (event is CreateProduct) {
      yield ProductLoading();
      try {
        await api.createProduct(data: event.data);
        yield ProductCreated();
      } catch (error) {
        print("ERROR: $error");
        yield ProductFailure(error: error.toString());
      }
    }
    
    if (event is UpdateProduct) {
      yield ProductLoading();
      try {
        await api.editProduct(data: event.data);
        yield ProductCreated();
      } catch (error) {
        print("ERROR: $error");
        yield ProductFailure(error: error.toString());
      }
    }
    
    if (event is DeleteProduct) {
      yield ProductLoading();
      try {
        await api.deleteProduct(id: event.id);
        yield ProductDeleted();
      } catch (error) {
        print("ERROR: $error");
        yield ProductFailure(error: error.toString());
      }
    }

  }
}