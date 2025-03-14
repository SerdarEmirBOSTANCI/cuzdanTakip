import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuzdan_takip/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTransactionView extends StatelessWidget {
  final amountController = TextEditingController();
  final typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TransactionProvider(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Gelir/Gider Ekle')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<TransactionProvider>(
            builder: (context, viewModel, child) {
              return Column(
                children: [
                  TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Miktar'),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: typeController,
                    decoration: const InputDecoration(hintText: 'Tür'),
                  ),
                  ElevatedButton(
                      onPressed: (){
                        CollectionReference collRef = FirebaseFirestore.instance.collection('wallets');
                        collRef.add({
                          'amount': amountController.text,
                          'type': typeController.text,
                        });
                      }, 
                      child: Text('Kaydet'))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
