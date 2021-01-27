import 'dart:convert';

ReportResponse reportResponseFromMap(String str) => ReportResponse.fromMap(json.decode(str));

String reportResponseToMap(ReportResponse data) => json.encode(data.toMap());

class ReportResponse {
    ReportResponse({
        this.myReport,
        this.totalData,
        this.fromDate,
        this.toDate,
    });

    List<MyReport> myReport;
    int totalData;
    DateTime fromDate;
    DateTime toDate;

    factory ReportResponse.fromMap(Map<String, dynamic> json) => ReportResponse(
        myReport: List<MyReport>.from(json["myReport"].map((x) => MyReport.fromMap(x))),
        totalData: json["totalData"],
        fromDate: DateTime.parse(json["fromDate"]),
        toDate: DateTime.parse(json["toDate"]),
    );

    Map<String, dynamic> toMap() => {
        "myReport": List<dynamic>.from(myReport.map((x) => x.toMap())),
        "totalData": totalData,
        "fromDate": fromDate.toIso8601String(),
        "toDate": toDate.toIso8601String(),
    };
}

class MyReport {
    MyReport({
        this.id,
        this.stock,
        this.sellPrice,
        this.images,
        this.name,
        this.merkProduct,
        this.buyPrice,
        this.totalDone,
        this.totalDibatalkan,
        this.totalPendapatan,
    });

    String id;
    int stock;
    int sellPrice;
    List<String> images;
    String name;
    String merkProduct;
    int buyPrice;
    int totalDone;
    int totalDibatalkan;
    int totalPendapatan;

    factory MyReport.fromMap(Map<String, dynamic> json) => MyReport(
        id: json["_id"],
        stock: json["stock"],
        sellPrice: json["sellPrice"],
        images: List<String>.from(json["images"].map((x) => x)),
        name: json["name"],
        merkProduct: json["merkProduct"],
        buyPrice: json["buyPrice"],
        totalDone: json["totalDone"],
        totalDibatalkan: json["totalDibatalkan"],
        totalPendapatan: json["totalPendapatan"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "stock": stock,
        "sellPrice": sellPrice,
        "images": List<dynamic>.from(images.map((x) => x)),
        "name": name,
        "merkProduct": merkProduct,
        "buyPrice": buyPrice,
        "totalDone": totalDone,
        "totalDibatalkan": totalDibatalkan,
        "totalPendapatan": totalPendapatan,
    };
}
