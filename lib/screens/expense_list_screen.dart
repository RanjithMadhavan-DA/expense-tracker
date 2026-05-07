// import 'package:expense/provider/expense_provider.dart';
import '../models/expense_model.dart';

import '../utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/expense_provider.dart';
import '../screens/add_expense_form.dart';
// import '../service/api_service.dart';
import '../screens/dashboard.dart';
// import '../utils/app_theme.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  @override
  Widget build(BuildContext context) {
    // final provider = context.watch<ExpenseProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,

        title: Text('Expense List', style: AppTextStyles.appbarTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.dashboard),
            color: AppColors.background,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DashboardScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                context.read<ExpenseProvider>().searchExpense(value);
              },
              decoration: InputDecoration(
                hintText: 'Search expenses...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    showFilterDialog(context);
                  },
                  icon: Icon(Icons.tune),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<ExpenseProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (provider.expense.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox, size: 60, color: Colors.grey),
                        SizedBox(height: 10),
                        Text("No expenses yet"),
                        Text("Add your first expense"),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: provider.expense.length,
                  itemBuilder: (context, index) {
                    final expense = provider.expense[index];
                    return Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      padding: EdgeInsets.all(AppDimens.padding),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(AppDimens.radius),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(expense.title, style: AppTextStyles.title),
                                SizedBox(height: 4),
                                Text(
                                  expense.category,
                                  style: AppTextStyles.subtitle,
                                ),
                                SizedBox(height: 4),
                              ],
                            ),
                          ),
                          Text(
                            "₹${expense.amount}",
                            style: AppTextStyles.amount,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddExpenseScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget filterOption(BuildContext context, String value) {
  return ListTile(
    title: Text(value),
    onTap: () {
      context.read<ExpenseProvider>().filterCategory(value);
      Navigator.pop(context);
    },
  );
}

Widget paymentOption(BuildContext context, PaymentMethod method) {
  return ListTile(
    title: Text(method.name.toUpperCase()),
    onTap: () {
      context.read<ExpenseProvider>().filterPayment(method);
      Navigator.pop(context);
    },
  );
}

void showFilterDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Filter"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Category"),
              filterOption(context, "All"),
              filterOption(context, "Food"),
              filterOption(context, "Entertainement"),
              filterOption(context, "Shopping"),
              filterOption(context, "Bills"),
              filterOption(context, "Medicine"),
              filterOption(context, "Travel"),
              filterOption(context, "Others"),

              SizedBox(height: 10),

              Text("Payment"),
              paymentOption(context, PaymentMethod.cash),
              paymentOption(context, PaymentMethod.card),
              paymentOption(context, PaymentMethod.upi),
            ],
          ),
        ),
      );
    },
  );
}
