import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:money_mate/model/budget_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/transaction_model.dart';

class AmountProvider with ChangeNotifier {
  double _totalIncome = 0.0;
  double _totalExpense = 0.0;
  double _savingsGoal = 0.0;
  bool _goalAchieved = false;

  double get totalIncome => _totalIncome;
  double get totalExpense => _totalExpense;
  double get savingsGoal => _savingsGoal;
  bool get goalAchieved => _goalAchieved;

  final List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => List.unmodifiable(_transactions);

  final Map<String, BudgetModel> _budgets = {};
  Map<String, BudgetModel> get budgets => _budgets;

  AmountProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _totalIncome = prefs.getDouble("totalIncome") ?? 0.0;
    _totalExpense = prefs.getDouble("totalExpense") ?? 0.0;
    _savingsGoal = prefs.getDouble("savingsGoal") ?? 0.0;
     _goalAchieved = prefs.getBool("goalAchieved") ?? false;

    final transactionList = prefs.getStringList("transactions") ?? [];
    _transactions.clear();
    _transactions.addAll(
      transactionList.map((e) {
        return TransactionModel.fromJson(json.decode(e));
      }),
    );

    final budgetMap = prefs.getString("budgets");
    if (budgetMap != null) {
      final decoded = json.decode(budgetMap) as Map<String, dynamic>;
      _budgets.clear();
      decoded.forEach((key, value) {
        _budgets[key] = BudgetModel.fromJson(value);
      });
    }
    notifyListeners();
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble("totalIncome", _totalIncome);
    await prefs.setDouble("totalExpense", _totalExpense);
    await prefs.setDouble("savingsGoal", _savingsGoal);
    await prefs.setBool("goalAchieved", _goalAchieved);

    final transactionList = _transactions
        .map((t) => json.encode(t.toJson()))
        .toList();
    await prefs.setStringList("transactions", transactionList);

    final budgetJson = _budgets.map(
      (key, value) => MapEntry(key, value.toJson()),
    );
    await prefs.setString("budgets", json.encode(budgetJson));
  }

  void addIncome(double amount, String source) {
    _totalIncome += amount;
    _transactions.insert(
      0,
      TransactionModel(
        type: "income",
        amount: amount,
        description: source,
        date: DateTime.now(),
      ),
    );
     _checkGoal();
    _saveData();
    notifyListeners();
  }

  void addExpense(double amount, String category) {
    _totalExpense += amount;
    _transactions.insert(
      0,
      TransactionModel(
        type: "expense",
        amount: amount,
        description: category,
        date: DateTime.now(),
      ),
    );
    _checkGoal();
    _saveData();
    notifyListeners();
  }

  void deleteTransaction(TransactionModel transaction) {
    _transactions.remove(transaction);
    if (transaction.type == "income") {
      _totalIncome -= transaction.amount;
    } else {
      _totalExpense -= transaction.amount;
    }
     _checkGoal();
    _saveData();
    notifyListeners();
  }

  void updateTransaction(
    TransactionModel oldTransaction,
    double newAmount,
    String newCategory,
  ) {
    final index = _transactions.indexOf(oldTransaction);
    if (index != -1) {
      if (oldTransaction.type == "expense") {
        _totalIncome += oldTransaction.amount; // rollback old
        _totalIncome -= newAmount; // apply new
      }
      _transactions[index] = TransactionModel(
        type: oldTransaction.type,
        amount: newAmount,
        description: newCategory,
        date: DateTime.now(),
      );
      _checkGoal();
      _saveData();
      notifyListeners();
    }
  }

  void setSavingsGoal(double goal) {
    _savingsGoal = goal;
    _goalAchieved = false;
    _saveData();
    notifyListeners();
  }

  double get currentSavings => _totalIncome - _totalExpense;

  double get savingsProgress {
    if (_savingsGoal == 0) return 0;
    return (currentSavings / _savingsGoal).clamp(0.0, 1.0);
  }

  void setBudget(String category, double amount) {
    _budgets[category] = BudgetModel(category: category, amount: amount);
    _saveData();
    notifyListeners();
  }

  double getSpentForCategory(String category) {
    return _transactions
        .where((t) => t.type == "expense" && t.description == category)
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double getBudgetProgress(String category) {
    if (!_budgets.containsKey(category)) return 0.0;
    final spent = getSpentForCategory(category);
    return (spent / _budgets[category]!.amount).clamp(0.0, 1.0);
  }
  void _checkGoal() {
    if (_savingsGoal > 0 && currentSavings >= _savingsGoal) {
      _goalAchieved = true;
    } else {
      _goalAchieved = false;
    }
  }
}
