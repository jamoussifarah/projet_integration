import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet_d_integration/Screens/statistics.dart';
import 'package:projet_d_integration/Screens/home.dart';
import 'package:projet_d_integration/Screens/add.dart';
import 'package:projet_d_integration/widgets/expenses_categories_chart.dart';
import 'package:projet_d_integration/constants.dart';
import 'package:projet_d_integration/Screens/Catégories.dart';
import 'package:projet_d_integration/Screens/profile/profile_screen.dart';
import 'package:projet_d_integration/Services/TransctionService.dart';
import 'package:projet_d_integration/data/Transaction.dart';

class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);
  static String routeName = "/";
  @override
  State<Bottom> createState() => _BottomState();

}
const Color inActiveIconColor = Color(0xFFB6B6B6);
void test() async {
  List<transaction> transactions = await TransactionService.getAllTransactions();

}
class _BottomState extends State<Bottom> {
  int index_color = 0;
  List Screen = [Home(), Statistics(), TransactionList(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen[index_color],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          test();
         Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Add_Screen()));
        },
        child: Icon(Icons.add),
        backgroundColor: kPrimaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 0;
                  });
                },child: Icon(
                Icons.home,
                size: 30,
                color: index_color == 0 ? kPrimaryColor : inActiveIconColor,
              ),),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 1;
                  });
                },
                child: Icon(
                  Icons.bar_chart_outlined,
                  size: 30,
                  color: index_color == 1 ? kPrimaryColor : inActiveIconColor,
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 2;
                  });
                },
                child: Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 30,
                  color: index_color == 2 ? kPrimaryColor : inActiveIconColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 3;
                  });
                },
                child: Icon(
                  Icons.person_outlined,
                  size: 30,
                  color: index_color == 3 ? kPrimaryColor : inActiveIconColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}