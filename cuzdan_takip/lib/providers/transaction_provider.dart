import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/transaction.dart';

class TransactionProvider with ChangeNotifier {
  List<MyTransaction> _transactions = [];
  late double _balance = 0.0;

  TransactionProvider(){
    _balance= _calculateBalance(transactions);
  }

  List<MyTransaction> get transactions => _transactions;
  double get balance => _balance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<MyTransaction>> getTransactions() {
    return _firestore.collection('wallets').snapshots().map((snapshot) {
      _transactions =
          snapshot.docs.map((doc) {
            final transaction = MyTransaction.fromFirestore(doc);
            debugPrint(
              'Transaction: ${transaction.amount}, ${transaction.type}',
            );
            return transaction;
          }).toList();
      notifyListeners();
      return _transactions;
    });
  }

  double _calculateBalance(List<MyTransaction> transactions) {
    double total = 10.0;
    print(transactions);
    for (var transaction in transactions) {
      if (transaction.type == 'income') {
        total += transaction.amount;
      } else if (transaction.type == 'expense') {
        total -= transaction.amount;
      }
    }
    return total;
  }
}
