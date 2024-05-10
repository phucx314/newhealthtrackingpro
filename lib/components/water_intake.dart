// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../colors/color_set.dart';
import '../styles/box_shadow.dart';

class WaterIntake extends StatefulWidget {
  const WaterIntake({Key? key}) : super(key: key);

  @override
  _WaterIntakeState createState() => _WaterIntakeState();
}

class _WaterIntakeState extends State<WaterIntake> {
  int waterPerCup = 400; // Lượng nước mỗi ly, khởi tạo ban đầu là 400ml
  List<Map<String, dynamic>> waterConsumed = List.generate(10, (index) => {'filled': false, 'amount': 0});

  // Hàm tính lượng nước đã uống
  double calculateWaterIntake() {
    // Tính tổng số ml nước đã uống
    return waterConsumed.where((cup) => cup['filled']).fold(0, (sum, cup) => sum + cup['amount']);
  }

  // Hàm để cập nhật số lượng ly nước và lượng nước trong mỗi ly khi thay đổi lượng nước mỗi ly
  void updateWaterCupsCount() {
    setState(() {
      int newCupCount = (2000 ~/ waterPerCup) + 1;
      if (newCupCount > waterConsumed.length) {
        // Tăng số lượng phần tử trong danh sách waterConsumed nếu cần
        waterConsumed.addAll(List.generate(newCupCount - waterConsumed.length, (index) => {'filled': false, 'amount': 0}));
      } else if (newCupCount < waterConsumed.length) {
        // Giảm số lượng phần tử trong danh sách waterConsumed nếu cần
        waterConsumed.removeRange(newCupCount, waterConsumed.length);
      }
    });
  }

  // Hàm để tăng lượng nước mỗi ly
  void increaseWaterPerCup() {
    setState(() {
      // Tăng lượng nước mỗi ly lên 50ml
      waterPerCup += 50;
      // Giới hạn giá trị lượng nước mỗi ly từ 100ml đến 500ml
      if (waterPerCup > 500) {
        waterPerCup = 500;
      }
      // Cập nhật số lượng ly nước và lượng nước trong mỗi ly
      updateWaterCupsCount();
    });
  }

  // Hàm để giảm lượng nước mỗi ly
  void decreaseWaterPerCup() {
    setState(() {
      // Giảm lượng nước mỗi ly đi 50ml
      waterPerCup -= 50;
      // Giới hạn giá trị lượng nước mỗi ly từ 100ml đến 500ml
      if (waterPerCup < 100) {
        waterPerCup = 100;
      }
      // Cập nhật số lượng ly nước và lượng nước trong mỗi ly
      updateWaterCupsCount();
    });
  }

  // Hàm để điều chỉnh lượng nước trong mỗi ly đã được điền khi thay đổi lượng nước mỗi ly
  void adjustFilledCupAmount() {
    setState(() {
      waterConsumed.forEach((cup) {
        if (cup['filled']) {
          cup['amount'] = waterPerCup;
        }
      });
    });
  }

  // Hàm kiểm tra xem có thể chuyển đổi trạng thái của một ly nước được không
  bool canToggleWaterConsumed(int index) {
    if (index == 0) {
      // Nếu là ly nước đầu tiên, chỉ cần kiểm tra ly kế tiếp
      return !waterConsumed[index + 1]['filled'];
    } else if (index == waterConsumed.length - 1) {
      // Nếu là ly nước cuối cùng, chỉ cần kiểm tra ly trước đó
      return waterConsumed[index - 1]['filled'];
    } else {
      // Kiểm tra ly trước và ly sau
      return waterConsumed[index - 1]['filled'] && !waterConsumed[index + 1]['filled'];
    }
  }

  void toggleWaterConsumed(int index) {
    if (canToggleWaterConsumed(index)) {
      setState(() {
        waterConsumed[index]['filled'] = !waterConsumed[index]['filled'];
        if (waterConsumed[index]['filled']) {
          // Nếu điền nước vào ly, điều chỉnh lượng nước trong ly này
          waterConsumed[index]['amount'] = waterPerCup;
        }
      });
    }
  }

  // Getter để lấy lượng nước mỗi ly
  int getWaterPerCup() {
    return waterPerCup;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        decoration: BoxDecoration(
          color: htaPrimaryColors.shade50,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [shadow],
        ),
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            // chỉnh lượng nước mỗi ly
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // dấu trừ
                GestureDetector(
                  onTap: () {
                    decreaseWaterPerCup();
                  },
                  child: Image(image: AssetImage('assets/icons/btn_minus.png'), height: 60, width: 60,),
                ),

                // lượng nước mỗi ly
                Text(
                  '${getWaterPerCup()} ml per cup',
                  style: TextStyle(color: htaPrimaryColors.shade500,),
                ),

                // dấu cộng
                GestureDetector(
                  onTap: () {
                    increaseWaterPerCup();
                  },
                  child: Image(image: AssetImage('assets/icons/btn_plus.png'), height: 60, width: 60,),
                ),
              ],
            ),
            SizedBox(height: 15,),
            // mấy cái ly
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Ngăn chặn cuộn
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: waterConsumed.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    toggleWaterConsumed(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Image(
                        image: waterConsumed[index]['filled']
                            ? AssetImage('assets/icons/cup_filled.png')
                            : AssetImage('assets/icons/cup_empty.png'),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 15,
            ),
            // Hiển thị lượng nước đã uống
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${calculateWaterIntake()}/2000 ml',
                style: TextStyle(
                  color: htaPrimaryColors.shade500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
