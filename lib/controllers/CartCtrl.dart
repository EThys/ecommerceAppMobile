import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../model/popular.dart';
import '../model/CartModel.dart';
import '../model/paymentCard.dart';
import '../utils/StockageKeys.dart';

class CartCtrl with ChangeNotifier {
  CartCtrl({this.stockage}) {
    _loadFromLocalStorage(); // Charger les données du stockage local au démarrage
  }

  GetStorage? stockage;

  final List<CartModel> _items = [];
  PaymentCard? selectedCard; // Carte sélectionnée

  // Getter pour les items du panier
  List<CartModel> get items => _items;

  // Calcul du prix total
  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));

  // Liste des cartes de paiement
  List<Map<String, dynamic>> cards = [];
  int selectedCardIndex = -1; // Index de la carte sélectionnée

  void setCards(List<Map<String, dynamic>> newCards) {
    cards = newCards;
    notifyListeners();
  }

  // Sélectionner une carte
  void selectCard(PaymentCard card) {
    selectedCard = card;
    notifyListeners();
  }

  Map<String, dynamic>? get selectedCards {
    return selectedCardIndex >= 0 && selectedCardIndex < cards.length
        ? cards[selectedCardIndex]
        : null;
  }

  // Ajouter un item dans le panier
  void addItem(Product product, int quantity) {
      _items.add(CartModel(product: product, quantity: quantity));
    _saveToLocalStorage(); // Sauvegarder dans le stockage local
    notifyListeners();
  }

  // Supprimer un item du panier
  void removeItemAtIndex(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      _saveToLocalStorage(); // Sauvegarder dans le stockage local
      notifyListeners();
    }
  }

  // Modifier la quantité d'un produit
  void updateQuantity(Product product, int quantity) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity = quantity;
      _saveToLocalStorage(); // Sauvegarder dans le stockage local
      notifyListeners();
    }
  }

  // Charger les données du stockage local
  void _loadFromLocalStorage() {
    final cartJson = stockage?.read(StockageKeys.carts);
    if (cartJson != null) {
      final List<dynamic> decodedItems = json.decode(cartJson);
      _items.clear();
      _items.addAll(decodedItems.map((item) => CartModel.fromJson(item)));
      notifyListeners();
    }
  }

  // Sauvegarder les items dans le stockage local
  void _saveToLocalStorage() {
    final cartJson = json.encode(_items.map((item) => item.toJson()).toList());
    stockage?.write(StockageKeys.carts, cartJson);
  }
}
