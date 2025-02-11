import 'package:commerce/controllers/OrderCtrl.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/AuthentificationCtrl.dart';
import 'package:provider/provider.dart';
import '../controllers/CardCtrl.dart';
import '../controllers/CartCtrl.dart';
import '../theme.dart';
import '../utils/Routes.dart';
import '../utils/RoutesManager.dart';
import '../utils/StockageKeys.dart';
import '../utils/helpers/snackbar_helper.dart';

class MonApplication extends StatelessWidget {
  var _stockage = GetStorage();

  @override
  Widget build(BuildContext context) {
    bool isFirstLaunch = _stockage.read(StockageKeys.firstLaunchKey) ?? true;
    var token = _stockage.read(StockageKeys.tokenKey);

    // if (isFirstLaunch) {
    //   _stockage.write(StockageKeys.firstLaunchKey, false);
    // }


    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthentificationCtrl(stockage: _stockage)),
        ChangeNotifierProvider(create: (context) => CartCtrl(stockage: _stockage)),

        ChangeNotifierProvider(create: (context) => CardController(stockage: _stockage)),
        ChangeNotifierProvider(create: (context) => OrderCtrl(stockage: _stockage)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        onGenerateRoute: RoutesManager.route,
        themeMode: ThemeMode.light,
        scaffoldMessengerKey: SnackbarHelper.key,
        initialRoute: isFirstLaunch ? Routes.onbordingScreenRoute :  Routes.homeRoute,
      ),
    );
  }
}