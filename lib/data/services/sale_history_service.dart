import 'package:flutter_workshop/core/network/dio_client.dart';
import 'package:flutter_workshop/data/models/sale_history.dart';

class SaleHistoryService {
  Future<void> createSaleHistory (
    String productName,
    double price,
    String saleDate,
    int qty,
    String? postponePayDate,
    String paymentMethod,
    bool overdue
  ) async {
    try {
      await DioClient.dio.post(
     "/v1/sale-histories",
     data: {
      "productName" : productName,
      "price" : price,
      "saleDate" : saleDate,
      "qty" : qty,
      "postponePayDate" : postponePayDate,
      "paymentMethod" : paymentMethod,
      "isOverdue" : overdue
     } 
    );
    } catch (e) {
      rethrow; // throw Excaption
    }
  }

  Future<List<SaleHistory>> GetAllSaleHistories() async {
    try {
      var response = await DioClient.dio.get("/v1/sale-histories");
      return (response.data["result"] as List).map((item) => SaleHistory.fromJson(item)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<SaleHistory> GetSaleHistoryById(int id) async {
    try {
      var response = await DioClient.dio.get("/v1/sale-histories/$id");
      return SaleHistory.fromJson(response.data["result"]);
    } catch (e) {
      rethrow;
    }
  }
}