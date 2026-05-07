import 'package:flutter/material.dart';
import '../models/expense_model.dart';
import '../service/api_service.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseProvider extends ChangeNotifier {
  final apiservice = ApiService(); // call  api service

  List<ExpenseModel> _expense = []; //make a originallist
  List<ExpenseModel> _filterexpense = []; //make a ui list

  List<ExpenseModel> get expense => _filterexpense;
  bool isLoading = false;

  //.....read function retrive data from the api.......
  Future<void> loadexpense() async {
    isLoading = true;
    notifyListeners();
    try {
      _expense = await apiservice.fetchExpense();
      _filterexpense = _expense;
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> addExpense(ExpenseModel expense) async {
    try {
      await apiservice.insertExpense(expense);
      _expense.insert(0, expense);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void searchExpense(String keyword) async {
    if (keyword.isEmpty) {
      _filterexpense = _expense;
    } else {
      _filterexpense = _expense.where((expense) {
        return expense.title.toLowerCase().contains(keyword.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  void filterCategory(String category) {
    if (category == 'All') {
      _filterexpense = _expense;
    } else {
      _filterexpense = _expense.where((e) => e.category == category).toList();
    }
    notifyListeners();
  }

  void filterPayment(PaymentMethod method) {
    _filterexpense = _expense.where((e) => e.paymentMethod == method).toList();
    notifyListeners();
  }

  double get totalExpense {
    return _expense.fold(0, (sum, e) => sum + e.amount);
  }

  int get totalCount => _expense.length;

  Map<String, double> get categorySummery {
    final Map<String, double> data = {};

    for (var e in _expense) {
      if (data.containsKey(e.category)) {
        data[e.category] = data[e.category]! + e.amount;
      } else {
        data[e.category] = e.amount;
      }
    }
    return data;
  }

  // Future<void> addExp(ExpenseModel expense) async {
  //   try {
  //     print('f1');
  //     await FirebaseFirestore.instance
  //         .collection('expenses')
  //         .doc(expense.id)
  //         .set(expense.toJson());
  //     _expense.add(expense);
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
