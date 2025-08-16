import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/controllers/category_controller.dart';
import 'package:flutter_application_2/controllers/expense_controller.dart';
import 'package:get/get.dart';

class PieChartDisplay extends StatelessWidget {
  PieChartDisplay({super.key});

  final categoryController = Get.find<CategoryController>();
  final expenseController = Get.find<ExpenseController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      width: 405,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(255, 255, 255, 0.2),
      ),
      child: Center(
        child: Obx(() {
          final totals = categoryController.categoryTotals;
          final colorList = [
            Colors.blue,
            Colors.greenAccent,
            Colors.orangeAccent,
            Colors.deepOrangeAccent,
            Colors.deepPurpleAccent,
            Colors.cyanAccent,
            Colors.tealAccent,
            Colors.amberAccent,
            Colors.indigoAccent,
            Colors.blueAccent,
          ];
          int colorIndex = 0;
          final Map<String, Color> categoryColors = {};
          if (totals.isEmpty) {
            return const Text("No data to display");
          }
          final List<PieChartSectionData> sections =
              totals.entries.map((entry) {
                final normalizedKey = entry.key.trim().toLowerCase();
                categoryColors.putIfAbsent(normalizedKey, () {
                  Color color = colorList[colorIndex % colorList.length];
                  colorIndex++;
                  return color;
                });
                return PieChartSectionData(
                  title: "${entry.key}\n${entry.value.toStringAsFixed(0)}",
                  value: entry.value,
                  color: categoryColors[normalizedKey],
                  radius: 170,
                  titleStyle: TextStyle(fontSize: 12, color: Colors.white),
                  titlePositionPercentageOffset: 0.6,
                );
              }).toList();

          return PieChart(
            PieChartData(
              sections: sections,
              centerSpaceRadius: 10,
              sectionsSpace: 5,
            ),
          );
        }),
      ),
    );
  }
}
