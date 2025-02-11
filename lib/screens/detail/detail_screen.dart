import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:commerce/size_config.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import '../../controllers/CartCtrl.dart';
import '../../model/popular.dart';
import '../../utils/Routes.dart';
import '../../utils/StockageKeys.dart';

class ShopDetailScreen extends StatefulWidget {
  final Product ? product;

  const ShopDetailScreen({Key? key, required this.product}) : super(key: key);

  static String route() => '/shop_detail';

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  int _quantity = 0;
  bool _iscollected = false;
  double _dynamicPrice = 0.0;
  final CartCtrl cart = CartCtrl();
  var _stockage = GetStorage();
  var token;



  @override
  Widget build(BuildContext context) {
    var product=widget.product;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: getProportionateScreenHeight(428),
                  leading: IconButton(
                    icon: Image.asset('assets/icons/back@2x.png', scale: 2),
                    onPressed: () => Navigator.pop(context),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      color: const Color(0xFFeeeeee),
                      child: Image.asset(
                        product!.icon,
                        fit: BoxFit.none, width: 40, height: 40
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ..._buildTitle(),
                        const SizedBox(height: 16),
                        _buildLine(),
                        const SizedBox(height: 16),
                        ..._buildDescription(),
                        const SizedBox(height: 24),
                        _buildQuantity(),
                        const SizedBox(height: 115),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            _buldFloatBar()
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTitle() {
    var product=widget.product;
    return <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            child: Text(
              product?.title ?? 'Unknown Product', // Affiche dynamiquement le titre ou un texte par défaut
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () => setState(() => _iscollected = !_iscollected),
              icon: Image.asset(
                'assets/icons/${_iscollected ? 'bold' : 'light'}/heart@2x.png',
              ),
              iconSize: 20,
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: Color(0xFFeeeeee),
            ),
            child: Text(
              '${widget.product?.sold ?? 0} ventes', // Affiche dynamiquement le nombre de ventes
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 16),
          Image.asset('assets/icons/start@2x.png', height: 20, width: 20),
          const SizedBox(width: 8),
          Text(
            '${widget.product?.star ?? 0.0} (${widget.product?.sold ?? 0} vues)', // Note et vues dynamiques
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ];
  }

  Widget _buildLine() {
    return Container(height: 1, color: const Color(0xFFEEEEEE));
  }

  List<Widget> _buildDescription() {
    var product=widget.product;
    return [
      const Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      ExpandableText(
        product?.description ?? 'Unknown Product',
        expandText: 'voir plus',
        collapseText: 'voir moins',
        linkStyle: const TextStyle(color: Color(0xFF424242), fontWeight: FontWeight.bold),
      ),
    ];
  }

  Widget _buildQuantity() {
    return Row(
      children: [
        const Text('Quantité', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(width: 20),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            color: Color(0xFFF3F3F3),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Material(
            color: Colors.transparent,
            child: Row(
              children: [
                InkWell(
                  child: Image.asset('assets/icons/detail/minus@2x.png', scale: 2),
                  onTap: () {
                    if (_quantity <= 0) return;
                    setState(() {
                      _quantity -= 1;
                      _dynamicPrice = _quantity * widget.product!.price;
                    });
                  },
                ),
                const SizedBox(width: 20),
                Text('$_quantity',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )),
                const SizedBox(width: 20),
                InkWell(
                  child: Image.asset('assets/icons/detail/plus@2x.png', scale: 2),
                  onTap: () {
                    setState(() {
                      _quantity += 1;
                      _dynamicPrice = _quantity * widget.product!.price;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buldFloatBar() {
    var product = widget.product;
    buildAddCard() => Container(
      height: 58,
      width: getProportionateScreenWidth(258),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: Colors.purple.shade700,
        boxShadow: [
          BoxShadow(
            offset: const Offset(4, 8),
            blurRadius: 20,
            color: const Color(0xFF101010).withOpacity(0.25),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(29)),
          onTap: () {
            if (_quantity > 0) {
             token= _stockage.read(StockageKeys.tokenKey);
               if(token!=null){
                 final cart = Provider.of<CartCtrl>(context, listen: false);
                 cart.addItem(widget.product!, _quantity);
                 print("Produit ajouté avec quantité $_quantity");
                 Navigator.pushNamed(context, Routes.cartRoute);
               }else{
                 Navigator.pushNamed(context, Routes.logInScreenRoute);
               }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Veuillez sélectionner une quantité > 0")),
              );
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/detail/bag@2x.png', scale: 2),
              const SizedBox(width: 16),
              const Text(
                'Ajouter au panier',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            _buildLine(),
            const SizedBox(height: 21),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Prix total', style: TextStyle(color: Color(0xFF757575), fontSize: 12)),
                    const SizedBox(height: 6),
                    Text('${_dynamicPrice.toStringAsFixed(2)}\$', style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  ],
                ),
                buildAddCard()
              ],
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}

// class ExpandableText extends StatefulWidget {
//   ExpandableText({this.text = ""});
//   //text is the total text of our expandable widget
//   final String text;
//   @override
//   _ExpandableTextState createState() => _ExpandableTextState();
// }

// class _ExpandableTextState extends State<ExpandableText> {
//   static const viewMore = ' view more...';
//   static const fixedLength = 50;
//   late String textToDisplay;
//   @override
//   void initState() {
//     //if the text has more than a certain number of characters, the text we display will consist of that number of characters;
//     //if it's not longer we display all the text
//     print(widget.text.length);

//     //we arbitrarily chose 25 as the length
//     textToDisplay = widget.text.length > 25 ? widget.text.substring(0, 25) + viewMore : widget.text;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       child: Text(textToDisplay),
//       onTap: () {
//         //if the text is not expanded we show it all
//         if (widget.text.length > 25 && textToDisplay.length <= (25 + viewMore.length)) {
//           setState(() {
//             textToDisplay = widget.text;
//           });
//         }
//         //else if the text is already expanded we contract it back
//         else if (widget.text.length > 25) {
//           setState(() {
//             textToDisplay = widget.text.substring(0, 25) + viewMore;
//           });
//         }
//       },
//     );
//   }
// }
