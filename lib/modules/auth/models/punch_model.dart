class PunchModel {
  int? id;
  String? status;
  String? deleteStatus;
  String? picture;
  int? userId;
  String? punchInDateTime;
  String? punchOutDateTime;
  String? punchDate;
  int? hoursWorked;
  String? locationName;
  String? longitude;
  String? latitude;
  String? notes;
  String? punchInNotes;
  String? punchOutNotes;
  int? totalHours;

  PunchModel(
      {this.id,
      this.status,
      this.deleteStatus,
      this.picture,
      this.userId,
      this.punchInDateTime,
      this.punchOutDateTime,
      this.punchDate,
      this.hoursWorked,
      this.locationName,
      this.longitude,
      this.latitude,
      this.notes,
      this.punchInNotes,
      this.punchOutNotes,
      this.totalHours});

  PunchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    deleteStatus = json['deleteStatus'];
    picture = json['picture'];
    userId = json['userId'];
    punchInDateTime = json['punchInDateTime'];
    punchOutDateTime = json['punchOutDateTime'];
    punchDate = json['punchDate'];
    hoursWorked = json['hoursWorked'];
    locationName = json['locationName'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    notes = json['notes'];
    punchInNotes = json['punchInNotes'];
    punchOutNotes = json['punchOutNotes'];
    totalHours = json['totalHours'];
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
    data['punchDate'] = this.punchDate;
    data['hoursWorked'] = this.hoursWorked;
    data['locationName'] = this.locationName;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['notes'] = this.notes;
    data['punchInNotes'] = this.punchInNotes;
    data['punchOutNotes'] = this.punchOutNotes;
    data['totalHours'] = this.totalHours;
    return data;
  }
}
