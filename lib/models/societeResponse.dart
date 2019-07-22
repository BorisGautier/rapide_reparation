class SocieteResponse {
  List<Societe> societe;
  String status;

  SocieteResponse({this.societe, this.status});

  SocieteResponse.fromJson(Map<String, dynamic> json) {
    if (json['societe'] != null) {
      societe = new List<Societe>();
      json['societe'].forEach((v) {
        societe.add(new Societe.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.societe != null) {
      data['societe'] = this.societe.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Societe {
  String id;
  String nom;
  String email;
  String kbis;
  String rib;
  String idFacebook;
  String lng;
  String lat;
  String valide;
  String createdAt;
  String updatedAt;

  Societe(
      {this.id,
      this.nom,
      this.email,
      this.kbis,
      this.rib,
      this.idFacebook,
      this.lng,
      this.lat,
      this.createdAt,
      this.updatedAt,
      this.valide});

  Societe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    email = json['email'];
    kbis = json['kbis'];
    rib = json['rib'];
    idFacebook = json['id_facebook'];
    lng = json['lng'];
    lat = json['lat'];
    valide = json['valide'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom'] = this.nom;
    data['email'] = this.email;
    data['kbis'] = this.kbis;
    data['rib'] = this.rib;
    data['id_facebook'] = this.idFacebook;
    data['lng'] = this.lng;
    data['lat'] = this.lat;
    data['valide'] = this.valide;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}