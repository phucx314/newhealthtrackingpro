import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../colors/color_set.dart';
import '../styles/box_shadow.dart';

class WaterIntake extends StatelessWidget {
  const WaterIntake({super.key});

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
                if (index < 3) {
                  // Hiển thị 3 hình A
                  return const Image(
                    image: AssetImage('assets/icons/cup_filled.png'),
                  );
                } else {
                  // Hiển thị 7 hình B
                  return const Image(
                    image: AssetImage('assets/icons/cup_empty.png'),
                  );
                }
              }, // đoạn này cần sửa lại theo logic, mới tạm thời cái fe như v đã
            ),
            const SizedBox(
              height: 15,
            ),

            // bao nhieu ml
            Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'lấy từ db ra nhưng chưa có db',
                  style: TextStyle(
                    color: htaPrimaryColors.shade500,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
