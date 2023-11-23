import 'package:flutter/material.dart';
//import 'package:fl_chart/fl_chart.dart';
import 'package:projet_d_integration/data/Transaction.dart';

import 'package:pie_chart/pie_chart.dart';

class TotalChart extends StatefulWidget {
  final Map<String, double> totalTransactionsParCategorie;
  const TotalChart({Key? key,required this.totalTransactionsParCategorie}) : super(key: key);

  @override
  State<TotalChart> createState() => _TotalChartState();
}

class _TotalChartState extends State<TotalChart> {
  late Map<String, List<transaction>> transactionsParCategorie;
  List<Color> colorList = [
    Colors.blue,
    Colors.lightGreen,
    Colors.grey,
    // Ajoutez autant de couleurs que vous le souhaitez
  ];

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
            children: [
              Expanded(
                flex: 40,
                child:
                PieChart(
                  dataMap: widget.totalTransactionsParCategorie,
                  animationDuration: Duration(milliseconds: 800),
                  chartLegendSpacing: 32,
                  chartRadius: MediaQuery.of(context).size.width / 3.2,
                  initialAngleInDegree: 0,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 32,
                  centerText: "",
                  legendOptions: LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.right,
                    showLegends: true,
                    legendShape: BoxShape.circle, // Correction ici
                    legendTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  chartValuesOptions: ChartValuesOptions(
                    showChartValueBackground: false,
                    showChartValues: true,
                    showChartValuesInPercentage: true,
                    showChartValuesOutside: false,
                    decimalPlaces: 1,
                  ),
                ),
              ),
            ],
          );
        }
      }
