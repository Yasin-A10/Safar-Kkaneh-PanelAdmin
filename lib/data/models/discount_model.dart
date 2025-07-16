class DiscountModel {
  final int id;
  final String title;
  final String code;
  final int discountPercentage;
  final String startDate;
  final String endDate;
  final String? description;
  final String createdAt;
  final String? updatedAt;

  DiscountModel({
    required this.id,
    required this.title,
    required this.code,
    required this.discountPercentage,
    required this.startDate,
    required this.endDate,
    this.description,
    required this.createdAt,
    this.updatedAt,
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json) {
    return DiscountModel(
      id: json['id'],
      title: json['title'],
      code: json['code'],
      discountPercentage: json['discount_percentage'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
