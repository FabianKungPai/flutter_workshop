import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workshop/data/models/sale_history.dart';
import 'package:flutter_workshop/data/services/sale_history_service.dart';
import 'package:flutter_workshop/features/workshop_04_pacham/add_sale_view.dart';
import 'package:flutter_workshop/features/workshop_04_pacham/view_sale_history_detail_view.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddSaleView(),
            ),
          ).then((_) => fetchAll());
        },
        child: const Icon(Icons.add),
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
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext buildContext) {
                      return ViewSaleHistoryDetailView(id: saleHistory.id!);
                    })
                );
              },
              title:  Text("${saleHistory.productName} x (${saleHistory.qty})"),
              trailing: Text("${saleHistory.price! * saleHistory.qty!}"),
            ),
          );
        },
      ),
    );
  }
}