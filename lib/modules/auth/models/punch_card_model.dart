class PunchCardModel {
  int? id;
  String? status;
  String? deleteStatus;
  String? picture;
  String? userId;
  String? punchInDateTime;
  String? punchOutDateTime;
  String? locationName;
  String? longitude;
  String? latitude;
  String? notes;

  PunchCardModel(
      {this.id,
      this.status,
      this.deleteStatus,
      this.picture,
      this.userId,
      this.punchInDateTime,
      this.punchOutDateTime,
      this.locationName,
      this.longitude,
      this.latitude,
      this.notes});

  PunchCardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    deleteStatus = json['deleteStatus'];
    picture = json['picture'];
    userId = json['userId'];
    punchInDateTime = json['punchInDateTime'];
    punchOutDateTime = json['punchOutDateTime'];
    locationName = json['locationName'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['deleteStatus'] = this.deleteStatus;
    data['picture'] = this.picture;
    data['userId'] = this.userId;
    data['punchInDateTime'] = this.punchInDateTime;
    data['punchOutDateTime'] = this.punchOutDateTime;
    data['locationName'] = this.locationName;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['notes'] = this.notes;
    return data;
  }
}






















// class PunchCard {
//     int? id;
//     String? status;
//     String? deleteStatus;
//     dynamic picture;
//     dynamic timestamp;
//     int? userId;
//     DateTime? punchInDateTime;
//     DateTime? punchOutDateTime;
//     String? locationName;
//     String? longitude;
//     String? latitude;
//     String? notes;

//     PunchCard({
//          this.id,
//          this.status,
//          this.deleteStatus,
//          this.picture,
//          this.timestamp,
//          this.userId,
//          this.punchInDateTime,
//          this.punchOutDateTime,
//          this.locationName,
//          this.longitude,
//          this.latitude,
//          this.notes,
//     });




//     factory PunchCard.fromJson(Map<String, dynamic> json) {
//     return PunchCard(
//       status: json['status'] ?? 'Unknown', // Default value if null
//       deleteStatus: json['deleteStatus'] ?? 'Unknown',
//       picture: json['picture'] ?? 'Unknown',
//       timestamp: json['timestamp'] ?? 'Unknown',
//       userId: json['userId'] ?? 'Unknown',
//       punchInDateTime: json['punchInDateTime'] ?? 'Unknown',
//       punchOutDateTime: json['punchOutDateTime'] ?? 'Unknown',
//       locationName: json['locationName'] ?? 'Unknown',
//       longitude: json['longitude'] ?? 'Unknown',
//       latitude: json['latitude'] ?? '', // Default to an empty string if null
//       id: json['id'] ?? '', // Default value if null
//       notes: json['notes'] ?? 'Unknown',

//     );
//   }

// }