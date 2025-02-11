import 'package:flutter/material.dart';
import 'package:commerce/components/product_card.dart';
import 'package:commerce/model/popular.dart';
import 'package:commerce/screens/home/hearder.dart';
import 'package:commerce/screens/home/most_popular.dart';
import 'package:commerce/screens/home/search_field.dart';
import 'package:commerce/screens/home/special_offer.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/Routes.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  static String route() => '/home';

  const HomeScreen({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final datas = homePopularProducts;
  List<Product> filteredProducts = homePopularProducts;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Simuler un chargement de 2 secondes
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.fromLTRB(24, 24, 24, 0);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverPadding(
            padding: EdgeInsets.only(top: 24),
            sliver: SliverAppBar(
              pinned: true,
              flexibleSpace: HomeAppBar(),
            ),
          ),
          SliverPadding(
            padding: padding,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                ((context, index) => _isLoading ? _buildShimmerBody(context) : _buildBody(context)),
                childCount: 1,
              ),
            ),
          ),
          SliverPadding(
            padding: padding,
              sliver: _isLoading ? _buildShimmerPopulars(): _buildPopulars(),
          ),
          const SliverAppBar(flexibleSpace: SizedBox(height: 24))
        ],
      ),
    );
  }

  Widget _buildShimmerPopulars() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 185,
        mainAxisSpacing: 24,
        crossAxisSpacing: 16,
        mainAxisExtent: 285,
      ),
      delegate: SliverChildBuilderDelegate(
            (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            color: Colors.white,
          ),
        ),
        childCount: 6,
      ),
    );
  }

  Widget _buildShimmerBody(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Container(
            height: 50,
            color: Colors.white,
          ),
          const SizedBox(height: 24),
          Container(
            height: 150,
            color: Colors.white,
          ),
          const SizedBox(height: 24),
          Container(
            height: 30,
            color: Colors.white,
          ),
          const SizedBox(height: 24),
          Container(
            height: 50,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        const SearchField(),
        const SizedBox(height: 24),
        SpecialOffers(onTapSeeAll: () => _onTapSpecialOffersSeeAll(context)),
        const SizedBox(height: 24),
        MostPopularTitle(onTapseeAll: () => _onTapMostPopularSeeAll(context)),
        const SizedBox(height: 24),
        const MostPupularCategory(),
      ],
    );
  }

  Widget _buildPopulars() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 185,
        mainAxisSpacing: 24,
        crossAxisSpacing: 16,
        mainAxisExtent: 285,
      ),
      delegate: SliverChildBuilderDelegate(
            (context, index) => _buildPopularItem(context, index),
        childCount: filteredProducts.length,
      ),
    );
  }

  Widget _buildPopularItem(BuildContext context, int index) {
    final data = datas[index % datas.length];
    return ProductCard(
      data: data,
      ontap: (data) => Navigator.pushNamed(
        context,
        Routes.detailProductRoute,
        arguments: data,
      ),
    );
  }

  void _onTapMostPopularSeeAll(BuildContext context) {
    Navigator.pushNamed(context, Routes.mostPopularRoute);
  }

  void _onTapSpecialOffersSeeAll(BuildContext context) {
    Navigator.pushNamed(context, Routes.specialRoute);
  }
}
