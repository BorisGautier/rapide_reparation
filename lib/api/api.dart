import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rapide_achat/models/distance.dart';
import 'package:rapide_achat/models/nominatimResponse.dart';
import 'package:rapide_achat/models/nominatimSearch.dart';
import 'package:rapide_achat/models/reservationResponse.dart';
import 'package:rapide_achat/models/response.dart';
import 'package:rapide_achat/models/societeResponse.dart';

class ApiRest {
  static final REGISTERF_URL =
      "http://rapideachat.sjpcommunity.cm/public/registerf";
      static final REGISTER_URL =
      "http://rapideachat.sjpcommunity.cm/public/register";
      static final RESERVATION_URL =
      "http://rapideachat.sjpcommunity.cm/public/reservation";
       static final REGISTERE_URL =
      "http://rapideachat.sjpcommunity.cm/public/registere";
       static final REGISTERES_URL =
      "http://rapideachat.sjpcommunity.cm/public/registeres";
       static final REGISTERT_URL =
      "http://rapideachat.sjpcommunity.cm/public/registeret";
      static final GETSOCIETE_URL =
      "http://rapideachat.sjpcommunity.cm/public/getsociete"; 
       static final GETRESERVATION_URL =
      "http://rapideachat.sjpcommunity.cm/public/getreservation";
       static final CONFIRM_URL =
      "http://rapideachat.sjpcommunity.cm/public/confirm";
       static final STRIPE_URL =
      "http://rapideachat.sjpcommunity.cm/public/stripe";
      static final GETDISTANCE_URL =
      "http://rapideachat.sjpcommunity.cm/public/getd"; 
      static final NOMINATIM_URL =
      "https://nominatim.openstreetmap.org/reverse"; 
        static final NOMINATIM_SEARCH_URL =
      "https://nominatim.openstreetmap.org/search";

       Future<NominatimResponse> nominatim(String lat, String lon) {
    return http.get(NOMINATIM_URL+"?"+"lat="+lat+"&lon="+lon+"&format=json&addressdetails=1").then((http.Response response) {
      final String res = response.body;
      if (response.statusCode == 200) {
        var j = json.decode(res);
        String status = j['status'];
        if (status == "success") {
          return new NominatimResponse.fromJson(json.decode(res));
        } else {
          return new NominatimResponse.fromJson(json.decode(res));
        }
      } else {
        throw new Exception("Error while fetching data");
      }
    });
  }

    Future<NominatimSearch> nominatimSearch(String search) {
    return http.get(NOMINATIM_SEARCH_URL+"?"+"q="+search+"&format=json&polygon=0&addressdetails=1&countrycodes=fr").then((http.Response response) {
      final String res = response.body;
      if (response.statusCode == 200) {
        var j = json.decode(res);
          return new NominatimSearch.fromJson(json.decode(res));
        } else {
          throw new Exception("Error while fetching data");
        }
      
    });
  }

      Future<Response> registerF(String name, String email, String ville,String telephone,String date,String facebook_id) {
    return http.post(REGISTERF_URL, body: {
      "email": email,
      "ville": ville,
      "name": name,
      "telephone":telephone,
      "date":date,
      "facebook_id":facebook_id
    }).then((http.Response response) {
      final String res = response.body;
      if (response.statusCode == 201) {
        var j = json.decode(res);
        String status = j['status'];
        if (status == "success") {
          return new Response.fromJson(json.decode(res));
        } else {
          return new Response.fromJson(json.decode(res));
        }
      } else {
        throw new Exception("Error while fetching data");
      }
    });
  }

    Future<Response> register(String name, String email, String ville,String telephone,String date) {
    return http.post(REGISTER_URL, body: {
      "email": email,
      "ville": ville,
      "name": name,
      "telephone":telephone,
      "date":date
    }).then((http.Response response) {
      final String res = response.body;
      if (response.statusCode == 201) {
        var j = json.decode(res);
        String status = j['status'];
        if (status == "success") {
          return new Response.fromJson(json.decode(res));
        } else {
          return new Response.fromJson(json.decode(res));
        }
      } else {
        throw new Exception("Error while fetching data");
      }
    });
  }

     Future<Response> registerE(String ent, String email, String kbis,String rib,String id,String lng,String lat) {
    return http.post(REGISTERE_URL, body: {
      "entreprise": ent,
      "email": email,
      "kbis": kbis,
      "rib":rib,
      "lng":lng,
      "lat":lat,
      "id_facebook":id
    }).then((http.Response response) {
      final String res = response.body;
      if (response.statusCode == 201) {
        var j = json.decode(res);
        String status = j['status'];
        if (status == "success") {
          return new Response.fromJson(json.decode(res));
        } else {
          return new Response.fromJson(json.decode(res));
        }
      } else {
        throw new Exception("Error while fetching data");
      }
    });
  }

       Future<Response> registerES(String ent, String email, String kbis,String rib,String lng,String lat) {
    return http.post(REGISTERES_URL, body: {
      "entreprise": ent,
      "email": email,
      "kbis": kbis,
      "rib":rib,
      "lng":lng,
      "lat":lat
    }).then((http.Response response) {
      final String res = response.body;
      if (response.statusCode == 201) {
        var j = json.decode(res);
        String status = j['status'];
        if (status == "success") {
          return new Response.fromJson(json.decode(res));
        } else {
          return new Response.fromJson(json.decode(res));
        }
      } else {
        throw new Exception("Error while fetching data");
      }
    });
  }

    Future<Response> registerT(String nomT,String ent,String cv,String diplome) {
    return http.post(REGISTERT_URL, body: {
      "entreprise": ent,
      "technicien": nomT,
      "cv": cv,
      "diplome":diplome
    }).then((http.Response response) {
      final String res = response.body;
      if (response.statusCode == 201) {
        var j = json.decode(res);
        String status = j['status'];
        if (status == "success") {
          return new Response.fromJson(json.decode(res));
        } else {
          return new Response.fromJson(json.decode(res));
        }
      } else {
        throw new Exception("Error while fetching data");
      }
    });
  }

 Future<Response> reservation(String appareil, String email, String modele,String probleme,String assistance,String dateR, String token,String societe,String adresse) {
    return http.post(RESERVATION_URL, body: {
      "email": email,
      "appareil": appareil,
      "modele": modele,
      "probleme":probleme,
      "assistance":assistance,
      "dateR":dateR,
      "token":token,
      "societe" : societe,
      "adresse" : adresse
    }).then((http.Response response) {
      final String res = response.body;
      if (response.statusCode == 201) {
        var j = json.decode(res);
        String status = j['status'];
        if (status == "success") {
          return new Response.fromJson(json.decode(res));
        } else {
          return new Response.fromJson(json.decode(res));
        }
      } else {
        throw new Exception("Error while fetching data");
      }
    });
  }

 /*   Future<SocieteResponse> getSociete(String lng, String lat) {
    return http.post(GETSOCIETE_URL, body: {"lng": lng,"lat": lat}).then(
        (http.Response response) {
      final String res = response.body;
      if (response.statusCode == 200) {
        var j = json.decode(res);
        String status = j['status'];
        if (status == "success") {
          return new SocieteResponse.fromJson(json.decode(res));
        } else {
          return new SocieteResponse.fromJson(json.decode(res));
        }
      } else {}
    });
    }*/

     Future<SocieteResponse> getSociete(String societe) {
    return http.post(GETSOCIETE_URL, body: {"societe": "rapide achat"}).then(
        (http.Response response) {
      final String res = response.body;
      if (response.statusCode == 200) {
        var j = json.decode(res);
        String status = j['status'];
        if (status == "success") {
          return new SocieteResponse.fromJson(json.decode(res));
        } else {
          return new SocieteResponse.fromJson(json.decode(res));
        }
      } else {}
    });
  }

    Future<Dist> getd(String societe,String lng,String lat) {
    return http.post(GETDISTANCE_URL, body: {"societe": societe,"lng":lng,"lat":lat}).then(
        (http.Response response) {
      final String res = response.body;
      if (response.statusCode == 200) {
        var j = json.decode(res);
        String status = j['status'];
        if (status == "success") {
          return new Dist.fromJson(json.decode(res));
        } else {
          return new Dist.fromJson(json.decode(res));
        }
      } else {}
    });
  }

     Future<ReservationResponse> getReseration(String societe) {
    return http.post(GETRESERVATION_URL, body: {"societe": societe}).then(
        (http.Response response) {
      final String res = response.body;
      if (response.statusCode == 200) {
        var j = json.decode(res);
        String status = j['status'];
        if (status == "success") {
          return new ReservationResponse.fromJson(json.decode(res));
        } else {
          return new ReservationResponse.fromJson(json.decode(res));
        }
      } else {}
    });
  }

    Future<Response> confirmer(String id) {
    return http.post(CONFIRM_URL, body: {"id": id}).then(
        (http.Response response) {
      final String res = response.body;
      if (response.statusCode == 200) {
        var j = json.decode(res);
        String status = j['status'];
        if (status == "success") {
          return new Response.fromJson(json.decode(res));
        } else {
          return new Response.fromJson(json.decode(res));
        }
      } else {}
    });
  }

    Future<Response> stripe(String token,String email,String prix) {
    return http.post(STRIPE_URL, body: {
      "token": token,
      "email": email,
      "prix": prix
    }).then((http.Response response) {
      final String res = response.body;
      if (response.statusCode == 200) {
        var j = json.decode(res);
        String status = j['status'];
        if (status == "success") {
          return new Response.fromJson(json.decode(res));
        } else {
          return new Response.fromJson(json.decode(res));
        }
      } else {
        throw new Exception("Error while fetching data");
      }
    });
  }

}