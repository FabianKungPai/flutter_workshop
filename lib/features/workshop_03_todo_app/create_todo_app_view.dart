import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateTodoAppView extends StatefulWidget {
  const CreateTodoAppView({super.key});

  @override
  State<CreateTodoAppView> createState() => _CreateTodoAppViewState();
}

class _CreateTodoAppViewState extends State<CreateTodoAppView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final TextEditingController todoNameController;
  late final TextEditingController expenseController;
  late final TextEditingController todoDateController;
  bool hasExpense = false;

  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  DateTime? tempTodoDate;

  int priority = 1;

  @override
  void initState() {
    super.initState();
    todoNameController = TextEditingController();
    expenseController = TextEditingController();
    todoDateController = TextEditingController();
  }

  @override
  void dispose() {
    todoNameController.dispose();
    expenseController.dispose();
    todoDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo App"), backgroundColor: Colors.grey),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  "สร้าง Todo",
                  style: TextStyle(
                    fontFamily: 'ChakraPetch',
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: todoNameController,
                  decoration: InputDecoration(
                    labelText: "สิ่งที่จะทำ",
                    labelStyle: TextStyle(fontFamily: 'ChakraPetch'),
                    hintText: "กรอกสิ่งที่จะทำ",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.edit),
                    prefixIconColor: Colors.blue,
                  ),
                  style: TextStyle(fontFamily: 'ChakraPetch'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "กรุณากรอกสิ่งที่จะทำ";
                    }
                  },
                ),
                Row(
                  children: [
                    Checkbox(
                      value: hasExpense,
                      onChanged: (value) {
                        setState(() {
                          hasExpense = value!;
                          if (value! == true &&
                              expenseController.text.isNotEmpty) {
                            expenseController.text = '';
                          }
                        });
                      },
                    ),
                    Text("มีค่าใช้จ่าย?"),
                  ],
                ),
                if (hasExpense) ...[
                  TextFormField(
                    controller: expenseController,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      labelText: "ค่าใช้จ่ายโดยประมาณ",
                      labelStyle: TextStyle(fontFamily: 'ChakraPetch'),
                      hintText: "กรอกค่าใช้จ่าย",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.monetization_on),
                      prefixIconColor: Colors.blue,
                    ),
                    style: TextStyle(fontFamily: 'ChakraPetch'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "กรุณากรอกค่าใช้จ่าย";
                      }
                    },
                  ),
                ],
                SizedBox(height: 10),
                TextFormField(
                  controller: todoDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "วันที่จะทำ",
                    labelStyle: TextStyle(fontFamily: 'ChakraPetch'),
                    hintText: "กรอกวันที่จะทำ",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.calendar_month),
                    prefixIconColor: Colors.blue,
                  ),
                  style: TextStyle(fontFamily: 'ChakraPetch'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "กรุณากรอกวันที่จะทำ";
                    }
                  },
                  onTap: () async {
                    tempTodoDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)),
                    );

                    if (tempTodoDate != null) {
                      todoDateController.text = dateFormat.format(
                        tempTodoDate!,
                      );
                    }
                  },
                ),
                SizedBox(height: 10),
                RadioGroup(
                  groupValue: priority,
                  onChanged: (value) {
                    setState(() {
                      priority = value!;
                    });
                  },
                  child: Column(
                    children: [
                      Row(children: [Radio(value: 1), Text("สำคัญน้อย")]),
                      Row(children: [Radio(value: 2), Text("สำคัญกลาง")]),
                      Row(children: [Radio(value: 3), Text("สำคัญมาก")]),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      print("สิ่งที่จะทำคือ ${todoNameController.text}");
                      print("มีค่าใช้จ่ายไหม $hasExpense");

                      if (hasExpense) {
                        print("มีค่าใช้จ่ายเท่ากับ ${expenseController.text}");
                      }

                      print("วันที่จะทำคือ ${todoDateController.text}");
                      print("ระดับความสำคัญ $priority");
                    }
                  },
                  child: Text("เพิ่ม Todo"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
