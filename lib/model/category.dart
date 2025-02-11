class Category {
  const Category(this.icon, this.title, this.id);

  final String icon;
  final String title;
  final String id;
}

final homeCategries = <Category>[
  const Category('assets/icons/category_sofa@2x.png', 'Canapé', 'canape'),
  const Category('assets/icons/category_chair@2x.png', 'Chaise', 'chaise'),
  const Category('assets/icons/category_table@2x.png', 'Table', 'table'),
  const Category('assets/icons/category_kitchen@2x.png', 'Cuisine', 'cuisine'),
  const Category('assets/icons/category_lamp@2x.png', 'Lampe', 'lampe'),
  const Category('assets/icons/category_cupboard@2x.png', 'Placard', 'placard'),
  const Category('assets/icons/category_vase@2x.png', 'Vase', 'vase'),
  const Category('assets/icons/category_others@2x.png', 'Autres', 'autres'),
];
