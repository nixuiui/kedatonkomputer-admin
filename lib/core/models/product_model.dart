import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kedatonkomputer/core/models/category_model.dart';

ProductResponseModel productResponseModelFromMap(String str) => ProductResponseModel.fromMap(json.decode(str));

String productResponseModelToMap(ProductResponseModel data) => json.encode(data.toMap());

Product productFromMap(String str) => Product.fromMap(json.decode(str));

String productToMap(Product data) => json.encode(data.toMap());

class ProductResponseModel {
    ProductResponseModel({
        this.product,
        this.totalProduct,
        this.totalPages,
        this.totalAllProduct,
        this.currentPage,
        this.limit,
    });

    List<Product> product;
    int totalProduct;
    int totalPages;
    int totalAllProduct;
    int currentPage;
    int limit;

    factory ProductResponseModel.fromMap(Map<String, dynamic> json) => ProductResponseModel(
        product: json["product"] != null ? List<Product>.from(json["product"].map((x) => Product.fromMap(x))) : [],
        totalProduct: json["totalProduct"],
        totalPages: json["totalPages"],
        totalAllProduct: json["totalAllProduct"],
        currentPage: json["currentPage"],
        limit: json["limit"],
    );

    Map<String, dynamic> toMap() => {
        "product": List<dynamic>.from(product.map((x) => x.toMap())),
        "totalProduct": totalProduct,
        "totalPages": totalPages,
        "totalAllProduct": totalAllProduct,
        "currentPage": currentPage,
        "limit": limit,
    };
}

class Product {
    Product({
        this.stock,
        this.sellPrice,
        this.description,
        this.images,
        this.isDeleted,
        this.id,
        this.name,
        this.merkProduct,
        this.buyPrice,
        this.category,
        this.createdAt,
        this.updatedAt,
    });

    int stock;
    int sellPrice;
    String description;
    List<String> images;
    bool isDeleted;
    String id;
    String name;
    String merkProduct;
    int buyPrice;
    Category category;
    DateTime createdAt;
    DateTime updatedAt;

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        stock: json["stock"] ?? 0,
        sellPrice: json["sellPrice"] ?? 0,
        description: json["description"] ?? "",
        images: json["images"] != null ? List<String>.from(json["images"].map((x) => x)) : [],
        isDeleted: json["isDeleted"] ?? false,
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        merkProduct: json["merkProduct"] ?? "",
        buyPrice: json["buyPrice"] ?? 0,
        category: json["category"] != null ? Category.fromMap(json["category"]) : null,
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
    );

    Map<String, dynamic> toMap() => {
        "stock": stock,
        "sellPrice": sellPrice,
        "description": description,
        // "images": List<dynamic>.from(images.map((x) => x)),
        "isDeleted": isDeleted,
        "_id": id,
        "name": name,
        "merkProduct": merkProduct,
        "buyPrice": buyPrice,
        // "category": category.toMap(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class ProductPost {
    ProductPost({
        this.id,
        this.photo,
        this.name,
        this.merkProduct,
        this.buyPrice,
        this.sellPrice,
        this.description,
        this.category,
        this.stock,
    });

    String id;
    List<MultipartFile> photo;
    String name;
    String merkProduct;
    String buyPrice;
    String sellPrice;
    String description;
    String category;
    String stock;

    Map<String, dynamic> toMap() => {
        "id": id,
        "photo": photo,
        "name": name,
        "merkProduct": merkProduct,
        "buyPrice": buyPrice,
        "sellPrice": sellPrice,
        "description": description,
        "category": category,
        "stock": stock,
    };
}
