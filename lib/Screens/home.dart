import 'package:flutter/material.dart';
import 'package:projet_d_integration/data/listdata.dart';
import 'package:projet_d_integration/data/utility.dart';
import 'package:projet_d_integration/data/Transaction.dart';
import 'package:projet_d_integration/Services/TransctionService.dart';
import 'package:projet_d_integration/constants.dart';
import 'package:projet_d_integration/widgets/detailTransaction.dart';
import '../../../constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatelessWidget {
  List<transaction> a = [];

  Future<List<transaction>> fetchData() async {
    return geter();
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
        } else {
          a = snapshot.data!;
          return Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(height: 340, child: _head()),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Transactions History',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 19,
                              color: kTextColor,
                            ),
                          ),
                          Text(
                            'See all',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: kSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Dismissible(
                            key: Key(index.toString()),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              a.removeAt(index);
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
                                  SvgPicture.asset("icons/Trash.svg"),
                                ],
                              ),
                            ),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  'images/${a[index].categorie}.png',
                                  height: 40,
                                ),
                              ),
                              title: Text(
                                a[index].categorie!,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                '${[a[index].date!.weekday - 1]}  ${a[index].date!.year}-${a[index].date!.month}-${a[index].date!.day}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              trailing: Text(
                                '${a[index].montant} Dt',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 19,
                                  color: a[index].type == 'Income'
                                      ? Colors.greenAccent
                                      : kPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: a.length,
                    ),
                  ),

                  /* SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              'images/${a[index].categorie}.png',
                              height: 40,
                            ),
                          ),
                          title: Text(
                            a[index].categorie!,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            '${[a[index].date!.weekday - 1]}  ${a[index].date!.year}-${a[index].date!.month}-${a[index].date!.day}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: Text(
                            '${a[index].montant} Dt',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 19,
                              color: a[index].type == 'Income'
                                  ? Colors.greenAccent
                                  :kPrimaryColor ,
                            ),
                          ),
                        );
                      },
                      childCount: a.length,
                    ),
                  ),*/
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _head() {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 240,
              decoration: BoxDecoration(
                color: Color(0xFFFF8A65), // Updated
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 35,
                    left: 340,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Container(
                        height: 40,
                        width: 40,
                        color: kPrimaryLightColor.withOpacity(0.1), // Updated
                        child: Icon(
                          Icons.notification_add_outlined,
                          size: 30,
                          color: kTextColor, // Updated
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good afternoon',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: kPrimaryLightColor, // Updated
                          ),
                        ),
                        Text(
                          'Enjelin Morgeana',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: kTextColor, // Updated
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 140,
          left: 37,
          child: Container(
            height: 170,
            width: 320,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: kSecondaryColor, // Updated
                  offset: Offset(0, 6),
                  blurRadius: 12,
                  spreadRadius: 6,
                ),
              ],
              color: Color(0xFFFF8A65), // Updated
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Balance',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: kTextColor, // Updated
                        ),
                      ),
                      Icon(
                        Icons.more_horiz,
                        color: kTextColor, // Updated
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 7),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Text(
                        '\$ ${total(a)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: kTextColor, // Updated
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: kPrimaryLightColor, // Updated
                            child: Icon(
                              Icons.arrow_downward,
                              color: kTextColor, // Updated
                              size: 19,
                            ),
                          ),
                          SizedBox(width: 7),
                          Text(
                            'Income',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: kPrimaryLightColor, // Updated
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: kPrimaryLightColor, // Updated
                            child: Icon(
                              Icons.arrow_upward,
                              color: kTextColor, // Updated
                              size: 19,
                            ),
                          ),
                          SizedBox(width: 7),
                          Text(
                            'Expenses',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: kPrimaryLightColor, // Updated
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$ ${income(a)}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: kTextColor, // Updated
                        ),
                      ),
                      Text(
                        '\$ ${expenses(a)}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: kTextColor, // Updated
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
