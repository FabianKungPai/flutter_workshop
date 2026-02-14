import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workshop/data/models/sale_history.dart';
import 'package:flutter_workshop/data/services/sale_history_service.dart';

class GetAllSaleHistoriesView extends StatefulWidget {
  const GetAllSaleHistoriesView({super.key});

  @override
  State<GetAllSaleHistoriesView> createState() => _GetAllSaleHistoriesViewState();
}

class _GetAllSaleHistoriesViewState extends State<GetAllSaleHistoriesView> {

  final SaleHistoryService saleHistoryService = SaleHistoryService();

  List<SaleHistory> saleHistories = [];
  bool isLoading = false;

  void fetchAll () async {
    try {
      setState(() {
        isLoading = true;
      });
      var saleHistoriesResponse = await saleHistoryService.GetAllSaleHistories();
      //await Future.delayed(Duration(seconds: 2));
      setState(() {
        saleHistories = saleHistoriesResponse;
      });
    } on DioException catch (e) {
      print(e);
    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get all sale histories'),
        backgroundColor: Colors.blue,
      ),
      body: isLoading? 
        Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ) : 
        ListView.builder(
        itemCount: saleHistories.length,
        itemBuilder: (context, index){
          var saleHistory = saleHistories[index];
          return Card(
            child: ListTile(
              title:  Text("${saleHistory.productName} x (${saleHistory.qty})"),
              trailing: Text("${saleHistory.price! * saleHistory.qty!}"),
            ),
          );
        },
      ),
    );
  }
}