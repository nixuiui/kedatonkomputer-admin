import 'package:equatable/equatable.dart';
import 'package:kedatonkomputer/core/models/order_model.dart';
import 'package:meta/meta.dart';

abstract class OrderState extends Equatable {
  const OrderState();
  @override
  List<Object> get props => [];
}

class OrderUninitialized extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<OrderModel> data;

  const OrderLoaded({
    @required this.data,
  });

  @override
  List<Object> get props => [data];
}

class OrderCreated extends OrderState {
  final OrderModel data;

  const OrderCreated({
    @required this.data,
  });

  @override
  List<Object> get props => [data];
}

class OrderCanceled extends OrderState {
  final OrderModel data;

  const OrderCanceled({
    @required this.data,
  });

  @override
  List<Object> get props => [data];
}

class TransactionFinished extends OrderState {
  final OrderModel data;

  const TransactionFinished({
    @required this.data,
  });

  @override
  List<Object> get props => [data];
}

class OrderDetailLoaded extends OrderState {
  final OrderModel data;

  const OrderDetailLoaded({
    @required this.data,
  });

  @override
  List<Object> get props => [data];
}

class OrderFailure extends OrderState {
  final String error;

  const OrderFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
