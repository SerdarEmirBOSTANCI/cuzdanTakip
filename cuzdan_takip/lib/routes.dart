import 'package:cuzdan_takip/views/home/add_transaction_view.dart';
import 'package:flutter/material.dart';
import 'views/home/home_view.dart';

final Map<String, WidgetBuilder> routes = {
  '/home': (context) => HomeView(),
  '/add_transaction': (context) => AddTransactionView(),
};


