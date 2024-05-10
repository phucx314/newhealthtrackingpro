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
  List<int> waterConsumed = [0]; // Chỉ có một ly nước ban đầu

  // Hàm tính lượng nước đã uống
  double calculateWaterIntake() {
    // Tính tổng số ml nước đã uống
    return waterConsumed.reduce((value, element) => value + element).toDouble();
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
    });
  }

  // Hàm kiểm tra xem có thể chuyển đổi trạng thái của một ly nước được không
  bool canToggleWaterConsumed(int index) {
    return waterConsumed[index] == 0; // Chỉ có thể điền nước nếu ly trống
  }

  void toggleWaterConsumed(int index) {
    setState(() {
      // Kiểm tra xem ly nước có được điền nước không và không phải ly đầu tiên
      if (waterConsumed[index] != 0 && index != 0) {
        waterConsumed[index] = 0; // Rút nước ra khỏi ly
      } else if (canToggleWaterConsumed(index) && waterConsumed.length <= 20) {
        // Thêm một ly nước mới và điền nước cho ly hiện tại
        waterConsumed[index] = waterPerCup;
        // Kiểm tra nếu đã điền đủ 20 ly thì không thêm nữa
        if (waterConsumed.length < 20) {
          waterConsumed.add(0); // Thêm một ly nước mới trống
        }
      }
    });
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
            // chỉnh lượgn nước mỗi ly
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
                  '$waterPerCup ml per cup',
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
                        image: waterConsumed[index] != 0
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
