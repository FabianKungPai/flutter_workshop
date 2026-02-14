import 'package:flutter_workshop/core/network/dio_client.dart';

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
  
}