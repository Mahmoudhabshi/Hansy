class UserLoginResponseModel {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final String refreshToken;
  final DateTime? refreshExpiresAt;
  final UserModel user;

  UserLoginResponseModel({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.refreshToken,
    required this.refreshExpiresAt,
    required this.user,
  });

  factory UserLoginResponseModel.fromJson(Map<String, dynamic> json) {
    return UserLoginResponseModel(
      accessToken: json['access_token'] as String? ?? '',
      tokenType: json['token_type'] as String? ?? '',
      expiresIn: json['expires_in'] as int? ?? 0,
      refreshToken: json['refresh_token'] as String? ?? '',
      refreshExpiresAt: json['refresh_expires_at'] != null
          ? DateTime.tryParse(json['refresh_expires_at'] as String)
          : null,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'refresh_token': refreshToken,
      'refresh_expires_at': refreshExpiresAt?.toIso8601String(),
      'user': user.toJson(),
    };
  }
}

class UserModel {
  final int id;
  final String name;
  final String email;
  final String userName;
  final int status;
  final String? image;
  final String? address;
  final String? designation;
  final String? aboutMe;
  final String? facebook;
  final String? twitter;
  final String? linkedin;
  final String? instagram;
  final int kycStatus;
  final int isAgency;
  final int ownerId;
  final dynamic hcInquiryStatus;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.userName,
    required this.status,
    this.image,
    this.address,
    this.designation,
    this.aboutMe,
    this.facebook,
    this.twitter,
    this.linkedin,
    this.instagram,
    required this.kycStatus,
    required this.isAgency,
    required this.ownerId,
    this.hcInquiryStatus,
  });

  bool get isAgencyAccount => isAgency == 1;
  bool get isActive => status == 1;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      userName: json['user_name'] as String? ?? '',
      status: json['status'] as int? ?? 0,
      image: json['image'] as String?,
      address: json['address'] as String?,
      designation: json['designation'] as String?,
      aboutMe: json['about_me'] as String?,
      facebook: json['facebook'] as String?,
      twitter: json['twitter'] as String?,
      linkedin: json['linkedin'] as String?,
      instagram: json['instagram'] as String?,
      kycStatus: json['kyc_status'] as int? ?? 0,
      isAgency: json['is_agency'] as int? ?? 0,
      ownerId: json['owner_id'] as int? ?? 0,
      hcInquiryStatus: json['hc_inquiry_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'user_name': userName,
      'status': status,
      'image': image,
      'address': address,
      'designation': designation,
      'about_me': aboutMe,
      'facebook': facebook,
      'twitter': twitter,
      'linkedin': linkedin,
      'instagram': instagram,
      'kyc_status': kycStatus,
      'is_agency': isAgency,
      'owner_id': ownerId,
      'hc_inquiry_status': hcInquiryStatus,
    };
  }
}