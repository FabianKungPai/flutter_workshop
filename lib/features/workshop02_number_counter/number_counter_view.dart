import 'package:flutter/material.dart';

class NumberCounterView extends StatefulWidget {
  const NumberCounterView({super.key});

  @override
  State<NumberCounterView> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NumberCounterView> {
  int countNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Number counter"),
        backgroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          Text("นับถึง $countNumber แล้ว"),
          ElevatedButton(onPressed: () {
            setState(() {
              countNumber++;
            });
          }, 
          child: Text("เพิ่ม")
          ),
        ],
      ),
    );
  }
}
