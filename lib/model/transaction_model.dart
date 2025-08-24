class TransactionModel {
  final String type; // "income" or "expense"
  final double amount;
  final String description; // source/category
  final DateTime date;

  TransactionModel({
    required this.type,
    required this.amount,
    required this.description,
    required this.date,
  });

  // Convert object to Map for SharedPreferences
  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "amount": amount,
      "description": description,
      "date": date.toIso8601String(),
    };
  }

  // Convert Map to object
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      type: json["type"],
      amount: (json["amount"] as num).toDouble(),
      description: json["description"],
      date: DateTime.parse(json["date"]),
    );
  }
}
