class NominatimResponse {
  int placeId;
  String licence;
  String osmType;
  int osmId;
  String lat;
  String lon;
  String displayName;
  Address address;
  List<String> boundingbox;

  NominatimResponse(
      {this.placeId,
      this.licence,
      this.osmType,
      this.osmId,
      this.lat,
      this.lon,
      this.displayName,
      this.address,
      this.boundingbox});

  NominatimResponse.fromJson(Map<String, dynamic> json) {
    placeId = json['place_id'];
    licence = json['licence'];
    osmType = json['osm_type'];
    osmId = json['osm_id'];
    lat = json['lat'];
    lon = json['lon'];
    displayName = json['display_name'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    boundingbox = json['boundingbox'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['place_id'] = this.placeId;
    data['licence'] = this.licence;
    data['osm_type'] = this.osmType;
    data['osm_id'] = this.osmId;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['display_name'] = this.displayName;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['boundingbox'] = this.boundingbox;
    return data;
  }
}

class Address {
  String hamlet;
  String county;
  String state;
  String country;
  String countryCode;

  Address(
      {this.hamlet, this.county, this.state, this.country, this.countryCode});

  Address.fromJson(Map<String, dynamic> json) {
    hamlet = json['hamlet'];
    county = json['county'];
    state = json['state'];
    country = json['country'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hamlet'] = this.hamlet;
    data['county'] = this.county;
    data['state'] = this.state;
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    return data;
  }
}