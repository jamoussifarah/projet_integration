import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet_d_integration/data/Transaction.dart';
import 'package:projet_d_integration/data/listdata.dart';
import 'package:projet_d_integration/widgets/expenses_categories_chart.dart';
import 'package:projet_d_integration/constants.dart'; // Ajout des constantes

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  List<transaction> a = [];
  int index_color = 0;
  ValueNotifier<int> kj = ValueNotifier<int>(0);
  Map<String, double> totalTransactionsParCategorie = {};

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
          "Init State - Transactions length: ${transactionsPourCategorieSelectionnee?.length}");
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
    transactionsParCategorie.forEach((categorie, transactions) {
      double totalTransactions = transactions.length.toDouble();
      totalTransactionsParCategorie[categorie] = totalTransactions;
    });
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
    return SafeArea(
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
                      color: kTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 40),
                  TotalChart(totalTransactionsParCategorie: totalTransactionsParCategorie),

                  SizedBox(height: 40),
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
                                  borderRadius: BorderRadius.circular(10),
                                  color: index_color == index
                                      ? kPrimaryColor
                                      : Colors.white,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  categories[index],
                                  style: TextStyle(
                                    color: index_color == index
                                        ? Colors.white
                                        : kTextColor,
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Dismissible(
                      key: Key(index.toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          transactionsPourCategorieSelectionnee.removeAt(index);
                        });
                      },
                      background: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE6E6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            const Spacer(),
                            SvgPicture.asset("icons/Trash.svg", color: kTextColor),
                          ],
                        ),
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            'images/${t.categorie}.png',
                            height: 40,
                          ),
                        ),
                        title: Text(
                          t.nom ?? '',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: kTextColor,
                          ),
                        ),
                        subtitle: Text(
                          ' ${t.date?.year}-${t.date?.day}-${t.date?.month}' ??
                              '',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: kTextColor,
                          ),
                        ),
                        trailing: Text(
                          '${t.montant} Dt',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 19,
                            color: t.type == 'Income' ? Colors.greenAccent : kPrimaryColor,
                          ),
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        // Vous pouvez ajouter ici une boîte de dialogue de confirmation si nécessaire
                        return true;
                      },
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
    );
  }
}
