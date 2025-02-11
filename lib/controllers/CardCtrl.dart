import 'dart:convert';

import 'package:commerce/utils/StockageKeys.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class CardController extends ChangeNotifier {
  CardController({this.stockage});

  GetStorage? stockage;

  // Liste des cartes
  List<Map<String, dynamic>> _cards = [];
  List<Map<String, dynamic>> get cards => _cards;

  // Index de la carte actuelle
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void addBalance(double amount) {
    _cards[_currentIndex]['balance'] += amount;
    _saveCards();
    notifyListeners();
  }

  void addCard(Map<String, dynamic> card) {
    _cards.add(card);
    _saveCards();
    notifyListeners();
  }

  void removeCard(int index) {
    _cards.removeAt(index);
    if (_currentIndex >= _cards.length) {
      _currentIndex = _cards.length - 1;
    }
    _saveCards();
    notifyListeners();
  }

  void _saveCards() {
    final cardsJson = json.encode(_cards);
    stockage?.write(StockageKeys.cards, cardsJson);
    print("JSONNNNNNNNNNNNNNNNNNNNNNN: $cardsJson");
  }

}
