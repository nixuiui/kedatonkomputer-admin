import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:kedatonkomputer/core/api/category_api.dart';
import 'package:kedatonkomputer/core/bloc/category/category_event.dart';
import 'package:kedatonkomputer/core/bloc/category/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final api = CategoryApi();
  int page = 1;
  int limit = 10;

  CategoryBloc() : super(CategoryUninitialized());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    
    if (event is LoadCategories) {
      yield CategoryLoading();
      try {
        final response = await api.loadCategory();
        yield CategoryLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield CategoryFailure(error: error.toString());
      }
    }

    if (event is CreateCategory) {
      yield CategoryLoading();
      try {
        await api.createCategory(event.name);
        yield CategoryCreated();
      } catch (error) {
        print("ERROR: $error");
        yield CategoryFailure(error: error.toString());
      }
    }
    
    if (event is UpdateCategory) {
      yield CategoryLoading();
      try {
        await api.editCategory(event.name, event.id);
        yield CategoryUpdated();
      } catch (error) {
        print("ERROR: $error");
        yield CategoryFailure(error: error.toString());
      }
    }
    
    if (event is DeleteCategory) {
      yield CategoryLoading();
      try {
        await api.deleteCategory(event.id);
        yield CategoryDeleted();
      } catch (error) {
        print("ERROR: $error");
        yield CategoryFailure(error: error.toString());
      }
    }

  }
}