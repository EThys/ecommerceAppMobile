import 'package:commerce/utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/StockageKeys.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;
  var _stockage = GetStorage();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          children: [
            buildPage(
              color: Colors.purple.shade100,
              urlImage: 'assets/images/onboard1.png',
              title: 'AJOUTER AU PANIER',
              subtitle: 'Parcourez notre large gamme de produits et ajoutez vos articles préférés au panier en quelques clics.',
            ),
            buildPage(
              color: Colors.white,
              urlImage: 'assets/images/onboard2.png',
              title: 'ACHETEZ',
              subtitle: "Profitez d'un processus de paiement sécurisé et rapide avec plusieurs options de paiement disponibles.",
            ),
            buildPage(
              color: Colors.purple.shade50,
              urlImage: 'assets/images/onboard3.png',
              title: 'LIVRAISON',
              subtitle: 'Suivez votre commande en temps réel et recevez vos achats directement à votre porte dans les meilleurs délais.',
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          backgroundColor: Colors.purple.shade700,
          minimumSize: const Size.fromHeight(80),
        ),
        child: const Text(
          'Commencer',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        onPressed: () async {
          await _stockage.write(StockageKeys.firstLaunchKey, false);
          Navigator.pushReplacementNamed(context, Routes.homeRoute);
        },
      )
          : Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: const Text('Sauter', style: TextStyle(color: Colors.purple)),
              onPressed: () => controller.jumpToPage(2),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: WormEffect(
                  spacing: 16,
                  dotColor: Colors.black26,
                  activeDotColor: Colors.purple.shade700,
                ),
                onDotClicked: (index) => controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                ),
              ),
            ),
            TextButton(
              child: const Text('Suivant', style: TextStyle(color: Colors.purple)),
              onPressed: () => controller.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPage({
    required Color color,
    required String urlImage,
    required String title,
    required String subtitle,
  }) =>
      Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              urlImage,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            const SizedBox(height: 64),
            Text(
              title,
              style: TextStyle(
                color: Colors.purple.shade700,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                subtitle,
                style: const TextStyle(color: Colors.black87),
              ),
            ),
          ],
        ),
      );
}
