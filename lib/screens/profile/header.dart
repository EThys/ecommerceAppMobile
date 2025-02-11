import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/StockageKeys.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  final storage = GetStorage();
  String _token = '';

  @override
  void initState() {
    super.initState();
    _loadToken();
  }


  Future<void> _loadToken() async{
    final token = await storage.read(StockageKeys.tokenKey);
    setState(() {
      _token = token ?? 'No Token';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Image.asset('assets/icons/profile/logo@2x.png', scale: 2),
              const SizedBox(width: 16),
              const Expanded(
                child: Text('Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              IconButton(
                iconSize: 28,
                icon: Image.asset('assets/icons/tabbar/light/more_circle@2x.png', scale: 2),
                onPressed: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Stack(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/icons/me.png'),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  child: Image.asset('assets/icons/profile/edit_square@2x.png', scale: 2),
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          "${storage.read(StockageKeys.userKey)?['firstName'] ?? 'User'} ${storage.read(StockageKeys.userKey)?['lastName'] ?? ''}",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 8),
        Text("${storage.read(StockageKeys.userKey)?['phone'] ?? '0000000000'}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 20),
        Container(
          color: const Color(0xFFEEEEEE),
          height: 1,
          padding: const EdgeInsets.symmetric(horizontal: 24),
        )
      ],
    );
  }
}
