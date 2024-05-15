import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../colors/color_set.dart';
import '../styles/box_shadow.dart';

class ChartHolder extends StatelessWidget {
  ChartHolder({super.key, required this.consumedValue, required this.burnedValue});

  final double consumedValue;
  final double burnedValue;
  
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
        padding: const EdgeInsets.all(15),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Calories
            const Text(
              'Calories',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            // pie charts
            SizedBox(
              height: 110, // Đã sửa lại từ 1110
              child: Row(
                children: [
                  // chỗ này là số kcal đã hấp thụ
                  Expanded(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        // số
                        Text(
                          '2000',
                          style: TextStyle(
                            color: htaPrimaryColors.shade500,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        // chữ
                        Text(
                          'kcal consumed',
                          style: TextStyle(
                            color: htaPrimaryColors.shade500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // chỗ này là cái pie chart remaining kcal
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 110 -
                              10, // Chiều cao cố định - đi radius
                          width: 110 -
                              10, // Chiều rộng cố định - đi radius
                          child: PieChart(
                            PieChartData(
                              sections: [
                                PieChartSectionData(
                                  color: htaPrimaryColors
                                      .shade100,
                                  value: consumedValue,
                                  radius: 10,
                                  title: '',
                                ),
                                PieChartSectionData(
                                  color: htaPrimaryColors
                                      .shade500,
                                  value: burnedValue,
                                  title: '',
                                  radius: 10,
                                ),
                              ],
                              sectionsSpace: 0,
                              centerSpaceRadius: 35,
                            ),
                          ),
                        ),

                        // số
                        Text(
                          textAlign: TextAlign.center,
                          '${(consumedValue-burnedValue).truncate()}' '\nremaining',
                          style: TextStyle(
                            color: htaPrimaryColors.shade500,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // chỗ này là số kcal đã đốt
                  Expanded(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        // số
                        Text(
                          '500',
                          style: TextStyle(
                            color: htaPrimaryColors.shade500,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        // chữ
                        Text(
                          'kcal burned',
                          style: TextStyle(
                            color: htaPrimaryColors.shade500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            
            // sleep
            const Text(
              'Sleep',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            // chỗ này là cái sleep stats bar chart
            Container(
              height: 120, // Đã sửa lại từ 120
            )
            // nút xem chi tiết
          ],
        ),
      ),
    );
  }
}