import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projet_d_integration/data/Transaction.dart';

class TransactionService {
  static const String baseUrl = "http://localhost:5000";

  // Exemple de méthode pour récupérer toutes les transactions
  static Future<List<transaction>> getAllTransactions() async {
   try{
    final response = await http.get(Uri.parse('$baseUrl/transaction'));

    if (response.statusCode == 200) {
      final List<dynamic> transactionsJson = jsonDecode(response.body)['List'];

      return transactionsJson.map((data) => transaction.fromJson(data)).toList();
    } else {
      throw Exception('Réponse inattendue du serveur : ${response.statusCode}');
    }
  } catch (e) {
  print('Erreur lors de la récupération des transactions : $e');
  throw Exception('Échec de la récupération des transactions');
  }

  }
  static Future<void> addTransaction(transaction newTransaction) async {
   print(newTransaction.toJson());
    try {
      final response = await http.post(

        Uri.parse('$baseUrl/transaction'),
        body: jsonEncode(newTransaction.toJson()),
      );
      print('Response details: ${response.body}');

      if (response.statusCode == 201) {
        print('Transaction ajoutée avec succès');
      } else {
        throw Exception('Échec de l\'ajout de la transaction : ${response.statusCode}');
      }
    } on FormatException catch (e) {
      print('Erreur de format JSON lors de l\'ajout de la transaction : $e');
      throw Exception('Échec de l\'ajout de la transaction : Format JSON incorrect');
    } catch (e) {
      print('Erreur inattendue lors de l\'ajout de la transaction : $e');
      throw Exception('Échec de l\'ajout de la transaction');
    }
  }




}
