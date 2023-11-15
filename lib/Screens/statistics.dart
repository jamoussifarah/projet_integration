import 'package:flutter/material.dart';
import 'package:projet_d_integration/data/Transaction.dart';
import 'package:projet_d_integration/data/listdata.dart';
import 'package:projet_d_integration/widgets/chart.dart';


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
                                     ? Color.fromARGB(255, 47, 125, 121)
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
                   return ListTile(
                     leading: ClipRRect(
                       borderRadius: BorderRadius.circular(5),
                       child: Image.asset('images/${a[index].categorie}.png', height: 40),
                     ),
                     title: Text(
                       a[index].categorie!,
                       style: TextStyle(
                         fontSize: 17,
                         fontWeight: FontWeight.w600,
                       ),
                     ),
                     subtitle: Text(

                       ' ${a[index].date!.year}-${a[index].date!.day}-${a[index].date!.month}',
                       style: TextStyle(
                         fontWeight: FontWeight.w600,
                       ),
                     ),
                     trailing: Text(
                       a[index].montant! as String,
                       style: TextStyle(
                         fontWeight: FontWeight.w600,
                         fontSize: 19,
                         color: a[index].type == 'Income' ? Colors.green : Colors.red,
                       ),
                     ),
                   );
                 },
                 childCount: a.length,
               ))
         ]



       ),
     ),


   );
  }

}