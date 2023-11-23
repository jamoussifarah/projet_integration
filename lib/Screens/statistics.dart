import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:projet_d_integration/data/Transaction.dart';
import 'package:projet_d_integration/data/listdata.dart';
import 'package:projet_d_integration/widgets/chart.dart';
import 'package:projet_d_integration/data/utility.dart';
import 'package:projet_d_integration/constants.dart';


class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);


  @override
  State<Statistics> createState() => _StatisticsState();
}
ValueNotifier kj=ValueNotifier(0);
class _StatisticsState extends State<Statistics>
{
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
      a.sort((t1, t2) => t1.date!.compareTo(t2.date!));
    });
  }
  List day = ['Day', 'Week', 'Month', 'Year'];
  int index_color = 0;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: SafeArea(
       child: CustomScrollView(
         slivers:[
           SliverToBoxAdapter(
             child: Column(
               children: [
                 SizedBox(height: 20),
                 Text(
                   'Statistics',
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
                         4,
                             (index) {
                           return GestureDetector(
                             onTap: () {
                               setState(() {
                                 index_color = index;
                                 kj.value = index;
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
                                 day[index],
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
                 SizedBox(height: 20),
                 Chart(
                   indexx: index_color,
                   a:a
                 ),
                 SizedBox(height: 20),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 15),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                         'Top Spending',
                         style: TextStyle(
                             color: Colors.black,
                             fontSize: 16,
                             fontWeight: FontWeight.bold),
                       ),
                       Icon(
                         Icons.swap_vert,
                         size: 25,
                         color: Colors.grey,
                       ),
                     ],
                   ),
                 ),
               ],
             ),
           ),
           SliverList(
             delegate: SliverChildBuilderDelegate(
                   (context, index) {
                 // Afficher les transactions en fonction de la période
                 List<transaction> filteredTransactions;

                 switch (index_color) {
                   case 0:
                     filteredTransactions = today(a);
                     break;
                   case 1:
                     filteredTransactions = week(a);
                     break;
                   case 2:
                     filteredTransactions = month(a);
                     break;
                   case 3:
                     filteredTransactions = year(a);
                     break;
                   default:
                     filteredTransactions = a;
                 }

                 // Vérifiez que l'index est inférieur à la longueur de filteredTransactions
                 if (index < filteredTransactions.length) {
                   // Afficher les transactions dans la SliverList
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'images/${filteredTransactions[index].categorie}.png',
                    height: 40,
                  ),
                ),
                title: Text(
                  filteredTransactions[index].nom ?? '',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: kTextColor,
                  ),
                ),
                subtitle: Text(
                  ' ${filteredTransactions[index].date?.year}-${filteredTransactions[index].date?.month}-${filteredTransactions[index].date?.day}' ??
                      '',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: kTextColor,
                  ),
                ),
                trailing: Text(
                  '${filteredTransactions[index].montant} Dt',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    color: filteredTransactions[index].type == 'Income' ? Colors.greenAccent : kPrimaryColor,
                  ),
                ),
              );

                 } else {
                   // Retournez un widget vide si l'index est hors limites
                   return SizedBox.shrink();
                 }
               },
               childCount: a.length,
             ),
           )

         ]



       ),
     ),


   );
  }

}