// import 'package:expense/provider/expense_provider.dart';
import 'dart:convert';

import '../models/expense_model.dart';
import '../utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/expense_provider.dart';
import 'package:uuid/uuid.dart';
// import '../service/api_service.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  String selectedCategory = "Food";
  PaymentMethod selectedPayment = PaymentMethod.cash;

  void addExpense() async {
    if (!_formKey.currentState!.validate()) return;
    final expense = ExpenseModel(
      id: Uuid().v4(),
      title: _titleController.text,
      amount: double.parse(_amountController.text),
      category: selectedCategory,
      date: DateTime.now(),
      paymentMethod: selectedPayment,
      note: _noteController.text,
    );
    await context.read<ExpenseProvider>().addExpense(expense);
    // await context.read<ExpenseProvider>().addExp(expense);
    print(jsonEncode(expense));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // final provider = context.watch<ExpenseProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,

        title: Text('Expense List', style: AppTextStyles.appbarTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          prefixIcon: Icon(Icons.title),
                          border: AppInput.border,
                          focusedBorder: AppInput.border,
                          enabledBorder: AppInput.border,
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Enter the title" : null,
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          prefixIcon: Icon(Icons.currency_rupee),
                          border: AppInput.border,
                          focusedBorder: AppInput.border,
                          enabledBorder: AppInput.border,
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Enter amount" : null,
                      ),
                      SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: selectedCategory,
                        items:
                            [
                                  "Food",
                                  "Entertainement",
                                  "Shopping",
                                  "Bills",
                                  "Medicine",
                                  "Travel",
                                  "Others",
                                ]
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Category",
                          prefixIcon: Icon(Icons.category),
                          border: AppInput.border,
                          focusedBorder: AppInput.border,
                          enabledBorder: AppInput.border,
                        ),
                      ),
                      SizedBox(height: 12),
                      DropdownButtonFormField<PaymentMethod>(
                        value: selectedPayment,

                        items: PaymentMethod.values.map((method) {
                          return DropdownMenuItem(
                            value: method,
                            child: Text(method.name.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedPayment = value!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Payment Method",
                          prefixIcon: Icon(Icons.payment),
                          border: AppInput.border,
                          focusedBorder: AppInput.border,
                          enabledBorder: AppInput.border,
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: _noteController,
                        decoration: InputDecoration(
                          labelText: 'description',
                          prefixIcon: Icon(Icons.note),
                          border: AppInput.border,
                          focusedBorder: AppInput.border,
                          enabledBorder: AppInput.border,
                        ),
                      ),

                      // ElevatedButton(
                      //   onPressed: () {
                      //     addExpense();
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       SnackBar(content: Text("Expense added successfully")),
                      //     );
                      //   },
                      //   child: Text('Add'),
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      addExpense();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Expense added successfully")),
                      );
                    },
                    child: Text(
                      "Add Expense",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
