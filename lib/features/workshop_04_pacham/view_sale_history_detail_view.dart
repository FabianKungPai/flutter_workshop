import 'package:flutter/material.dart';
// อย่าลืมเช็ค path ของ import สองบรรทัดนี้ให้ตรงกับโปรเจกต์ของนายด้วยนะ
import '../../data/models/sale_history.dart'; 
import '../../data/services/sale_history_service.dart';

class ViewSaleHistoryDetailView extends StatefulWidget {
  final int id;

  const ViewSaleHistoryDetailView({super.key, required this.id});

  @override
  State<ViewSaleHistoryDetailView> createState() => _ViewSaleHistoryDetailViewState();
}

class _ViewSaleHistoryDetailViewState extends State<ViewSaleHistoryDetailView> {
  // 1. เปลี่ยนมาใช้ Model SaleHistory แทนตัวแปร Map
  SaleHistory? saleDetail;
  bool isLoading = true;
  String? errorMessage; // เจมส์เผื่อตัวแปรนี้ไว้เก็บข้อความ error ตอน API มีปัญหา

  // 2. เรียกใช้งาน Service ของนาย
  final SaleHistoryService _saleHistoryService = SaleHistoryService();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // โยน id เข้าไปในฟังก์ชันของ Service ได้เลย มันจะคืนค่าเป็น Model SaleHistory กลับมา
      final data = await _saleHistoryService.GetSaleHistoryById(widget.id);
      
      setState(() {
        saleDetail = data;
        isLoading = false;
      });
    } catch (e) {
      // ดักจับ error เผื่อเน็ตหลุดหรือหา id ไม่เจอ หน้าแอปจะได้ไม่ค้าง
      setState(() {
        errorMessage = "ดึงข้อมูลไม่สำเร็จ: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View History Detail'),
        backgroundColor: Colors.blue,
      ),
      // 3. เช็คสถานะแล้วเอาข้อมูลมาโชว์
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) 
          : errorMessage != null
              ? Center(child: Text(errorMessage!, style: const TextStyle(color: Colors.red)))
              : saleDetail == null
                  ? const Center(child: Text("ไม่พบข้อมูลสินค้านี้"))
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ดึงค่าจาก Model (saleDetail) มาแสดงได้เลย พิมพ์ง่ายกว่าเดิมเยอะ
                          Text("รหัสการขาย: ${saleDetail!.id}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text("สินค้าที่ขาย: ${saleDetail!.productName}"),
                          Text("ราคา: ${saleDetail!.price} บาท"),
                          // saleDate เป็น DateTime เจมส์เลยใช้ .toString().split(' ')[0] เพื่อตัดเอาแค่วันที่ (YYYY-MM-DD)
                          Text("วันที่ขาย: ${saleDetail!.saleDate?.toString().split(' ')[0] ?? '-'}"),
                          Text("จำนวน: ${saleDetail!.qty} ชิ้น"),
                          Text("วันที่กำหนดชำระภายหลัง: ${saleDetail!.postponePayDate?.toString().split(' ')[0] ?? '-'}"),
                          Text("วิธีจ่ายเงิน: ${saleDetail!.paymentMethod}"),
                          Text("ค้างจ่าย?: ${saleDetail!.overdue == true ? 'ใช่' : 'ไม่ค้าง'}"),
                        ],
                      ),
                    ),
    );
  }
}