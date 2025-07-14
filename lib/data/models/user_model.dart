class UserModel {
  final int id;
  final String email;
  final bool isAdmin;
  final bool isActive;
  final String fullName;
  final String phoneNumber;
  final num walletBalance;
  final bool isEmailVerified;
  final String createdAt;

  UserModel({
    required this.id,
    required this.email,
    required this.isAdmin,
    required this.isActive,
    required this.fullName,
    required this.phoneNumber,
    required this.walletBalance,
    required this.isEmailVerified,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      email: json['email'] as String,
      isAdmin: json['is_admin'] as bool,
      isActive: json['is_active'] as bool,
      fullName: json['full_name'] as String,
      phoneNumber: json['phone_number'] as String,
      walletBalance: json['wallet_balance'] as num,
      isEmailVerified: json['is_email_verified'] as bool,
      createdAt: json['created_at'] as String,
    );
  }
}
