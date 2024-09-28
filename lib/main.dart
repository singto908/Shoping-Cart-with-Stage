import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // สำหรับการแสดงราคาพร้อมเครื่องหมายคอมม่า

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iPad Shopping Cart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShoppingCart(),
    );
  }
}

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  // จำนวนสินค้าแต่ละชนิด
  int iPadQuantity = 0;
  int iPadMiniQuantity = 0;
  int iPadAirQuantity = 0;
  int iPadProQuantity = 0;

  // ราคาต่อชิ้นของสินค้าแต่ละชนิด
  double iPadPrice = 19000;
  double iPadMiniPrice = 23000;
  double iPadAirPrice = 29000;
  double iPadProPrice = 39000;

  // ฟังก์ชันคำนวณราคารวมทั้งหมด
  double getTotalPrice() {
    return (iPadQuantity * iPadPrice) +
        (iPadMiniQuantity * iPadMiniPrice) +
        (iPadAirQuantity * iPadAirPrice) +
        (iPadProQuantity * iPadProPrice);
  }

  // ฟังก์ชันสำหรับแสดงผลราคาแบบมีคอมม่า
  String formatPrice(double price) {
    final formatter = NumberFormat("#,##0", "en_US");
    return formatter.format(price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('iPad Shopping Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildProductRow(
                  'iPad', iPadQuantity, iPadPrice, 'assets/images/ipad.png',
                  (isIncrement) {
                setState(() {
                  if (isIncrement) {
                    iPadQuantity++;
                  } else if (iPadQuantity > 0) {
                    iPadQuantity--;
                  }
                });
              }),
              buildProductRow('iPad mini', iPadMiniQuantity, iPadMiniPrice,
                  'assets/images/ipad_mini.png', (isIncrement) {
                setState(() {
                  if (isIncrement) {
                    iPadMiniQuantity++;
                  } else if (iPadMiniQuantity > 0) {
                    iPadMiniQuantity--;
                  }
                });
              }),
              buildProductRow('iPad Air', iPadAirQuantity, iPadAirPrice,
                  'assets/images/ipad_air.png', (isIncrement) {
                setState(() {
                  if (isIncrement) {
                    iPadAirQuantity++;
                  } else if (iPadAirQuantity > 0) {
                    iPadAirQuantity--;
                  }
                });
              }),
              buildProductRow('iPad Pro', iPadProQuantity, iPadProPrice,
                  'assets/images/ipad_pro.png', (isIncrement) {
                setState(() {
                  if (isIncrement) {
                    iPadProQuantity++;
                  } else if (iPadProQuantity > 0) {
                    iPadProQuantity--;
                  }
                });
              }),
              SizedBox(height: 20),
              Text(
                'ราคารวม: ${formatPrice(getTotalPrice())} บาท',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    iPadQuantity = 0;
                    iPadMiniQuantity = 0;
                    iPadAirQuantity = 0;
                    iPadProQuantity = 0;
                  });
                },
                child: Text('Clear'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.red, // ใช้ backgroundColor แทน primary
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // สร้างแถวสำหรับสินค้าแต่ละชนิด รวมทั้งรูปภาพ
  Widget buildProductRow(String name, int quantity, double price,
      String imagePath, Function(bool) onQuantityChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            imagePath,
            width: 50,
            height: 50,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              '$name: ${formatPrice(price)} บาท/ชิ้น',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  onQuantityChanged(false);
                },
                child: Icon(Icons.remove),
              ),
              SizedBox(width: 8),
              Text(
                '$quantity',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  onQuantityChanged(true);
                },
                child: Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
