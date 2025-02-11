import 'package:flutter/material.dart';
import 'package:commerce/screens/profile/header.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import '../../controllers/AuthentificationCtrl.dart';
import '../../utils/Routes.dart';
import '../../utils/StockageKeys.dart';

typedef ProfileOptionTap = void Function();

class ProfileOption {
  String title;
  String icon;
  Color? titleColor;
  ProfileOptionTap? onClick;
  Widget? trailing;

  ProfileOption({
    required this.title,
    required this.icon,
    this.onClick,
    this.titleColor,
    this.trailing,
  });

  ProfileOption.arrow({
    required this.title,
    required this.icon,
    this.onClick,
    this.titleColor = const Color(0xFF212121),
    this.trailing = const Image(image: AssetImage('assets/icons/profile/arrow_right@2x.png'), width: 24, height: 24),
  });
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static String route() => '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static _profileIcon(String last) => 'assets/icons/profile/$last';
  final storage = GetStorage();
  String _token = '';

  bool _isDark = false;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }


  Future<void> _loadToken() async {
    _token = await storage.read(StockageKeys.tokenKey) ?? '';
    setState(() {}); // Trigger a rebuild to reflect the token presence
  }

  List<ProfileOption> get datas {
    List<ProfileOption> options = [
      ProfileOption.arrow(title: "Email :  ${storage.read(StockageKeys.userKey)?['email'] ?? ""}", icon: _profileIcon('user@2x.png')),
      ProfileOption.arrow(title: "Adresse :  ${storage.read(StockageKeys.userKey)?['address'] ?? ""}", icon: _profileIcon('location@2x.png')),
      ProfileOption.arrow(title: 'Notification', icon: _profileIcon('notification@2x.png')),
      ProfileOption.arrow(title: 'Paiement', icon: _profileIcon('wallet@2x.png')),
      _languageOption(),
      _darkModel(),
      ProfileOption.arrow(title: "Centre d'aide", icon: _profileIcon('info_square@2x.png')),
    ];

    // Add the logout option only if a token exists
    if (_token.isNotEmpty) {
      options.add(
        ProfileOption(
          title: 'Se deconnecter',
          icon: _profileIcon('logout@2x.png'),
          titleColor: const Color(0xFFF75555),
          onClick: () {
            var auth = context.read<AuthentificationCtrl>();
            auth.logout({});
            storage.remove(StockageKeys.userKey);
            storage.remove(StockageKeys.tokenKey);
            Navigator.pushReplacementNamed(context, Routes.logInScreenRoute);
          },
        ),
      );
    }

    return options;
  }


  _languageOption() => ProfileOption(
      title: 'Langues',
      icon: _profileIcon('more_circle@2x.png'),
      trailing: SizedBox(
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'Français (Fr)',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Color(0xFF212121)),
            ),
            const SizedBox(width: 16),
            Image.asset('assets/icons/profile/arrow_right@2x.png', scale: 2)
          ],
        ),
      ));

  _darkModel() => ProfileOption(
      title: 'Mode sombre',
      icon: _profileIcon('show@2x.png'),
      trailing: Switch(
        value: _isDark,
        activeColor: const Color(0xFF212121),
        onChanged: (value) {
          setState(() {
            _isDark = !_isDark;
          });
        },
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverList(
            delegate: SliverChildListDelegate.fixed([
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: ProfileHeader(),
              ),
            ]),
          ),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 10.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final data = datas[index];
            return _buildOption(context, index, data);
          },
          childCount: datas.length,
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context, int index, ProfileOption data) {
    return ListTile(
      leading: Image.asset(data.icon, scale: 2),
      title: Text(
        data.title,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: data.titleColor),
      ),
      trailing: data.trailing,
      onTap: data.onClick, // Use the onClick callback
    );
  }
}
