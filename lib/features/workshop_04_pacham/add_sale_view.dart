import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workshop/data/services/sale_history_service.dart';
import 'package:flutter_workshop/features/workshop_04_pacham/get_all_sale_histories_view.dart';
import 'package:intl/intl.dart';
class AddSaleView extends StatefulWidget {
  const AddSaleView({super.key});

  @override
  State<AddSaleView> createState() => _AddSaleViewState();
}
class _AddSaleViewState extends State<AddSaleView> {
  final _formKey = GlobalKey<FormState>();

  final SaleHistoryService saleHistoryService = SaleHistoryService();

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  
  final TextEditingController _saleDateController = TextEditingController(); 
  final TextEditingController _postponeDateController = TextEditingController();

  bool isOverdue = false;
  String paymentMethod = 'เงินสด';

  bool isLoading = false;

  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  DateTime? tempTodoDate;
  @override
  void initState() {
    super.initState();
    _saleDateController.text = DateTime.now().toString().split(' ')[0];
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _priceController.dispose();
    _qtyController.dispose();
    _saleDateController.dispose();
    _postponeDateController.dispose();
    super.dispose();
  }

  // ฟังก์ชันเลือกวันที่แล้วเอาค่าไปใส่ใน Controller
  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        // แปลงวันที่เป็น String แล้วยัดใส่ Controller
        controller.text = picked.toString().split(' ')[0]; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App ร้านป้าแช่ม (Controller Version)'),
      ),
      body: isLoading? 
        Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ) :
        SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. ชื่อสินค้า
              TextFormField(
                controller: _productNameController,
                decoration: const InputDecoration(
                  labelText: 'ชื่อสินค้า (Product Name)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.shopping_bag),
                ),
                validator: (value) => value!.isEmpty ? 'กรุณากรอกชื่อสินค้า' : null,
              ),
              const SizedBox(height: 16),

              // 2. ราคาสินค้า
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'ราคา (Price)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                  suffixText: 'บาท',
                ),
                validator: (value) => value!.isEmpty ? 'กรุณากรอกราคา' : null,
              ),
              const SizedBox(height: 16),

              // 3. วันที่ขาย (ใช้ Controller + ReadOnly)
              TextFormField(
                controller: _saleDateController,
                readOnly: true, // ห้ามพิมพ์เอง ต้องกดเลือก
                decoration: const InputDecoration(
                  labelText: 'วันที่ขาย (Sale Date)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () => _selectDate(context, _saleDateController),
              ),
              const SizedBox(height: 16),

              // 4. จำนวนสินค้า
              TextFormField(
                controller: _qtyController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'จำนวน (Qty)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                  suffixText: 'ชิ้น',
                ),
                validator: (value) => value!.isEmpty ? 'กรุณากรอกจำนวน' : null,
              ),
              const SizedBox(height: 16),

              // 5. ค้างชำระหรือไม่ (Switch ไม่มี Controller ใช้ State ปกติ)
              SwitchListTile(
                title: const Text('ค้างชำระหรือไม่? (isOverdue)'),
                value: isOverdue,
                onChanged: (bool value) {
                  setState(() {
                    isOverdue = value;
                    if (!value) _postponeDateController.clear(); // ถ้าไม่ค้าง ก็เคลียร์วันที่นัดจ่ายทิ้ง
                  });
                },
                secondary: const Icon(Icons.warning, color: Colors.red),
              ),

              // 6. วันที่กำหนดชำระ (แสดงเมื่อ isOverdue = true)
              if (isOverdue) ...[
                const SizedBox(height: 16),
                TextFormField(
                  controller: _postponeDateController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'วันที่กำหนดชำระ (Postpone Date)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.event_busy, color: Colors.red),
                    filled: true,
                    fillColor: Colors.pink, // สีพื้นหลังจางๆ ให้รู้ว่าสำคัญ
                  ),
                  onTap: () => _selectDate(context, _postponeDateController),
                  validator: (value) {
                    if (isOverdue && (value == null || value.isEmpty)) {
                      return 'กรุณาระบุวันที่นัดชำระ';
                    }
                    return null;
                  },
                ),
              ],

              const SizedBox(height: 20),
              const Text('วิธีการชำระเงิน', style: TextStyle(fontWeight: FontWeight.bold)),
              
              // 7. วิธีการชำระเงิน (Radio ไม่มี Controller ใช้ State ปกติ)
              RadioGroup(
                groupValue: paymentMethod,
                onChanged: (value) => setState(() => paymentMethod = value.toString()),
                child: Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: const Text('เงินสด'),
                        value: 'เงินสด',
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: const Text('สแกนจ่าย'),
                        value: 'สแกนจ่าย',
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if(!_formKey.currentState!.validate()) return;

                    try{
                      setState(() {
                        isLoading = true;
                      });

                      await saleHistoryService.createSaleHistory(
                        _productNameController.text,
                        double.parse(_priceController.text),
                        dateFormat.format(DateTime.parse(_saleDateController.text)),
                        int.parse(_qtyController.text),
                        _postponeDateController.text.isEmpty? null : dateFormat.format(DateTime.parse(_postponeDateController.text)),
                        paymentMethod,
                        isOverdue
                      );

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext buildContext){
                            return GetAllSaleHistoriesView();
                          }
                        )
                      );
                    } on DioException catch (e){
                      print(e);
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: const Text('บันทึกข้อมูล (Save)'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}