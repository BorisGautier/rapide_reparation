import 'package:rapide_achat/models/nominatimResponse.dart';

class NominatimSearch {
  List<NominatimResponse> nominatimSearch;
  

  NominatimSearch({this.nominatimSearch});

  NominatimSearch.fromJson(Map<String, dynamic> json) {
    if (json['nominatimSearch'] != null) {
      nominatimSearch = new List<NominatimResponse>();
      json['nominatimSearch'].forEach((v) {
        nominatimSearch.add(new NominatimResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nominatimSearch != null) {
      data['nominatimSearch'] = this.nominatimSearch.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

