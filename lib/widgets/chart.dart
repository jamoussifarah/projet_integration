import 'package:flutter/material.dart';
import 'package:projet_d_integration/data/Transaction.dart';
import 'package:projet_d_integration/data/listdata.dart';
import 'package:projet_d_integration/data/utility.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  int indexx;
  Chart({Key? key, required this.indexx}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}
class _ChartState extends State<Chart> {
  List<transaction> a = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    List<transaction> fetchedTransactions = await geter();
    setState(() {
      a = fetchedTransactions;
    });
  }
  bool b = true;
  bool j = true;

  @override
  Widget build(BuildContext context) {
    switch (widget.indexx) {
      case 0:
        a = today(a);
        b = true;
        j = true;
        break;
      case 1:
        a = week(a);
        b = false;
        j = true;
        break;
      case 2:
        a = month(a);
        b = false;
        j = true;
        break;
      case 3:
        a = year(a);

        j = false;
        break;
      default:
    }
    return Container(
      width: double.infinity,
      height: 300,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <SplineSeries<SalesData, String>>[
          SplineSeries<SalesData, String>(
            color: Color.fromARGB(255, 47, 125, 121),
            width: 3,
            dataSource: <SalesData>[
              ...List.generate(time(a!, b ? true : false).length, (index) {
                return SalesData(
                    j
                        ? b
                        ? a![index].date!.hour.toString()
                        : a![index].date!.day.toString()
                        : a![index].date!.month.toString(),
                    b
                        ? index > 0
                        ? time(a!, true)[index] + time(a!, true)[index - 1]
                        : time(a!, true)[index]
                        : index > 0
                        ? time(a!, false)[index] +
                        time(a!, false)[index - 1]
                        : time(a!, false)[index]);
              })
            ],
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
          )
        ],
      ),
    );


  }


}
class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final int sales;
}