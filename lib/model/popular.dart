class PopularCategory {
  final String category;
  final String id;

  PopularCategory({this.category = '', this.id = ''});
}

class Product {
  final String title;
  final double star;
  final int sold;
  final double price;
  final String icon;
  final String id;
  final String categoryId;
  final String description;

  Product({
    this.title = '',
    this.star = 0.0,
    this.sold = 0,
    this.price = 0.0,
    this.icon = '',
    this.id = '0',
    this.categoryId = '',
    this.description = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'star': star,
      'sold': sold,
      'price': price,
      'icon': icon,
      'id': id,
      'categoryId': categoryId,
      'description': description,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      star: json['star'],
      sold: json['sold'],
      price: json['price'],
      icon: json['icon'],
      id: json['id'],
      categoryId: json['categoryId'],
      description: json['description'],
    );
  }
}

final homePopularCategories = [
  PopularCategory(category: 'Tout', id: '1'),
  PopularCategory(category: 'Chaise', id: '2'),
  PopularCategory(category: 'Cuisine', id: '3'),
  PopularCategory(category: 'Table', id: '4'),
  PopularCategory(category: 'Lampe', id: '5'),
  PopularCategory(category: 'Armoire', id: '6'),
  PopularCategory(category: 'Vase', id: '7'),
  PopularCategory(category: 'Autres', id: '8'),
];

final homePopularProducts = [
  Product(
    title: 'Chaise rembourrée en mousse',
    star: 4.5,
    sold: 8374,
    price: 120.00,
    id: '1',
    categoryId: '2', // Chaise
    icon: 'assets/icons/products/foam_padded_chair@2x.png',
    description: 'Une chaise confortable avec un rembourrage en mousse pour un soutien optimal.',
  ),
  Product(
    title: 'Petite bibliothèque',
    star: 4.7,
    sold: 7483,
    price: 145.40,
    id: '2',
    categoryId: '8', // Autres
    icon: 'assets/icons/products/book_case@2x.png',
    description: 'Une bibliothèque compacte pour ranger vos livres et objets décoratifs.',
  ),
  Product(
    title: 'Lampadaire en verre',
    star: 4.3,
    sold: 6937,
    price: 40.00,
    id: '3',
    categoryId: '5', // Lampe
    icon: 'assets/icons/products/lamp.png',
    description: 'Un lampadaire élégant en verre qui apporte une touche de modernité à votre intérieur.',
  ),
  Product(
    title: 'Ensemble en verre',
    star: 4.9,
    sold: 8174,
    price: 55.00,
    id: '4',
    categoryId: '3', // Cuisine
    icon: 'assets/icons/products/class_package@2x.png',
    description: 'Un ensemble de verres en cristal parfait pour vos soirées.',
  ),
  Product(
    title: 'Chaise en plastique',
    star: 4.6,
    sold: 6843,
    price: 65.00,
    id: '5',
    categoryId: '2', // Chaise
    icon: 'assets/icons/products/plastic_chair@2x.png',
    description: 'Chaise légère et durable, idéale pour l\'extérieur.',
  ),
  Product(
    title: 'Chaises en bois',
    star: 4.5,
    sold: 7758,
    price: 69.00,
    id: '6',
    categoryId: '2', // Chaise
    icon: 'assets/icons/products/wooden_chairs.png',
    description: 'Chaises robustes en bois, parfaites pour un décor chaleureux.',
  ),
  Product(
    title: 'Nike Air Max 90 "Just Do It"',
    star: 4.2,
    sold: 1200,
    price: 89.99,
    id: '7',
    categoryId: '8', // Autres
    icon: 'assets/images/sh1.png',
    description: 'Baskets Nike Air Max 90 avec la signature "Just Do It", légères et respirantes pour vos séances de sport intensives.',
  ),
  Product(
    title: 'Nike Air Max 270 "Just Do It"',
    star: 4.7,
    sold: 650,
    price: 129.00,
    id: '8',
    categoryId: '8', // Autres
    icon: 'assets/images/sh7.png',
    description: 'Baskets Nike Air Max 270 avec le slogan "Just Do It", parfaites pour un confort et un style sportif.',
  ),
  Product(
    title: 'Nike Air Max 1 "Just Do It"',
    star: 4.0,
    sold: 2345,
    price: 35.99,
    id: '9',
    categoryId: '8', // Autres
    icon: 'assets/images/sh3.png',
    description: 'Baskets Nike Air Max 1 avec une touche "Just Do It", idéales pour un look sportif décontracté.',
  ),
  Product(
    title: 'Nike Air Max Plus "Just Do It"',
    star: 4.8,
    sold: 890,
    price: 149.00,
    id: '10',
    categoryId: '8', // Autres
    icon: 'assets/images/sh4.png',
    description: 'Baskets Nike Air Max Plus "Just Do It", offrant un excellent support et une adhérence pour les activités sportives.',
  ),
  Product(
    title: 'Nike Air Max 95 "Just Do It"',
    star: 4.6,
    sold: 1500,
    price: 99.00,
    id: '11',
    categoryId: '8', // Autres
    icon: 'assets/images/sh5.png',
    description: 'Baskets Nike Air Max 95 avec le slogan "Just Do It", élégantes et sophistiquées pour un look sportif moderne.',
  ),
  Product(
    title: 'Sac à dos scolaire pour fille',
    star: 4.5,
    sold: 1200,
    price: 39.99,
    id: '13',
    categoryId: '8', // Autres
    icon: 'assets/images/img4.jpeg',
    description: 'Sac à dos spacieux et confortable, idéal pour l\'école avec plusieurs compartiments pour les livres et les fournitures.',
  ),
  Product(
    title: 'Pochette de soirée pour fille',
    star: 4.7,
    sold: 500,
    price: 29.99,
    id: '14',
    categoryId: '8', // Autres
    icon: 'assets/images/img2.jpeg',
    description: 'Pochette élégante pour les occasions spéciales, avec une chaîne détachable et un design brillant.',
  ),
  Product(
    title: 'Sac de sport pour fille',
    star: 4.4,
    sold: 800,
    price: 34.99,
    id: '15',
    categoryId: '8', // Autres
    icon: 'assets/images/img3.jpeg',
    description: 'Sac de sport polyvalent pour filles, parfait pour le gym ou les activités extrascolaires.',
  ),
  Product(
    title: 'Chemise à carreaux pour fille',
    star: 4.6,
    sold: 950,
    price: 24.99,
    id: '16',
    categoryId: '8', // Autres
    icon: 'assets/images/img.jpeg',
    description: 'Chemise à carreaux tendance pour filles, confortable et stylée pour un look décontracté.',
  ),
];


