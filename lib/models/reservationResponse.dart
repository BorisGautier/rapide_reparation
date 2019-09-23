class ReservationResponse {
  List<Reservation> reservation;
  String status;

  ReservationResponse({this.reservation, this.status});

  ReservationResponse.fromJson(Map<String, dynamic> json) {
    if (json['reservation'] != null) {
      reservation = new List<Reservation>();
      json['reservation'].forEach((v) {
        reservation.add(new Reservation.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reservation != null) {
      data['reservation'] = this.reservation.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Reservation {
  String id;
  String appareil;
  String modele;
  String probleme;
  String lieuAssistance;
  String date;
  String email;
  String ville;
  String telephone;
  String token;
  String societe;
  String createdAt;
  String updatedAt;

  Reservation(
      {this.id,
      this.appareil,
      this.modele,
      this.probleme,
      this.lieuAssistance,
      this.date,
      this.email,
      this.ville,
      this.telephone,
      this.token,
      this.societe,
      this.createdAt,
      this.updatedAt});

  Reservation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appareil = json['appareil'];
    modele = json['modele'];
    probleme = json['probleme'];
    lieuAssistance = json['lieu_assistance'];
    date = json['date'];
    email = json['email'];
    ville = json['ville'];
    telephone = json['telephone'];
    token = json['token'];
    societe = json['societe'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appareil'] = this.appareil;
    data['modele'] = this.modele;
    data['probleme'] = this.probleme;
    data['lieu_assistance'] = this.lieuAssistance;
    data['date'] = this.date;
    data['email'] = this.email;
    data['ville'] = this.ville;
    data['telephone'] = this.telephone;
    data['token'] = this.token;
    data['societe'] = this.societe;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
