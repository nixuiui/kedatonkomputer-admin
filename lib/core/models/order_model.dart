import 'dart:convert';

import 'package:kedatonkomputer/core/models/product_model.dart';

OrderResponse orderResponseFromJson(String str) => OrderResponse.fromJson(json.decode(str));

String orderResponseToJson(OrderResponse data) => json.encode(data.toJson());

class OrderResponse {
    OrderResponse({
        this.order,
        this.totalOrder,
        this.totalPages,
        this.totalAllOrder,
        this.currentPage,
        this.limit,
    });

    List<OrderModel> order;
    int totalOrder;
    int totalPages;
    int totalAllOrder;
    int currentPage;
    int limit;

    factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        order: List<OrderModel>.from(json["order"].map((x) => OrderModel.fromJson(x))),
        totalOrder: json["totalOrder"],
        totalPages: json["totalPages"],
        totalAllOrder: json["totalAllOrder"],
        currentPage: json["currentPage"],
        limit: json["limit"],
    );

    Map<String, dynamic> toJson() => {
        "order": List<dynamic>.from(order.map((x) => x.toJson())),
        "totalOrder": totalOrder,
        "totalPages": totalPages,
        "totalAllOrder": totalAllOrder,
        "currentPage": currentPage,
        "limit": limit,
    };
}

OrderModel orderModelFromMap(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToMap(OrderModel data) => json.encode(data.toJson());

List<OrderModel> ordersModelFromMap(String str) => List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String ordersModelToMap(List<OrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
    OrderModel({
        this.orderNotes,
        this.admin,
        this.totalPrice,
        this.totalItem,
        this.rating,
        this.ulasan,
        this.paymentMethod,
        this.proofTransactionBill,
        this.proofItemReceived,
        this.cancelReason,
        this.id,
        this.transactionCode,
        this.user,
        this.detailProducts,
        this.statusTransaction,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String orderNotes;
    dynamic admin;
    int totalPrice;
    int totalItem;
    int rating;
    String ulasan;
    String paymentMethod;
    String proofTransactionBill;
    String proofItemReceived;
    String cancelReason;
    String id;
    String transactionCode;
    String user;
    List<DetailProduct> detailProducts;
    String statusTransaction;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        orderNotes: json["orderNotes"],
        admin: json["admin"],
        totalPrice: json["totalPrice"],
        totalItem: json["totalItem"],
        rating: json["rating"],
        ulasan: json["ulasan"],
        paymentMethod: json["paymentMethod"],
        proofTransactionBill: json["proofTransactionBill"],
        proofItemReceived: json["proofItemReceived"],
        cancelReason: json["cancelReason"],
        id: json["_id"],
        transactionCode: json["transactionCode"],
        user: json["user"],
        detailProducts: json["detailProducts"] == null ? [] : List<DetailProduct>.from(json["detailProducts"].map((x) => DetailProduct.fromJson(x))),
        statusTransaction: json["statusTransaction"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "orderNotes": orderNotes,
        "admin": admin,
        "totalPrice": totalPrice,
        "totalItem": totalItem,
        "rating": rating,
        "ulasan": ulasan,
        "paymentMethod": paymentMethod,
        "proofTransactionBill": proofTransactionBill,
        "proofItemReceived": proofItemReceived,
        "cancelReason": cancelReason,
        "_id": id,
        "transactionCode": transactionCode,
        "user": user,
        "detailProducts": List<dynamic>.from(detailProducts.map((x) => x.toJson())),
        "statusTransaction": statusTransaction,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class DetailProduct {
    DetailProduct({
        this.id,
        this.count,
        this.product,
        this.price,
        this.totalPrice,
    });

    String id;
    int count;
    Product product;
    int price;
    int totalPrice;

    factory DetailProduct.fromJson(Map<String, dynamic> json) => DetailProduct(
        id: json["_id"],
        count: json["count"],
        product: json["product"] != null ? Product.fromMap(json["product"]) : null,
        price: json["price"],
        totalPrice: json["totalPrice"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "count": count,
        "product": product.toMap(),
        "price": price,
        "totalPrice": totalPrice,
    };
}
