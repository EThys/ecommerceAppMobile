import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

import 'apps/MonApplication.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
        (_) => runApp( MonApplication()),
  );
}
