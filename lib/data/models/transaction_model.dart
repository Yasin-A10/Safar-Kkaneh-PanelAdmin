class TransactionModel {
  final int id;
  final SimpleUser user;
  final SimpleResidence? residence;
  final SimpleReservation? reservation;
  final int amount;
  final String status;
  final String type;
  final String createdAt;

  TransactionModel({
    required this.id,
    required this.user,
    required this.residence,
    required this.reservation,
    required this.amount,
    required this.status,
    required this.type,
    required this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      user: SimpleUser.fromJson(json['user']),
      residence: json['Residence'] != null
          ? SimpleResidence.fromJson(json['Residence'])
          : null,
      reservation: json['reservation'] != null
          ? SimpleReservation.fromJson(json['reservation'])
          : null,
      amount: json['amount'],
      status: json['status'],
      type: json['type'],
      createdAt: json['created_at'],
    );
  }
}

class SimpleUser {
  final String fullName;
  final String phoneNumber;
  final String? email;

  SimpleUser({required this.fullName, required this.phoneNumber, this.email});

  factory SimpleUser.fromJson(Map<String, dynamic> json) {
    return SimpleUser(
      fullName: json['full_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      email: json['email'],
    );
  }
}

class SimpleResidence {
  final String title;
  final SimpleUser owner;

  SimpleResidence({required this.title, required this.owner});

  factory SimpleResidence.fromJson(Map<String, dynamic> json) {
    return SimpleResidence(
      title: json['title'] ?? '',
      owner: SimpleUser.fromJson(json['owner']),
    );
  }
}

class SimpleReservation {
  final int? id;
  final String? checkIn;
  final String? checkOut;
  final num? totalPrice;
  final int? guestCount;
  final String? status;
  final int? pricePerNight;
  final int? cleaningPrice;
  final int? servicesPrice;
  final int? maxNightsStay;
  final int? capacity;
  final String? createdAt;
  final String? updatedAt;
  final SimpleResidence? residence;
  final SimpleUser? user;

  SimpleReservation({
    this.id,
    this.checkIn,
    this.checkOut,
    this.totalPrice,
    this.guestCount,
    this.status,
    this.pricePerNight,
    this.cleaningPrice,
    this.servicesPrice,
    this.maxNightsStay,
    this.capacity,
    this.createdAt,
    this.updatedAt,
    this.residence,
    this.user,
  });

  factory SimpleReservation.fromJson(Map<String, dynamic> json) {
    return SimpleReservation(
      id: json['id'],
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      totalPrice: json['total_price'],
      guestCount: json['guest_count'],
      status: json['status'],
      pricePerNight: json['price_per_night_snapshot'],
      cleaningPrice: json['cleaning_price_snapshot'],
      servicesPrice: json['services_price_snapshot'],
      maxNightsStay: json['max_nights_stay_snapshot'],
      capacity: json['capacity_snapshot'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      residence: json['residence'] != null
          ? SimpleResidence.fromJson(json['residence'])
          : null,
      user: json['user'] != null ? SimpleUser.fromJson(json['user']) : null,
    );
  }
}
