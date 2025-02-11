import 'package:commerce/screens/detail/cart/CartScreen.dart';
import 'package:commerce/screens/detail/detail_screen.dart';
import 'package:commerce/screens/home/home.dart';
import 'package:commerce/screens/home/login.dart';
import 'package:commerce/screens/home/orderScreen.dart';
import 'package:commerce/screens/home/register.dart';
import 'package:commerce/screens/home/walletPage.dart';
import 'package:commerce/screens/mostpopular/most_popular_screen.dart';
import 'package:commerce/screens/onboarding/OnboardingScreen.dart';
import 'package:commerce/screens/profile/profile_screen.dart';
import 'package:commerce/screens/special_offers/special_offers_screen.dart';
import 'package:flutter/material.dart';
import '../model/popular.dart';
import '../screens/tabbar/tabbar.dart';
import 'Routes.dart';

class RoutesManager {
  static Route route(RouteSettings r) {
    switch (r.name) {
        case Routes.logInScreenRoute:
      return MaterialPageRoute(builder: (_)=>LoginScreen());
      case Routes.signUpScreenRoute:
        return MaterialPageRoute(builder: (_)=>RegisterScreen());
      case Routes.cartRoute:
        return MaterialPageRoute(builder: (_)=>CartScreen());
      case Routes.purchaseRoute:
        return MaterialPageRoute(builder: (_)=>OrderScreen());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_)=>FRTabbarScreen());
      case Routes.specialRoute:
        return MaterialPageRoute(builder: (_)=>SpecialOfferScreen());
      case Routes.mostPopularRoute:
        return MaterialPageRoute(builder: (_)=>MostPopularScreen());
      case Routes.profileRoute:
        return MaterialPageRoute(builder: (_)=>ProfileScreen());
      case Routes.onbordingScreenRoute:
        return MaterialPageRoute(builder: (_)=>OnboardingScreen());
      case Routes.detailProductRoute:
        final Product product = r.arguments as Product;
        return MaterialPageRoute(builder: (context) => ShopDetailScreen(product: product));
      default:
        return MaterialPageRoute(builder: (_) =>LoginScreen());
    }
  }
}
