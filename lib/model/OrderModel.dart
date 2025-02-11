import 'package:commerce/model/popular.dart';

class Order {
  final String id;
  final List<OrderItem> items;
  final double totalPrice;
  final DateTime date;

  Order({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.date,
  });

  // Convertir un JSON en objet Order
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalPrice: json['totalPrice'],
      date: DateTime.parse(json['date']),
    );
  }

  // Convertir un objet Order en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((item) => item.toJson()).toList(),
      'totalPrice': totalPrice,
      'date': date.toIso8601String(),
    };
  }
}

class OrderItem {
  final Product product;
  final int quantity;

  OrderItem({
    required this.product,
    required this.quantity,
  });

  // Convertir un JSON en objet OrderItem
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'],
    );
  }

  // Convertir un objet OrderItem en JSON
  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
    };
  }
}