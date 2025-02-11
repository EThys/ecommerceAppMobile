// Classe CartModel pour stocker un produit et sa quantité
import 'package:commerce/model/popular.dart';

class CartModel {
  final Product product;
  int quantity;

  CartModel({required this.product, required this.quantity});

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
    };
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }
}