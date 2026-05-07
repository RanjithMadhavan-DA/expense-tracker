enum PaymentMethod { cash, card, upi, netBanking, other }

class ExpenseModel {
  String id; //unique id for every adding
  String title; //Provide title name for every entry
  double amount; //Amount payment for the expense
  String category; //its category food,sports,entertainement
  DateTime date; //issuedate
  String? note; //simple description
  PaymentMethod paymentMethod; //payment method that listed in above

  ExpenseModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    this.note,
    required this.paymentMethod,
  });

  /// FROM JSON taken for ui retriving
  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      amount: double.tryParse(json['amount'].toString()) ?? 0,
      category: json['category'] ?? 'Others',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      note: json['note'],
      paymentMethod: PaymentMethod.values.firstWhere(
        (e) => e.name == json['paymentMethod'],
        orElse: () => PaymentMethod.cash,
      ),
    );
  }

  /// TO JSON  added to api or firebase storing
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
      'note': note,
      'paymentMethod': paymentMethod.name,
    };
  }
}
