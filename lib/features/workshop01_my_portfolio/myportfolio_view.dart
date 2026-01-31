import 'package:flutter/material.dart';

class MyportfolioView extends StatelessWidget {
  const MyportfolioView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Portfolio"), backgroundColor: Colors.red),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                SizedBox(height: 20),
                Text("Portfolio ของฉัน"),
                SizedBox(height: 20),
                SizedBox(
                  width: 400,
                  height: 400,
                  child: Image.asset("assets/images/me.png"),
                ),
                SizedBox(height: 10),
                Text(
                  "นายสันติ เบ็กเคอร์",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    fontFamily: 'ChakraPetch',
                  ),
                ),
                Text(
                  "อายุ 21 ปี",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    fontFamily: 'ChakraPetch',
                  ),
                ),
                Text(
                  "Software Engineer at Google Company",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    fontFamily: 'ChakraPetch',
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: .centerLeft,
                  child: Text(
                    "ประวัติส่วนตัว",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      fontFamily: 'ChakraPetch',
                    ),
                  ),
                ),
                Text(
                  "Lorem ipsum dolor sit amet consectetur adipiscing elit. Consectetur adipiscing elit quisque faucibus ex sapien vitae. Ex sapien vitae pellentesque sem placerat in id. Placerat in id cursus mi pretium tellus duis. Pretium tellus duis convallis tempus leo eu aenean.",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    fontFamily: 'ChakraPetch',
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    fontFamily: 'ChakraPetch',
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: .centerLeft,
                  child: Text(
                    "ประวัติการศึกษา",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      fontFamily: 'ChakraPetch',
                    ),
                  ),
                ),
                Card(
                  child: Row(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset("assets/images/ปว.jpg"),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            "โรงเรียนปายวิทยาคาร",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              fontFamily: 'ChakraPetch',
                            ),
                          ),
                          Text(
                            "มัธยมศึกษาปีที่ 1 - มัธยมศึกษาปีที่ 6",
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                              fontFamily: 'ChakraPetch',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: .centerLeft,
                  child: Text(
                    "Skill ภาษา Programming",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      fontFamily: 'ChakraPetch',
                    ),
                  ),
                ),
                Row(children: [
                  Expanded(
                    child: Text("1. Go")
                  ),
                  Expanded(child: Text("Fiber")),
                  Expanded(child: Text("Low"))
                ]),
                Row(children: [
                  Expanded(
                    child: Text("2. Java")
                  ),
                  Expanded(child: Text("Spring boot")),
                  Expanded(child: Text("Medium"))
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
