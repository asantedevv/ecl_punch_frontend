class User {
  final int? id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String jobTitle;
  final String mobilePhone;
  final String microsoftId;
  final String email;
  final String status;
  final String deleteStatus;
  final String image; // Base64 encoded image
  final String punchInStatus;
  final String punch;

  User(
      {required this.firstName,
      required this.lastName,
      required this.fullName,
      required this.jobTitle,
      required this.mobilePhone,
      required this.microsoftId,
      required this.email,
      required this.status,
      required this.deleteStatus,
      required this.image,
      required this.punchInStatus,
      required this.punch,

      this.id,});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'] ?? 'Unknown', // Default value if null
      lastName: json['lastName'] ?? 'Unknown',
      fullName: json['fullName'] ?? 'Unknown',
      jobTitle: json['jobTitle'] ?? 'Unknown',
      mobilePhone: json['mobilePhone'] ?? 'Unknown',
      microsoftId: json['microsoftId'] ?? 'Unknown',
      email: json['email'] ?? 'Unknown',
      status: json['status'] ?? 'Unknown',
      deleteStatus: json['deleteStatus'] ?? 'Unknown',
      image: json['image'] ?? '', // Default to an empty string if null
      id: json['id'] ?? '', // Default value if null
      punchInStatus: json['punchInStatus'] ?? 'Unknown',
      punch: json['punch'] ?? 'Unknown',

    );
  }



  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'fullName': fullName,
      'email': email,
      'lastName': lastName,
      'jobTitle': jobTitle,
      'mobilePhone': mobilePhone,
      'microsoftId': microsoftId,
      'status': status,
      'deleteStatus': deleteStatus,
      'image': image,
      'id': id,
      'punchInStatus':punchInStatus,
    };
  }


}



