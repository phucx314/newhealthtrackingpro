import 'package:app3/components/bottomsheet_water_consumed_history.dart';
import 'package:app3/components/mybutton.dart';
import 'package:app3/pages/water_history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../colors/color_set.dart';
import '../services/firestore.dart';
import '../styles/box_shadow.dart';

class WaterIntake extends StatefulWidget {
  const WaterIntake({super.key});

  @override
  _WaterIntakeState createState() => _WaterIntakeState();
}

class _WaterIntakeState extends State<WaterIntake> {
  int waterPerCup = 200; // Lượng nước mỗi ly, khởi tạo ban đầu là 200ml
  List<int> waterConsumed = [0]; // Chỉ có một ly nước ban đầu

  final FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    // Gọi phương thức để đọc dữ liệu từ Firestore khi ứng dụng được khởi động
    _fetchWaterConsumedData();
  }

  // Phương thức để đọc dữ liệu từ Firestore và cập nhật trạng thái của ứng dụng
  Future<void> _fetchWaterConsumedData() async {
    String? uid = await firestoreService.getCurrentUserUID();
    if (uid != null) {
      bool hasData = await firestoreService.hasWaterConsumedData(uid);
      List<int> waterData;

      if (hasData) {
        waterData = await firestoreService.getWaterConsumedData(uid);
        // get được mấy ly nước đầy rồi thì add thêm ly nước trống phía sau
        waterData.add(0);
      } else {
        // Khởi tạo danh sách với các giá trị mặc định (0)
        waterData = [0];
      }

      setState(() {
        waterConsumed = waterData;
      });
    } else {
      // Xử lý khi không thể lấy được UID
    }
  }



  // Hàm tính lượng nước đã uống
  int calculateWaterIntake() {
    // Tính tổng số ml nước đã uống
    return waterConsumed.reduce((value, element) => value + element).toInt();
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

  void toggleWaterConsumed(int index) {
    setState(() {
      // Kiểm tra xem số lượng ly nước đã uống đã đạt giới hạn 25 hay chưa
      if (waterConsumed.length <= 25) {
        bool canChangeState = true;

        // Kiểm tra xem ly tiếp theo của ly được chọn là ly rỗng hay ly đã được uống
        bool nextIsFilled =
            index + 1 < waterConsumed.length && waterConsumed[index + 1] != 0;

        // Nếu ly tiếp theo là ly đã được uống, ly được chọn không thể thay đổi trạng thái
        if (nextIsFilled) {
          canChangeState = false;
        }

        // Nếu ly được chọn không thể thay đổi trạng thái, không cần kiểm tra và thực hiện gán trạng thái mới
        if (canChangeState) {
          // Đảm bảo chỉ có một ly được chọn là ly filled mới nhất
          bool hasFilled = false;

          for (int i = 0; i < waterConsumed.length; i++) {
            if (i == index) {
              break;
            }

            if (waterConsumed[i] != 0) {
              hasFilled = true;
            } else if (hasFilled) {
              canChangeState = false;
              break;
            }
          }

          // Nếu có thể thay đổi trạng thái của ly được chọn
          if (canChangeState) {
            if (waterConsumed[index] == 0) {
              waterConsumed[index] = waterPerCup;
              // Thêm một ly rỗng mới bên cạnh nếu chưa đạt giới hạn
              if (waterConsumed.length < 25) {
                waterConsumed.insert(index + 1, 0);
              }
              // Thêm dữ liệu mới vào Firestore
              _addCupToFirestore(index.toString());
            } else {
              waterConsumed[index] = 0;
              // Nếu có một ly rỗng mới bên cạnh ly được chọn thì xóa nó đi
              if (index + 1 < waterConsumed.length &&
                  waterConsumed[index + 1] == 0) {
                waterConsumed.removeAt(index + 1);
                firestoreService.deleteCup(index.toString());
              }
            }
          }
        }
      }
    });
  }

  Future<void> _addCupToFirestore(String cupID) async {
    String? uid = await firestoreService.getCurrentUserUID();
    if (uid != null) {
      await firestoreService.addCup(
        cupID,
        waterPerCup,
        DateTime.now().toString(),
        uid,
      );
      setState(() {}); // Gọi setState để cập nhật UI
    } else {
      // Xử lý khi không thể lấy được UID
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
            // chỉnh lượgn nước mỗi ly
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // dấu trừ
                GestureDetector(
                  onTap: () {
                    decreaseWaterPerCup();
                  },
                  child: const Image(
                    image: AssetImage('assets/icons/btn_minus.png'),
                    height: 60,
                    width: 60,
                  ),
                ),

                // lượng nước mỗi ly
                Text(
                  '$waterPerCup ml per cup',
                  style: TextStyle(
                    color: htaPrimaryColors.shade500,
                  ),
                ),

                // dấu cộng
                GestureDetector(
                  onTap: () {
                    increaseWaterPerCup();
                  },
                  child: const Image(
                    image: AssetImage('assets/icons/btn_plus.png'),
                    height: 60,
                    width: 60,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            // mấy cái ly
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // Ngăn chặn cuộn
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: waterConsumed.length, // Số lượng mục muốn hiển thị theo độ dài của waterConsumed
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
                            ? const AssetImage('assets/icons/cup_filled.png')
                            : const AssetImage('assets/icons/cup_empty.png'),
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
                  color: (calculateWaterIntake() >= 2000)
                      ? htaStatusColors.shade200
                      : htaStatusColors.shade900,
                ),
              ),
            ),
            SizedBox(height: 15,),

            // nut hien lich su uong nuoc
            Align(
              alignment: Alignment.centerRight,
              child: Button(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WaterHistory()),
                  );
                }, 
                title: 'Show history',
                height: 40,
                width: 120,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
