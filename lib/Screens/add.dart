import 'package:flutter/material.dart';
import 'package:projet_d_integration/constants.dart';
import 'package:projet_d_integration/data/Transaction.dart';
import 'package:projet_d_integration/Services/service.dart';
import 'package:projet_d_integration/Services/TransctionService.dart';

class Add_Screen extends StatefulWidget {
  const Add_Screen({Key? key}) : super(key: key);

  @override
  State<Add_Screen> createState() => _Add_ScreenState();
}

class _Add_ScreenState extends State<Add_Screen> {
  DateTime date = DateTime.now();
  String? selctedItem;
  String? selctedItemi;
  final TextEditingController description_C = TextEditingController();
  final TextEditingController amount_c = TextEditingController();

  // final List<String> _item = ['food', "Transfer", "Transportation", "Education"];
  final List<String> _itemei = ['Income', "Expand"];

  Service service = Service();
  late List<Categorie> categories;
  Categorie? selectedCategory;

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      categories = await service.fetchCategories();
      setState(() {});
    } catch (e) {
      print('Erreur lors du chargement des catégories: $e');
    }
  }

  Widget name() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Color(0xffC5C5C5),
          ),
        ),
        child: DropdownButton<Categorie>(
          value: selectedCategory,
          onChanged: (Categorie? value) {
            setState(() {
              selectedCategory = value;
            });
          },
          items: categories.map((Categorie category) {
            return DropdownMenuItem<Categorie>(
              value: category,
              child: Row(
                children: [
                  Container(
                    width: 40,
                    child: Image.asset('images/${category.nom}.png'),
                  ),
                  SizedBox(width: 10),
                  Text(
                    category.nom!,
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            );
          }).toList(),
          selectedItemBuilder: (BuildContext context) => categories
              .map((Categorie category) => Row(
            children: [
              Container(
                width: 42,
                child: Image.asset('images/${category.nom}.png'),
              ),
              SizedBox(width: 5),
              Text(category.nom ?? ''), // Fournir une valeur par défaut si null
            ],
          ))
              .toList(),
          hint: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              'Nom',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
        ),
      ),
    );
  }

  Padding amount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: amount_c,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: 'Amount',
          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2, color: Color(0xffC5C5C5))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2, color: kPrimaryColor)),
        ),
      ),
    );
  }

  Padding description() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: description_C,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          labelText: 'Description',
          labelStyle: TextStyle(
            fontSize: 17,
            color: Colors.grey.shade500,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 2,
              color: Color(0xffC5C5C5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 2,
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Padding How() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Color(0xffC5C5C5),
          ),
        ),
        child: DropdownButton<String>(
          value: selctedItemi,
          onChanged: ((value) {
            setState(() {
              selctedItemi = value!;
            });
          }),
          items: _itemei
              .map((e) => DropdownMenuItem(
            child: Container(
              alignment: Alignment.center,
              child: Row(
                children: [Text(e, style: TextStyle(fontSize: 18))],
              ),
            ),
            value: e,
          ))
              .toList(),
          selectedItemBuilder: (BuildContext context) => _itemei
              .map((e) => Row(
            children: [Text(e)],
          ))
              .toList(),
          hint: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              'How',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
        ),
      ),
    );
  }

  Widget date_time() {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: Color(0xffC5C5C5)),
      ),
      width: 300,
      child: TextButton(
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: date,
            firstDate: DateTime(2020),
            lastDate: DateTime(2100),
          );

          if (newDate == null) return;

          // Une fois la date sélectionnée, afficher l'heure
          TimeOfDay? newTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );

          if (newTime == null) return;

          // Combinez la date et l'heure pour obtenir la date complète
          setState(() {
            date = DateTime(newDate.year, newDate.month, newDate.day, newTime.hour, newTime.minute);
          });
        },
        child: Text(
          'Date : ${date.year} / ${date.day} / ${date.month} ${date.hour}:${date.minute}',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  GestureDetector save() {
    return GestureDetector(
      onTap: () async {
        if (selectedCategory != null) {
          await service.addTransaction(
            selectedCategory,
            date,
            selctedItemi,
            double.parse(amount_c.text),
            description_C.text,
          );
          Navigator.of(context).pop();
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kPrimaryColor,
        ),
        width: 120,
        height: 50,
        child: Text(
          'Save',
          style: TextStyle(
            fontFamily: 'f',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  Container main_container() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: 550,
      width: 340,
      child: Column(
        children: [
          SizedBox(height: 50),
          name(),
          SizedBox(height: 30),
          description(),
          SizedBox(height: 30),
          amount(),
          SizedBox(height: 30),
          How(),
          SizedBox(height: 30),
          date_time(),
          Spacer(),
          save(),
          SizedBox(height: 25),
        ],
      ),
    );
  }

  Column background_container(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: BoxDecoration(
            color: Color(0xFFFF8A65),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Adding',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.attach_file_outlined,
                      color: Colors.white,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            background_container(context),
            Positioned(
              top: 120,
              child: main_container(),
            ),
          ],
        ),
      ),
    );
  }
}