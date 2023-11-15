import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:projet_d_integration/data/Transaction.dart';
import 'package:projet_d_integration/data/utility.dart';
import 'package:projet_d_integration/data/listdata.dart';

class TotalChart extends StatefulWidget {
  const TotalChart({Key? key}) : super(key: key);

  @override
  State<TotalChart> createState() => _TotalChartState();
}

class _TotalChartState extends State<TotalChart> {
  late Map<String, List<transaction>> transactionParCategorie;
  List<transaction> list = [];
  int index_color = 0;

  @override
  void initState() {
    super.initState();
    fetchDataAndOrganize();
  }

  Future<void> fetchDataAndOrganize() async {
    List<transaction> fetchedTransactions = await fetchData();
    if (fetchedTransactions.isNotEmpty) {
      organizeTransactionsByCategory(fetchedTransactions);
      updateTransactionsForSelectedCategory();
    } else {
      // Handle the case where no transactions were retrieved
      print("No transactions retrieved");
    }
  }

  Future<List<transaction>> fetchData() async {
    List<transaction> fetchedTransactions = await geter();
    setState(() {
      list = fetchedTransactions;
    });
    return fetchedTransactions;
  }

  void organizeTransactionsByCategory(List<transaction> transactions) {
    transactionParCategorie = {};
    for (transaction t in transactions) {
      String categorie = t.categorie ?? 'Autre';
      transactionParCategorie[categorie] =
          transactionParCategorie[categorie] ?? [];
      transactionParCategorie[categorie]!.add(t);
    }
  }

  void updateTransactionsForSelectedCategory() {
    String categorieSelectionnee =
    transactionParCategorie.keys.elementAt(index_color);
    setState(() {
      // Here you can use the selected category data as needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<transaction>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No data available');
        } else {
          list = snapshot.data!;
          var totals = total(list);

          return Row(
            children: [
              Expanded(
                flex: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      alignment: Alignment.center,
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Total Expenses: ${NumberFormat.currency(locale: 'ar_TN', symbol: 'TND').format(totals)}',
                        textScaleFactor: 1.5,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    ...transactionParCategorie.keys.map(
                          (categorie) {
                        int categoryTotal =
                        total(transactionParCategorie[categorie] ?? []);
                        double percentage =
                        totals != 0 ? (categoryTotal / totals) * 100 : 0;

                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            children: [
                              Container(
                                width: 8.0,
                                height: 8.0,
                                color: Colors.primaries[
                                list.indexOf(transactionParCategorie[categorie]!.first)],
                              ),
                              const SizedBox(width: 5.0),
                              Text("$categorie"),
                              const SizedBox(width: 5.0),
                              Text(
                                '${NumberFormat.currency(locale: 'ar_TN', symbol: 'TND').format(categoryTotal)}',
                              ),
                              const SizedBox(width: 5.0),
                              Text(
                                totals == 0
                                    ? '0%'
                                    : '${percentage.toStringAsFixed(2)}%',
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 40,
                child: PieChart(
                  PieChartData(
                    centerSpaceRadius: 20.0,
                    sections: totals != 0
                        ? transactionParCategorie.keys
                        .map(
                          (categorie) => PieChartSectionData(
                        showTitle: false,
                        value: total(transactionParCategorie[categorie] ?? []).toDouble(),
                        color: Colors.primaries[
                        list.indexOf(transactionParCategorie[categorie]!.first)],
                      ),
                    )
                        .toList()
                        : list
                        .map(
                          (e) => PieChartSectionData(
                        showTitle: false,
                        color: Colors.primaries[list.indexOf(e)],
                      ),
                    )
                        .toList(),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
