class PunchingInModel {
  String? locationName;
  String? longitude;
  String? latitude;
  String? punchInNotes;
  String? picture;
  int? userId;

  PunchingInModel({this.locationName, this.longitude, this.latitude, this.punchInNotes, this.picture, this.userId});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationName'] = this.locationName;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['punchInNotes'] = this.punchInNotes;
    data['picture'] = this.picture;
    data['userId'] = this.userId;
    return data;
  }
}