import 'dart:async';

import 'package:projet_d_integration/Services/TransctionService.dart';
import 'package:projet_d_integration/data/Transaction.dart';
import 'package:flutter/foundation.dart';

class TransactionProvider extends ChangeNotifier {
  List<transaction> _transactions = [];
  StreamController<List<transaction>> _transactionsController = StreamController<List<transaction>>.broadcast();

  Stream<List<transaction>> get transactionsStream => _transactionsController.stream;

  List<transaction> get transactions => _transactions;

  Future<void> fetchTransactions() async {
    try {
      List<transaction> transactions = await TransactionService.getAllTransactions();
      _transactions = transactions;
      _transactionsController.add(_transactions);
    } catch (e) {
      print('Erreur lors de la récupération des transactions : $e');
      throw Exception('Échec de la récupération des transactions');
    }
  }

  void addTransaction(transaction transaction) async {
    // Ajouter votre logique pour ajouter la transaction au backend si nécessaire
    // Puis mettre à jour la liste des transactions
    await fetchTransactions();
  }
}
