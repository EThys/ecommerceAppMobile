// Widget pour afficher l'effet Shimmer (pendant le chargement)
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget _buildShimmerEffect() {
  return ListView.builder(
    itemCount: 5, // Nombre d'éléments simulés pendant le chargement
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
