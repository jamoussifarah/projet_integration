
class transaction {
  DateTime? date;
  String? montant;
  String? type;
  String ?categorie;

transaction(time,type,montant,categorie)
  {
    this.date=time;
    this.type=type;
    this.montant=montant;
    this.categorie=categorie;
  }

  factory transaction.fromJson(Map<String, dynamic> json) {

  return transaction(
     //json['time'] != null ? DateTime.parse(json['time']) : null,
        DateTime.parse(json['date']).toLocal()??'',
       json['type'].toString()??'',
     json['montant'] ??'',
    json['categorieName']??''
  );
}
  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = {};
      if (date != null)data['date']= date!.toIso8601String();
      if (type != null) data['type'] = type.toString();
      if (montant != null) data['montant'] =montant.toString();
      if (categorie != null) data['categorieName']= categorie.toString();
    return data;
  }



  @override
  String toString() {
    return 'Transaction{ date: $date, montant: $montant, type: $type, ctegorie:$categorie}';
  }

}
