class DiscountModel {
  final int id;
  final String title;
  final String code;
  final int discountValue;
  final String startDate;
  final String endDate;

  DiscountModel({
    required this.id,
    required this.title,
    required this.code,
    required this.discountValue,
    required this.startDate,
    required this.endDate,
  });
}
