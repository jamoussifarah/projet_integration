class transaction {
  String?id;
  String? categorie;
  DateTime? time;
  String? type;
  String? montant;


transaction(categorie,time,type,montant)
  {
    this.categorie=categorie;
    this.time=time;
    this.type=type;
    this.montant=montant;
  }
}