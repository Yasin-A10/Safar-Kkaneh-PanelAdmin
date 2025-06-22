class ReservationModel {
  final int id;
  final String title;
  final String? city;
  final String? province;
  final String? startDate;
  final String? endDate;
  final int price;
  final int capacity;
  final int? roomCount;
  final String? managerName;
  final int? managerPhoneNumber;
  final int? guestCount;
  final String? booker;
  final String? bookerEmail;
  final int? bookerPhoneNumber;
  final int? cleaningFee;
  final int? serviceFee;
  final int totalFee;
  final List<TransactionModel>? transactions;

  ReservationModel({
    required this.id,
    required this.title,
    this.city,
    this.province,
    this.startDate,
    this.endDate,
    required this.price,
    required this.capacity,
    this.roomCount,
    this.managerName,
    this.managerPhoneNumber,
    this.guestCount,
    this.booker,
    this.bookerEmail,
    this.bookerPhoneNumber,
    this.cleaningFee,
    this.serviceFee,
    required this.totalFee,
    this.transactions = const [],
  });
}

// transaction model
class TransactionModel {
  final String transactionId;
  final bool transactionStatus;
  final int transactionFee;
  final String createdAt;

  TransactionModel({
    required this.transactionId,
    required this.transactionStatus,
    required this.transactionFee,
    required this.createdAt,
  });
}
