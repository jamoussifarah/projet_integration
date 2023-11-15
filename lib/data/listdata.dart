import 'Transaction.dart';
import 'package:projet_d_integration/Services/TransctionService.dart';

Future<List<transaction>> geter() async {
  // transaction t = transaction(DateTime(2023, 11, 7), "Income", "666");
  // transaction t2 = transaction("Transfer",DateTime(2023, 11, 7),"expenses","555");
  // transaction t3 = transaction("Transportation",DateTime(2023, 11, 7),"Income","744");

  try {
    List<transaction> transactions = await TransactionService.getAllTransactions();
    return transactions;
  } catch (e) {
    print('Erreur lors de la récupération des transactions : $e');
    throw Exception('Échec de la récupération des transactions');
  }
}