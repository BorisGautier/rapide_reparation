class Dist {
  double distance;
  String status;

  Dist({this.distance, this.status});

  Dist.fromJson(Map<String, dynamic> json) {
    distance = json['distance'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distance'] = this.distance;
    data['status'] = this.status;
    return data;
  }
}