import 'dart:convert';
import 'package:http/http.dart ' as http;
import '../models/expense_model.dart';

class ApiService {
  final String baseUrl = "https://fakestoreapi.com/products";

  Future<List<ExpenseModel>> fetchExpense() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((e) {
          return ExpenseModel(
            id: e['id'].toString(),
            title: e['title'] ?? '',
            amount: double.parse(e['price'].toString()) ?? 0,
            category: e['category'] ?? 'Others',
            date: DateTime.now(),
            note: e['description'],
            paymentMethod: PaymentMethod.cash,
          );
        }).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error $e');
    }
  }

  //  Post method
  Future<void> insertExpense(ExpenseModel expense) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(expense.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to add expense");
    }
  }
}
