import 'Transaction.dart';


List<transaction> geter()
{
  transaction t=transaction("food",DateTime(2023, 11, 7),"Income","666");
  transaction t2 = transaction("Transfer",DateTime(2023, 11, 7),"expenses","555");
  transaction t3 = transaction("Transportation",DateTime(2023, 11, 7),"Income","744");


  return [t,t2,t3];
}