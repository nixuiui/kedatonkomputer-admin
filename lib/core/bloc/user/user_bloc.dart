import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:kedatonkomputer/core/api/user_api.dart';
import 'package:kedatonkomputer/core/bloc/user/user_event.dart';
import 'package:kedatonkomputer/core/bloc/user/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final api = UserApi();
  int page = 1;
  int limit = 10;

  UserBloc() : super(UserUninitialized());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    final currentState = state;
    
    if (event is LoadUsers) {
      page = event.page ?? page;
      limit = event.limit ?? limit;
      if(event.isRefresh || currentState is UserUninitialized) {
        page = event.page ?? 1;
      } else if(currentState is UserLoaded){
        int length = currentState.data.length;
        if(length%limit > 0)  
          yield currentState.copyWith(hasReachedMax: true);
        page = (currentState.data.length/limit).ceil() + 1;
      }

      try {
        yield UserLoading();
        final response = await api.loadUsers(
          search: event.search,
          page: page,
          limit: limit
        );
        if(event.isRefresh || currentState is UserUninitialized) {
          yield UserLoaded(data: response, hasReachedMax: response.length < limit);
        } else if(currentState is UserLoaded){
          if(response.length > 0)
            yield UserLoaded(data: currentState.data + response, hasReachedMax: response.length < limit);
          else
            yield currentState.copyWith(hasReachedMax: true);
        }
      } catch (error) {
        print("ERROR: $error");
        yield UserFailure(error: error.toString());
      }
    }

    if (event is LoadUserDetail) {
      yield UserLoading();
      try {
        var response = await api.loadUserDetail(id: event.id);
        yield UserDetailLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield UserFailure(error: error.toString());
      }
    }
    
    if (event is ResetPassword) {
      yield UserLoading();
      try {
        await api.resetPassword(id: event.id);
        yield UserPasswordWasReset();
      } catch (error) {
        print("ERROR: $error");
        yield UserFailure(error: error.toString());
      }
    }
    
    if (event is DeleteUser) {
      yield UserLoading();
      try {
        await api.deleteUser(id: event.id);
        yield UserDeleted();
      } catch (error) {
        print("ERROR: $error");
        yield UserFailure(error: error.toString());
      }
    }

  }
}