class BudgetModel {
  final String category;
  double amount;

  BudgetModel({required this.category, required this.amount});

  Map<String, dynamic> toJson() => {
        "category": category,
        "amount": amount,
      };

  factory BudgetModel.fromJson(Map<String, dynamic> json) {
    return BudgetModel(
      category: json["category"],
      amount: (json["amount"] as num).toDouble(),
    );
  }
}
