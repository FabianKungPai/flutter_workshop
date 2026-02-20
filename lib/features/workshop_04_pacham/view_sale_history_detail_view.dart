import 'package:flutter/material.dart';

class ViewSaleHistoryDetailView extends StatefulWidget {
  final int id;

  const ViewSaleHistoryDetailView({super.key, required this.id});

  @override
  State<ViewSaleHistoryDetailView> createState() => _ViewSaleHistoryDetailViewState();
}

class _ViewSaleHistoryDetailViewState extends State<ViewSaleHistoryDetailView> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("${widget.id}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View History Detail'),
        backgroundColor: Colors.blue,
      ),
      body: Column(children: [
        Text("${widget.id}"),
        Text("สินค้าที่ขาย")
      ],) 
    );
  }
}