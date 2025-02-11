import 'package:commerce/controllers/OrderCtrl.dart';
import 'package:commerce/model/paymentCard.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import '../../../controllers/CardCtrl.dart';
import '../../../controllers/CartCtrl.dart';
import '../../../model/CartModel.dart';
import '../../../model/OrderModel.dart';
import '../../../utils/Routes.dart';
import '../../../utils/StockageKeys.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final storage = GetStorage();
  List<dynamic>? storedCards; // Liste des cartes stockées

  bool _isLoading = true; // Indicateur de chargement

  @override
  void initState() {
    super.initState();
    _simulateLoading(); // Simuler un délai de chargement
    _loadStoredCards();
  }

  // Simuler un délai de chargement (par exemple, 2 secondes)
  void _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoading = false; // Fin du chargement
    });
  }

  // Charger les cartes depuis le stockage local
  void _loadStoredCards() {
    setState(() {
      storedCards = storage.read<List<dynamic>>(StockageKeys.cards) ?? [];
    });
  }

  // Mettre à jour le stockage local des cartes
  void _updateLocalStorage() {
    storage.write(StockageKeys.cards, storedCards);
  }

  @override
  Widget build(BuildContext context) {
    final cartCtrl = Provider.of<CartCtrl>(context); // Contrôleur du panier
    final orderCtrl = Provider.of<OrderCtrl>(context); // Contrôleur des commandes
    final cardCtrl = Provider.of<CardController>(context); // Contrôleur des cartes

    return Scaffold(
      appBar: AppBar(title: const Text('Mon Panier')),
      body: _isLoading
          ? _buildShimmerEffect(cartCtrl) // Afficher l'effet Shimmer pendant le chargement
          : cartCtrl.items.isEmpty
          ? _buildEmptyCart()
          : _buildCartList(cartCtrl,cardCtrl),
    );
  }


  Widget _buildShimmerEffect(CartCtrl cartCtrl,) {
    return ListView.builder(
      itemCount: cartCtrl.items.length, // Nombre d'éléments simulés pendant le chargement
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Container(
                height: 20,
                width: double.infinity,
                color: Colors.grey[300],
              ),
              subtitle: Container(
                height: 14,
                width: double.infinity,
                color: Colors.grey[300],
              ),
              trailing: Container(
                height: 20,
                width: 50,
                color: Colors.grey[300],
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget pour un panier vide
  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart, size: 100, color: Colors.grey),
          const SizedBox(height: 16),
          const Text('Votre panier est vide.'),
        ],
      ),
    );
  }

  // Liste des articles dans le panier
  Widget _buildCartList(CartCtrl cartCtrl, CardController cardCtrl) {
    return ListView.builder(
      itemCount: cartCtrl.items.length,
      itemBuilder: (context, index) {
        final cartItem = cartCtrl.items[index];
        final totalPrice =
        (cartItem.product.price * cartItem.quantity).toStringAsFixed(2);

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ListTile(
            title: Text(cartItem.product.title),
            subtitle: Text("$totalPrice \$"),
            onTap: () => _showCardSelectionDialog(context, cartCtrl, cardCtrl, cartItem, index),
            trailing: _buildTrailingWidget(cartCtrl, cartItem, index),
          ),
        );
      },
    );
  }

  // Actions à droite de la liste (quantité et suppression)
  Widget _buildTrailingWidget(CartCtrl cartCtrl, CartModel cartItem, int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Quantité: ${cartItem.quantity}"),
        const SizedBox(width: 10),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _removeItemFromCart(cartCtrl, cartItem, index),
          color: Colors.red,
        ),
      ],
    );
  }

  // Supprimer un article du panier
  void _removeItemFromCart(CartCtrl cartCtrl, CartModel cartItem, int index) {
    cartCtrl.removeItemAtIndex(index);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${cartItem.product.title} supprimé du panier')),
    );
  }

  // Afficher une boîte de dialogue pour sélectionner une carte
  void _showCardSelectionDialog(BuildContext context, CartCtrl cartCtrl, CardController cardCtrl,
      CartModel cartItem, int index) {
    if (storedCards == null || storedCards!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aucune carte disponible. Veuillez ajouter une carte.')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sélectionnez une carte'),
          content: SingleChildScrollView(
            child: ListBody(
              children: storedCards!.map((card) {
                return ListTile(
                  title: Text(
                    'Carte se terminant par ${card['cardNumber'].toString().substring(card['cardNumber'].toString().length - 4)}',
                  ),
                  subtitle: Text('Solde : ${card['balance'].toStringAsFixed(2)} \$'),
                  leading: Image.asset(card['cardType'], width: 40, height: 40),
                  onTap: () => _processCardSelection(context, cartCtrl, cardCtrl, cartItem, index, card),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  // Gérer la sélection d'une carte
  void _processCardSelection(BuildContext context, CartCtrl cartCtrl, CardController cardCtrl,
      CartModel cartItem, int index, Map<String, dynamic> card) {
    final totalPrice = cartItem.product.price * cartItem.quantity;

    if (card['balance'] >= totalPrice) {
      setState(() {
        card['balance'] -= totalPrice; // Déduire le prix du solde
        _updateLocalStorage(); // Mettre à jour le stockage local

        // Créer et ajouter une commande validée
        final newOrder = Order(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          items: [OrderItem(product: cartItem.product, quantity: cartItem.quantity)],
          totalPrice: totalPrice,
          date: DateTime.now(),
        );
        Provider.of<OrderCtrl>(context, listen: false).addValidatedOrder(newOrder);
        cartCtrl.removeItemAtIndex(index); // Supprimer l'article du panier
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${cartItem.product.title} ajouté à vos commandes.')),
      );

      Navigator.of(context).pop(); // Fermer la boîte de dialogue
      Navigator.pushNamed(
        context,
        Routes.purchaseRoute,
        arguments: cartItem.product,
      );
    } else {
      _showInsufficientBalanceDialog(context, cartCtrl, card);
    }
  }

  // Afficher un message si le solde de la carte est insuffisant
  void _showInsufficientBalanceDialog(BuildContext context, CartCtrl cartCtrl, Map<String, dynamic> card) {
    Navigator.of(context).pop(); // Fermer la boîte de dialogue de sélection

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Solde insuffisant'),
          content: const Text('Le solde de votre carte est insuffisant pour effectuer cet achat.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}