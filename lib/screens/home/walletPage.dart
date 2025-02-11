import 'package:commerce/utils/StockageKeys.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/Routes.dart';
import '../../utils/card.dart';
import '../../utils/list_title.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  // Page controller
  final pageController = PageController();

  // GetStorage instance
  final storage = GetStorage();
  var token;


  // List of cards
  List<Map<String, dynamic>> cards = [
    {
      'balance': 0.0,
      'cardNumber': 12345678,
      'expiredMonth': 10,
      'expiredYear': 25,
      'color': Colors.blue[300],
      'cardType': 'assets/icons/visa.png',
    },
    {
      'balance': 0.0,
      'cardNumber': 41435211,
      'expiredMonth': 12,
      'expiredYear': 30,
      'color': Colors.red[300],
      'cardType': 'assets/icons/mastercard.png',
    },
    {
      'balance': 0.0,
      'cardNumber': 853344650,
      'expiredMonth': 2,
      'expiredYear': 30,
      'color': Colors.amber[700],
      'cardType': 'assets/icons/orange.png',
    },
    {
      'balance': 0.0,
      'cardNumber': 853344650,
      'expiredMonth': 8,
      'expiredYear': 28,
      'color': Colors.red[600],
      'cardType': 'assets/icons/airtel.png',
    },
  ];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadBalances();
  }

  void _saveBalances() {
    List<Map<String, dynamic>> cardData = cards.map((card) {
      return {
        'balance': card['balance'],
        'cardNumber': card['cardNumber'],
        'expiredMonth': card['expiredMonth'],
        'expiredYear': card['expiredYear'],
        'color': card['color']?.value,
        'cardType': card['cardType'],
      };
    }).toList();

    storage.write(StockageKeys.cards, cardData);
  }

  void _loadBalances() {
    List<dynamic>? storedCards = storage.read<List<dynamic>>('cards');

    if (storedCards != null) {
      setState(() {
        cards = storedCards.map((card) {
          return {
            'balance': card['balance'],
            'cardNumber': card['cardNumber'],
            'expiredMonth': card['expiredMonth'],
            'expiredYear': card['expiredYear'],
            'color': Color(card['color']),
            'cardType': card['cardType'],
          };
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // App bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Text(
                        "Mes",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        " Cartes",
                        style: TextStyle(
                          fontSize: 28,
                        ),
                      ),
                    ],
                  ),
                  // Plus button
                  GestureDetector(
                    onTap: (){
                      token= storage.read(StockageKeys.tokenKey);
                      print(token);
                      if(token!=null){
                        _showRavitaillerDialog();
                      }else{
                        Navigator.pushNamed(context, Routes.logInScreenRoute);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Cards
            Container(
              height: 200,
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                children: cards.map((card) {
                  return MyCard(
                    balance: card['balance'],
                    cardNumber: card['cardNumber'],
                    expiredMonth: card['expiredMonth'],
                    expiredYear: card['expiredYear'],
                    color: card['color'],
                    cardType: card['cardType'],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            // Page indicator
            SmoothPageIndicator(
              controller: pageController,
              count: cards.length,
              effect: ExpandingDotsEffect(
                activeDotColor: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 35),
            // List tiles
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: const [
                  MyListTile(
                    iconPath: "assets/icons/statistics.png",
                    title: "Statistique",
                    subTitle: "Paiement & Achat",
                  ),
                  MyListTile(
                    iconPath: "assets/icons/transaction.png",
                    title: "Transactions",
                    subTitle: "Paiement & Achat",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Show dialog to add money
  void _showRavitaillerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double montant = 0;
        return AlertDialog(
          title: const Text('Ravitailler le compte'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Montant'),
            onChanged: (value) {
              montant = double.tryParse(value) ?? 0;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirmer'),
              onPressed: () {
                setState(() {
                  cards[currentIndex]['balance'] += montant;
                });
                _saveBalances(); // Save changes
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
