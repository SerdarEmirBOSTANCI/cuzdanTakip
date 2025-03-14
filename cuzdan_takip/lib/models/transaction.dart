import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class MyTransaction {
  final double amount;
  final String type;

  MyTransaction({
    required this.amount,
    required this.type,
  });

  factory MyTransaction.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    if (data == null) {
      debugPrint('Firestore belgesi boş veya null.');
      return MyTransaction(amount: 0.0, type: 'unknown');
    }

    debugPrint('Firestore belgesi: $data');
    return MyTransaction(
      amount: data['amount' ?? 0.0],
      type: data['type' ?? 'unknown'],
    );
  }
}
