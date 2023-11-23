import 'package:flutter/material.dart';
import 'package:projet_d_integration/constants.dart';
import 'package:projet_d_integration/data/Transaction.dart';
import 'package:projet_d_integration/data/listdata.dart';
import 'package:projet_d_integration/data/utility.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  int indexx;
  List<transaction> a = [];
  Chart({Key? key, required this.indexx,required this.a}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}
class _ChartState extends State<Chart> {

  bool b = true;
  bool j = true;

  @override
  Widget build(BuildContext context) {
    switch (widget.indexx) {
      case 0:
        widget.a = today(widget.a);
        b = true;
        j = true;
        break;
      case 1:
        widget.a = week(widget.a);
        b = false;
        j = true;
        break;
      case 2:
        widget.a = month(widget.a);
        b = false;
        j = true;
        break;
      case 3:
        widget.a = year(widget.a);

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
            color: kPrimaryColor,
            width: 3,
            dataSource: <SalesData>[
              ...List.generate(time(widget.a!, b ? true : false).length, (index) {
                return SalesData(
                    j
                        ? b
                        ? widget.a![index].date!.hour.toString()
                        : widget.a![index].date!.day.toString()
                        : widget.a![index].date!.month.toString(),
                    b
                        ? index > 0
                        ? time(widget.a!, true)[index] + time(widget.a!, true)[index - 1]
                        : time(widget.a!, true)[index]
                        : index > 0
                        ? time(widget.a!, false)[index] +
                        time(widget.a!, false)[index - 1]
                        : time(widget.a!, false)[index]);
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