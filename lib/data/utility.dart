import 'package:projet_d_integration/data/Transaction.dart';
import 'package:projet_d_integration/data/listdata.dart';

int totals = 0;

int total(List<transaction> history2) {
  List a = [0, 0];
  print(history2.length);

  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].type == 'Income'
        ? int.parse(history2[i].montant.toString())
        : int.parse(history2[i].montant.toString()) * -1);
    print(history2[i].montant);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

int income(List<transaction> history2) {
  //var history2 = box.values.toList();

  List a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].type == 'Income' ? int.parse(history2[i].montant.toString()) : 0);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}
int expenses(List<transaction> history2) {
  //var history2 = box.values.toList();

  List a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].type == 'Income' ? 0 : int.parse(history2[i].montant.toString()) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

List<transaction> today(List<transaction> history2) {
  List<transaction> a = [];
  //var history2 = box.values.toList();
  DateTime date = new DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].date?.day == date.day) {
      a.add(history2[i]);
    }
  }
  print("today"+a.toString());
  return a;
}
List<transaction> week(List<transaction> history2) {
  List<transaction> a = [];
  DateTime date = new DateTime.now();

  //var history2 = box.values.toList();
  for (var i = 0; i < history2.length; i++) {

    if (date.day - 7 <= history2[i].date!.day &&
        history2[i].date!.day <= date.day) {
      print("la date:");
      print( history2[i].date);
      print("l annee:");
      print(history2[i].date!.day);
      a.add(history2[i]);
    }
    print("today"+a.toString());

  }

  return a;
}

List<transaction> month(List<transaction> history2) {
  List<transaction> a = [];

  //var history2 = box.values.toList();
  DateTime date = new DateTime.now();
  print(history2.length.toString());
  for (var i = 0; i < history2.length; i++) {

    if (history2[i].date!.month == date.month) {
      a.add(history2[i]);
    }
  }
  return a;
}

List<transaction> year(List<transaction> history2) {
  List<transaction> a = [];

  //var history2 = box.values.toList();
  DateTime date = new DateTime.now();
  for (var i = 0; i < history2.length; i++) {

    if (history2[i].date!.year == date.year) {
      a.add(history2[i]);
    }
  }

  return a;
}

int total_chart(List<transaction> history2) {
  List a = [0, 0];

  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].type == 'Income'
        ? int.parse(history2[i].montant.toString())
        : int.parse(history2[i].montant.toString()) * -1);
  }
   totals = a.reduce((value, element) => value + element);
  return totals;
}
List time(List<transaction> history2, bool hour) {
  List<transaction> a = [];
  List total = [];
  int counter = 0;
  for (var c = 0; c < history2.length; c++) {
    for (var i = c; i < history2.length; i++) {
      if (hour) {
        if (history2[i].date!.hour == history2[c].date!.hour) {
          a.add(history2[i]);
          counter = i;
        }
      } else {
        if (history2[i].date!.day == history2[c].date!.day) {
          a.add(history2[i]);
          counter = i;
        }
      }
    }
    total.add(total_chart(a));
    a.clear();
    c = counter;
  }
  print(total);
  return total;
}