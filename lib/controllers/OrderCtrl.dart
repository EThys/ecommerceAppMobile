import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import '../model/OrderModel.dart';
import '../utils/StockageKeys.dart';

class OrderCtrl with ChangeNotifier {
  OrderCtrl({this.stockage}) {
    _loadFromLocalStorage(); // Charger les données du stockage local au démarrage
  }

  GetStorage? stockage;

  List<Order> _validatedOrders = [];

  // Getter pour récupérer les commandes validées
  List<Order> get validatedOrders => _validatedOrders;

  // Ajouter une commande validée et sauvegarder dans le stockage local
  void addValidatedOrder(Order order) {
    _validatedOrders.add(order);
    _saveToLocalStorage(); // Sauvegarder dans le stockage local
    notifyListeners();
  }

  // Charger les commandes validées à partir du stockage local
  void _loadFromLocalStorage() {
    final ordersJson = stockage?.read(StockageKeys.orders); // Utiliser la clé appropriée (orders)
    if (ordersJson != null) {
      final List<dynamic> decodedOrders = json.decode(ordersJson);
      _validatedOrders = decodedOrders.map((order) => Order.fromJson(order)).toList();
      notifyListeners();
    }
  }

  // Sauvegarder les commandes validées dans le stockage local
  void _saveToLocalStorage() {
    final ordersJson = json.encode(_validatedOrders.map((order) => order.toJson()).toList());
    stockage?.write(StockageKeys.orders, ordersJson);
  }
}