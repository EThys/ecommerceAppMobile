import 'package:flutter/material.dart';
import 'package:commerce/constants.dart';
import 'package:commerce/screens/profile/profile_screen.dart';
import 'package:get_storage/get_storage.dart';
import '../../utils/StockageKeys.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  final storage = GetStorage();
  String _userName = 'Visiteur'; // Default name

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }


  Future<void> _loadUserName() async{
    final name = await storage.read(StockageKeys.userKey)?['firstName'];
    setState(() {
      _userName = name ?? 'Visiteur';
    });
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            onTap: () => Navigator.pushNamed(context, ProfileScreen.route()),
            child: const CircleAvatar(
              backgroundImage: AssetImage('$kIconPath/me.png'),
              radius: 24,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Bonjour👋',
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _userName,
                    style: const TextStyle(
                      color: Color(0xFF212121),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            iconSize: 10,
            icon: Image.asset('$kIconPath/notification.png'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
