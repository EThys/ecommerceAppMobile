import 'package:flutter/material.dart';
import 'package:commerce/screens/detail/detail_screen.dart';
import 'package:commerce/screens/home/home.dart';
import 'package:commerce/screens/mostpopular/most_popular_screen.dart';
import 'package:commerce/screens/profile/profile_screen.dart';
import 'package:commerce/screens/special_offers/special_offers_screen.dart';
import 'package:commerce/screens/test/test_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.route(): (context) => const HomeScreen(title: '123'),
  MostPopularScreen.route(): (context) => const MostPopularScreen(),
  ProfileScreen.route(): (context) => const ProfileScreen(),
  //ShopDetailScreen.route(): (context) => const ShopDetailScreen(product: product,),
  TestScreen.route(): (context) => const TestScreen(),
};
