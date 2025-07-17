class ReservationModel {
  final int id;
  final UserInfo user;
  final ResidenceInfo residence;
  final DiscountInfo? discount;
  final String checkIn;
  final String checkOut;
  final String status;
  final num totalPrice;
  final int pricePerNightSnapshot;
  final int cleaningPriceSnapshot;
  final int servicesPriceSnapshot;
  final int capacitySnapshot;
  final int guestCount;
  final String createdAt;
  final List<PaymentInfo> payments;

  ReservationModel({
    required this.id,
    required this.user,
    required this.residence,
    required this.discount,
    required this.checkIn,
    required this.checkOut,
    required this.status,
    required this.totalPrice,
    required this.pricePerNightSnapshot,
    required this.cleaningPriceSnapshot,
    required this.servicesPriceSnapshot,
    required this.capacitySnapshot,
    required this.guestCount,
    required this.createdAt,
    required this.payments,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['id'],
      user: UserInfo.fromJson(json['user']),
      residence: ResidenceInfo.fromJson(json['residence']),
      discount: json['discount'] != null ? DiscountInfo.fromJson(json['discount']) : null,
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      status: json['status'],
      totalPrice: json['total_price'],
      pricePerNightSnapshot: json['price_per_night_snapshot'],
      cleaningPriceSnapshot: json['cleaning_price_snapshot'],
      servicesPriceSnapshot: json['services_price_snapshot'],
      capacitySnapshot: json['capacity_snapshot'],
      guestCount: json['guest_count'],
      createdAt: json['created_at'],
      payments: (json['payments'] as List)
          .map((e) => PaymentInfo.fromJson(e))
          .toList(),
    );
  }
}

class UserInfo {
  final String fullName;
  final String email;
  final String phoneNumber;

  UserInfo({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      fullName: json['full_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
    );
  }
}

class ResidenceInfo {
  final String title;
  final UserInfo owner;
  final LocationInfo location;

  ResidenceInfo({
    required this.title,
    required this.owner,
    required this.location,
  });

  factory ResidenceInfo.fromJson(Map<String, dynamic> json) {
    return ResidenceInfo(
      title: json['title'],
      owner: UserInfo.fromJson(json['owner']),
      location: LocationInfo.fromJson(json['location']),
    );
  }
}

class LocationInfo {
  final int id;
  final String address;
  final double lat;
  final double lng;
  final CityInfo city;

  LocationInfo({
    required this.id,
    required this.address,
    required this.lat,
    required this.lng,
    required this.city,
  });

  factory LocationInfo.fromJson(Map<String, dynamic> json) {
    return LocationInfo(
      id: json['id'],
      address: json['address'],
      lat: double.parse(json['lat']),
      lng: double.parse(json['lng']),
      city: CityInfo.fromJson(json['city']),
    );
  }
}

class CityInfo {
  final int id;
  final String name;
  final ProvinceInfo province;

  CityInfo({required this.id, required this.name, required this.province});

  factory CityInfo.fromJson(Map<String, dynamic> json) {
    return CityInfo(
      id: json['id'],
      name: json['name'],
      province: ProvinceInfo.fromJson(json['province']),
    );
  }
}

class ProvinceInfo {
  final int id;
  final String name;

  ProvinceInfo({required this.id, required this.name});

  factory ProvinceInfo.fromJson(Map<String, dynamic> json) {
    return ProvinceInfo(
      id: json['id'],
      name: json['name'],
    );
  }
}

class DiscountInfo {
  final int id;
  final String title;
  final String code;
  final int discountPercentage;
  final String startDate;
  final String endDate;
  final String? description;

  DiscountInfo({
    required this.id,
    required this.title,
    required this.code,
    required this.discountPercentage,
    required this.startDate,
    required this.endDate,
    this.description,
  });

  factory DiscountInfo.fromJson(Map<String, dynamic> json) {
    return DiscountInfo(
      id: json['id'],
      title: json['title'],
      code: json['code'],
      discountPercentage: json['discount_percentage'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      description: json['description'],
    );
  }
}

class PaymentInfo {
  final int id;
  final int amount;
  final String status;
  final String type;
  final String createdAt;

  PaymentInfo({
    required this.id,
    required this.amount,
    required this.status,
    required this.type,
    required this.createdAt,
  });

  factory PaymentInfo.fromJson(Map<String, dynamic> json) {
    return PaymentInfo(
      id: json['id'],
      amount: json['amount'],
      status: json['status'],
      type: json['type'],
      createdAt: json['created_at'],
    );
  }
}
