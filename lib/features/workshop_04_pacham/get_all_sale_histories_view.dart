import 'package:flutter/material.dart';

class GetAllSaleHistoriesView extends StatefulWidget {
  const GetAllSaleHistoriesView({super.key});

  @override
  State<GetAllSaleHistoriesView> createState() => _GetAllSaleHistoriesViewState();
}

class _GetAllSaleHistoriesViewState extends State<GetAllSaleHistoriesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App ร้านป้าแช่ม (Controller Version)'),
      ),
    );
  }
}