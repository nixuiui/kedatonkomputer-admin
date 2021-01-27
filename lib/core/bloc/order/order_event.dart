import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:kedatonkomputer/core/models/order_post_model.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class LoadMyOrders extends OrderEvent {
  final String status;
  final int page;
  final int limit;
  final bool isRefresh;
  final bool isLoadMore;

  const LoadMyOrders({
    this.status = "",
    this.page,
    this.limit,
    this.isRefresh = false,
    this.isLoadMore = false,
  });

  @override
  List<Object> get props => [status, page, limit, isRefresh, isLoadMore];
}

class LoadDetailOrder extends OrderEvent {
  final String id;

  const LoadDetailOrder({
    this.id
  });

  @override
  List<Object> get props => [id];
}

class CreateOrder extends OrderEvent {
  final OrderPost data;

  const CreateOrder({
    this.data
  });

  @override
  List<Object> get props => [data];
}

class ConfirmOrder extends OrderEvent {
  final String id;
  final String status;
  final String cancelReason;

  const ConfirmOrder({
    this.id,
    this.status,
    this.cancelReason,
  });

  @override
  List<Object> get props => [id, status, cancelReason];
}

class ReceiveOrder extends OrderEvent {
  final String order;
  final File proofItemReceived;

  const ReceiveOrder({
    this.order,
    this.proofItemReceived,
  });

  @override
  List<Object> get props => [order, proofItemReceived];
}

class GetReport extends OrderEvent {
  final String fromDate;
  final String toDate;

  const GetReport({
    this.fromDate,
    this.toDate,
  });

  @override
  List<Object> get props => [fromDate, toDate];
}