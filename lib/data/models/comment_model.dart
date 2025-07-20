class CommentModel {
  int? id;
  int? rating;
  String? comment;
  String? createdAt;
  Residence? residence;
  Reservation? reservation;
  User? user;

  CommentModel({
    this.id,
    this.rating,
    this.comment,
    this.createdAt,
    this.residence,
    this.reservation,
    this.user,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    comment = json['comment'];
    createdAt = json['created_at'];
    residence = json['residence'] != null
        ? new Residence.fromJson(json['residence'])
        : null;
    reservation = json['reservation'] != null
        ? new Reservation.fromJson(json['reservation'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    if (this.residence != null) {
      data['residence'] = this.residence!.toJson();
    }
    if (this.reservation != null) {
      data['reservation'] = this.reservation!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Residence {
  int? id;
  String? title;
  String? description;
  String? type;
  Location? location;
  String? createdAt;

  Residence({
    this.id,
    this.title,
    this.description,
    this.type,
    this.location,
    this.createdAt,
  });

  Residence.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    type = json['type'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['type'] = this.type;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Location {
  int? id;
  String? address;
  City? city;
  String? lat;
  String? lng;

  Location({this.id, this.address, this.city, this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class City {
  int? id;
  String? name;
  Province? province;

  City({this.id, this.name, this.province});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    province = json['province'] != null
        ? new Province.fromJson(json['province'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.province != null) {
      data['province'] = this.province!.toJson();
    }
    return data;
  }
}

class Province {
  int? id;
  String? name;

  Province({this.id, this.name});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Reservation {
  int? id;
  String? checkIn;
  String? checkOut;
  int? totalPrice;
  String? status;
  String? createdAt;

  Reservation({
    this.id,
    this.checkIn,
    this.checkOut,
    this.totalPrice,
    this.status,
    this.createdAt,
  });

  Reservation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    totalPrice = json['total_price'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['check_in'] = this.checkIn;
    data['check_out'] = this.checkOut;
    data['total_price'] = this.totalPrice;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class User {
  int? id;
  String? fullName;
  String? phoneNumber;

  User({this.id, this.fullName, this.phoneNumber});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['phone_number'] = this.phoneNumber;
    return data;
  }
}
