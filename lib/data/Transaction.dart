class transaction {
   DateTime date; // Assurez-vous d'importer la classe LocalDateTime si nécessaire
  String? montant;
  String? type;
  String? categorie;
  String? nom;

  transaction({
    required this.date,
    required this.type,
    required this.montant,
    required this.categorie,
    required this.nom
  });

  factory transaction.fromJson(Map<String, dynamic> json) {
    return transaction(
      date: DateTime.parse(json['date']),
      type: json['type'].toString(),
      montant: json['montant'].toString(),
      categorie: json['categorieName'].toString(),
      nom:json['t_nom'].toString()
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (date != null) data['date'] = date.toString(); // Assurez-vous que cette conversion est correcte
    if (type != null) data['type'] = type!;
    if (montant != null) data['montant'] = montant!;
    if (categorie != null) data['categorieName'] = categorie!;
    return data;
  }

  @override
  String toString() {
    return 'Transaction{ date: $date, montant: $montant, type: $type, categorie: $categorie}';
  }
}
