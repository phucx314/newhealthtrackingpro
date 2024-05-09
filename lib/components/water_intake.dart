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
  List<bool> waterConsumed = List.generate(10, (index) => false);

  // Hàm tính lượng nước đã uống
  double calculateWaterIntake() {
    // Mỗi ly nước đã đầy tương ứng với 250ml nước
    int filledCupsCount = waterConsumed.where((filled) => filled).length;
    return filledCupsCount * 250.0; // Tính tổng số ml nước đã uống
  }

  // Hàm kiểm tra xem có thể chuyển đổi trạng thái của một ly nước được không
  bool canToggleWaterConsumed(int index) {
    if (index == 0) {
      // Nếu là ly nước đầu tiên, chỉ cần kiểm tra ly kế tiếp
      return !waterConsumed[index + 1];
    } else if (index == waterConsumed.length - 1) {
      // Nếu là ly nước cuối cùng, chỉ cần kiểm tra ly trước đó
      return waterConsumed[index - 1];
    } else {
      // Kiểm tra ly trước và ly sau
      return waterConsumed[index - 1] && !waterConsumed[index + 1];
    }
  }

  void toggleWaterConsumed(int index) {
    if (canToggleWaterConsumed(index)) {
      setState(() {
        waterConsumed[index] = !waterConsumed[index];
      });
    }
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
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 10, // Số lượng mục muốn hiển thị
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
                        image: waterConsumed[index]
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
                '${calculateWaterIntake()}/xxxx ml',
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
