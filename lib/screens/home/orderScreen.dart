import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../controllers/OrderCtrl.dart';
import '../../model/OrderModel.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _simulateLoading();
  }

  void _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderCtrl = Provider.of<OrderCtrl>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes commandes'),
        centerTitle: true,
      ),
      body: _isLoading
          ? _buildShimmerEffect(orderCtrl)
          : orderCtrl.validatedOrders.isEmpty
          ? _buildEmptyOrder()
          : _buildOrderList(orderCtrl),
    );
  }

  Widget _buildShimmerEffect(OrderCtrl orderCtrl,) {
    return ListView.builder(
      itemCount: orderCtrl.validatedOrders.length, // Nombre d'éléments simulés pendant le chargement
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

  Widget _buildEmptyOrder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long, size: 100, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'Vous n\'avez pas encore de commandes.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList(OrderCtrl orderCtrl) {
    return ListView.builder(
      itemCount: orderCtrl.validatedOrders.length,
      itemBuilder: (context, index) {
        final order = orderCtrl.validatedOrders[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ExpansionTile(
            title: Text(
              "Commande #${order.id}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Total: ${order.totalPrice.toStringAsFixed(2)} \$",
              style: const TextStyle(color: Colors.green),
            ),
            children: order.items
                .map((item) => _buildOrderItemTile(item))
                .toList(),
          ),
        );
      },
    );
  }

  Widget _buildOrderItemTile(OrderItem item) {
    return ListTile(
      title: Text(item.product.title),
      subtitle: Text("Quantité: ${item.quantity}"),
      trailing: Text(
        "${(item.product.price * item.quantity).toStringAsFixed(2)} \$",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
