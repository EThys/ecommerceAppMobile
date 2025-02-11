class SpecialOffer {
  final String discount;
  final String title;
  final String detail;
  final String icon;

  SpecialOffer({
    required this.discount,
    required this.title,
    required this.detail,
    required this.icon,
  });
}

final homeSpecialOffers = <SpecialOffer>[
  SpecialOffer(
    discount: '25%',
    title: "Juste pour toi!",
    detail: '',
    icon: 'assets/icons/products/sofa.png',
  ),
  SpecialOffer(
    discount: '35%',
    title: "Demain sera meilleur",
    detail: '',
    icon: 'assets/icons/products/shiny_chair.png',
  ),
  SpecialOffer(
    discount: '100%',
    title: "Meme dans le noir tu peux etudier!",
    detail: '',
    icon: 'assets/icons/products/lamp.png',
  ),
  SpecialOffer(
    discount: '75%',
    title: "Un choix unique!",
    detail: '',
    icon: 'assets/icons/products/plastic_chair@2x.png',
  ),
  SpecialOffer(
    discount: '65%',
    title: "Pour votre maison",
    detail: '',
    icon: 'assets/icons/products/book_case@2x.png',
  ),
];
