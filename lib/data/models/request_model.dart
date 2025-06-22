class RequestModel {
  final int id;
  final String title;
  final String managerName;
  final String managerPhoneNumber;
  final String city;
  final String province;
  final String address;
  final double latitude;
  final double longitude;
  final String? pictureUrl;

  RequestModel({
    required this.id,
    required this.title,
    required this.managerName,
    required this.managerPhoneNumber,
    required this.city,
    required this.province,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.pictureUrl,
  });
}