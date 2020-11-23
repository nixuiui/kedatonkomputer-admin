import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:kedatonkomputer/core/api/order_api.dart';
import 'package:kedatonkomputer/core/bloc/order/order_event.dart';
import 'package:kedatonkomputer/core/bloc/order/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final api = OrderApi();

  OrderBloc() : super(OrderUninitialized());

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {

    if (event is LoadMyOrders) {
      yield OrderLoading();
      try {
        var response = await api.getOrders();
        yield OrderLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield OrderFailure(error: error.toString());
      }
    }
    
    if (event is LoadDetailOrder) {
      yield OrderLoading();
      try {
        var response = await api.detailOrder(event.id);
        yield OrderDetailLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield OrderFailure(error: error.toString());
      }
    }
    
    if (event is ConfirmOrder) {
      yield OrderLoading();
      try {
        await api.confirmationOrder(
          id: event.id,
          status: event.status,
          cancelReason: event.cancelReason
        );
        yield OrderConfirmated();
      } catch (error) {
        print("ERROR: $error");
        yield OrderFailure(error: error.toString());
      }
    }
    
    if (event is ReceiveOrder) {
      yield OrderLoading();
      try {
        await api.receiveOrder(event.order, event.proofItemReceived);
        yield OrderReceived();
      } catch (error) {
        print("ERROR: $error");
        yield OrderFailure(error: error.toString());
      }
    }

  }
}