import 'package:equatable/equatable.dart';
import 'package:kedatonkomputer/core/models/order_model.dart';
import 'package:kedatonkomputer/core/models/report_model.dart';
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

class OrderConfirmated extends OrderState {}

class OrderReceived extends OrderState {}

class OrderDetailLoaded extends OrderState {
  final OrderModel data;

  const OrderDetailLoaded({
    @required this.data,
  });

  @override
  List<Object> get props => [data];
}

class ReportLoaded extends OrderState {
  final ReportResponse data;

  const ReportLoaded({@required this.data});

  @override
  List<Object> get props => [data];
}

class OrderFailure extends OrderState {
  final String error;

  const OrderFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
