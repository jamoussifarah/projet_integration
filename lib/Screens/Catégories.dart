import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_d_integration/data/Transaction.dart';
import 'package:projet_d_integration/data/listdata.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}
class _TransactionListState extends State<TransactionList> {
  List<transaction> a = [];
  int index_color = 0;
  ValueNotifier<int> kj = ValueNotifier<int>(0);

  late Map<String, List<transaction>> transactionsParCategorie;
  late List<String> categories;
  late List<transaction> transactionsPourCategorieSelectionnee;

  @override
  void initState() {
    super.initState();
    fetchDataAndOrganize();
  }

  void fetchDataAndOrganize() async {
    List<transaction> fetchedTransactions = await fetchData();
    if (fetchedTransactions.isNotEmpty) {
      organizeTransactionsByCategory();
      categories = transactionsParCategorie.keys.toList();
      updateTransactionsForSelectedCategory();

      print("Init State - Categories length: ${categories.length}");
      print(
          "Init State - Transactions length: ${transactionsPourCategorieSelectionnee
              ?.length}");
    } else {
      // Handle the case where no transactions were retrieved
      print("No transactions retrieved");
    }
  }

  Future<List<transaction>> fetchData() async {
    List<transaction> fetchedTransactions = await geter();
    setState(() {
      a = fetchedTransactions;
    });
    return fetchedTransactions;
  }

  void organizeTransactionsByCategory() {
    transactionsParCategorie = {};
    for (transaction t in a) {
      String categorie = t.categorie ?? 'Autre';
      transactionsParCategorie[categorie] =
          transactionsParCategorie[categorie] ?? [];
      transactionsParCategorie[categorie]!.add(t);
    }
  }

  void updateTransactionsForSelectedCategory() {
    String categorieSelectionnee = categories[index_color];
    setState(() {
      transactionsPourCategorieSelectionnee =
          List.from(transactionsParCategorie[categorieSelectionnee] ?? []);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TransactionListWidget(),
    );
  }

  Widget TransactionListWidget() {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  children: [
                    Text(
                      'All Transactions',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ...List.generate(
                            categories.length,
                                (index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    index_color = index;
                                    updateTransactionsForSelectedCategory();
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        10),
                                    color: index_color == index
                                        ? Color.fromARGB(
                                        255, 47, 125, 121)
                                        : Colors.white,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    categories[index],
                                    style: TextStyle(
                                      color: index_color == index
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  if (transactionsPourCategorieSelectionnee != null &&
                      index < transactionsPourCategorieSelectionnee.length) {
                    transaction t = transactionsPourCategorieSelectionnee[index];
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          'images/${t.categorie}.png',
                          height: 40,
                        ),
                      ),
                      title: Text(
                        t.categorie ?? '',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        ' ${t.date?.year}-${t.date?.day}-${t.date?.month}' ??
                            '',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: Text(
                        t.montant?.toString() ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 19,
                          color: t.type == 'Income' ? Colors.green : Colors.red,
                        ),
                      ),
                    );
                  } else {
                    print("Index out of range: $index");
                    return SizedBox.shrink();
                  }
                },
                childCount: transactionsPourCategorieSelectionnee?.length ?? 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}