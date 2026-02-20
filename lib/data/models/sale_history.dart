// To parse this JSON data, do
//
//     final saleHistory = saleHistoryFromJson(jsonString);

import 'dart:convert';

SaleHistory saleHistoryFromJson(String str) => SaleHistory.fromJson(json.decode(str));

String saleHistoryToJson(SaleHistory data) => json.encode(data.toJson());

class SaleHistory {
    int? id;
    String? productName;
    double? price;
    DateTime? saleDate;
    int? qty;
    DateTime? postponePayDate;
    String? paymentMethod;
    bool? overdue;

    SaleHistory({
        this.id,
        this.productName,
        this.price,
        this.saleDate,
        this.qty,
        this.postponePayDate,
        this.paymentMethod,
        this.overdue,
    });

    factory SaleHistory.fromJson(Map<String, dynamic> json) => SaleHistory(
        id: json["id"],
        productName: json["productName"],
        price: json["price"],
        saleDate: DateTime.parse(json["saleDate"]),
        qty: json["qty"],
        postponePayDate: json['postponePayDate'] == null ? null : DateTime.parse(json['postponePayDate']),
        paymentMethod: json["paymentMethod"],
        overdue: json["overdue"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "productName": productName,
        "price": price,
        "saleDate": saleDate,
        "qty": qty,
        "postponePayDate": postponePayDate,
        "paymentMethod": paymentMethod,
        "overdue": overdue,
    };
}
