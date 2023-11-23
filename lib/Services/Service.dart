import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Transaction {
  String? id;
  Categorie? categorie;
  DateTime? time;
  String? type;
  double ? montant;
  String? description;

  Transaction({
    this.id,
    required this.categorie,
    required this.time,
    required this.type,
    required this.montant,
    required this.description,
  });
}
class Categorie {
  String? id;
  String? nom;
  String?mois;
  double?budget;
  // Ajoutez d'autres propriétés de catégorie si nécessaire

  Categorie({
    this.id,
    this.nom,
    this.mois,
    this.budget
    // Initialisez d'autres propriétés de catégorie si nécessaire
  });
}


class Service {
  //create the method to save user
  //***********************--POST TRANSACTION+++++++++++++++++++++++++++++++

  Future<http.Response> addTransaction(
      Categorie? categorie,
      DateTime time,
      String? type,
      double? montant,
      String? description,
      ) async {
    print(time);
    try {

      //DateTime dateTime = DateTime.parse(time as String);
      /*String formattedDate = DateFormat('yyyy-MM-dd').format(time);
      print(formattedDate);*/
      String formattedDate = time.toIso8601String();
      var uri = Uri.parse("http://localhost:5000/transaction");
      Map<String, String> headers = {"Content-Type": "application/json"};

      Map data = {
        'categorie': {
          'id': categorie?.id,
          'nom': categorie?.nom,
          'mois':categorie?.mois,
          'budget':categorie?.budget
          // Ajoutez d'autres propriétés de catégorie si nécessaire
        },
        'date': formattedDate,
        'type': type,
        'montant': montant,
        't_nom': description,
      };

      var body = json.encode(data);
      var response = await http.post(uri, headers: headers, body: body);

      print("${response.body}");

      return response;
    } catch (e) {
      print('Erreur lors de l\'ajout de la transaction: $e');
      throw e;
    }
  }




  //***********************--GET TRANSACTION+++++++++++++++++++++++++++++++



  Future<List<Transaction>> fetchDataFromApi() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:5000/transaction'));

      if (response.statusCode == 200) {
        dynamic jsonData = json.decode(response.body);

        if (jsonData is Map && jsonData.containsKey("List")) {
          List<Transaction> transactionList = (jsonData["List"] as List).map((item) {
            return Transaction(
              id: item['id'].toString(),
              categorie: Categorie(
                id: item['categorie']['id'].toString(),
                nom: item['categorie']['nom'].toString(),
                // Ajoutez d'autres propriétés de catégorie si nécessaire
              ), // Fournir une valeur par défaut si null
              time: DateTime.parse(item['date']),
              type: item['type'] ?? "",
              description: item['description'] ?? "",// Fournir une valeur par défaut si null
              montant: item['montant']?.toDouble(), // Convertir en double, laisser null si montant est null
            );
          }).toList();
          print("${response.body}");
          return transactionList;
        } else {
          throw Exception('Format de données non valide');
        }
      } else {
        throw Exception('Échec du chargement des données');
      }
    } catch (e) {
      print('Erreur lors de la récupération des données: $e');
      throw e;
    }
  }




  Future<List<Categorie>> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:5000/categorie'));

      if (response.statusCode == 200) {
        dynamic jsonData = json.decode(response.body);

        if (jsonData is Map && jsonData.containsKey("List")) {
          List<Categorie> categoryList = (jsonData["List"] as List).map((item) {
            return Categorie(
              id: item['id'].toString(),
              nom: item['nom'].toString(),
              // Ajoutez d'autres propriétés de catégorie si nécessaire
            );
          }).toList();
          print("${response.body}");
          return categoryList;
        } else {
          throw Exception('Format de données non valide');
        }
      } else {
        throw Exception('Échec du chargement des catégories');
      }
    } catch (e) {
      print('Erreur lors de la récupération des catégories: $e');
      throw e;
    }
  }









}
















//class Service {
//   String? id;
//   String? categorie;
//   DateTime? time;
//   String? type;
//   String? montant;
//
//   Service({this.id, this.categorie, this.time, this.type, this.montant});
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'categorie': categorie,
//       'time': time?.toIso8601String(),
//       'type': type,
//       'montant': montant,
//     };
//   }
// }
//
// class TransactionService {
//   final String baseUrl;
//
//   TransactionService(this.baseUrl);
//
//   Future<http.Response> addTransaction(Service transaction) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/addTransaction'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(transaction.toJson()),
//       );
//
//       if (response.statusCode == 200) {
//         print('Transaction ajoutée avec succès');
//       } else {
//         print('Erreur lors de l\'ajout de la transaction. Code d\'erreur : ${response.statusCode}');
//       }
//     } catch (error) {
//       print('Erreur lors de la communication avec le backend : $error');
//     }
//   }
// }