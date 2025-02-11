class PaymentCard {
  final String cardNumber;
  double balance;
  final int expiredMonth;
  final int expiredYear;
  final String cardType;

  PaymentCard({
    required this.cardNumber,
    required this.balance,
    required this.expiredMonth,
    required this.expiredYear,
    required this.cardType,
  });
}
