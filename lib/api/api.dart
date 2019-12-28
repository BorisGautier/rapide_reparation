import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rapide_achat/models/distance.dart';
import 'package:rapide_achat/models/nominatimResponse.dart';
import 'package:rapide_achat/models/nominatimSearch.dart';
import 'package:rapide_achat/models/produitResponse.dart';
import 'package:rapide_achat/models/response.dart';
import 'package:rapide_achat/models/vivawallet.dart';

class ApiRest {
  static final reservationUrl =
      "http://rapidereparation.trimora.cm/api/reservation";
  static final distanceUrl =
      "http://rapideachat.sjpcommunity.cm/public/getd";
  static final nominatimUrl = "https://nominatim.openstreetmap.org/reverse";
  static final nominatimSearchUrl =
      "https://nominatim.openstreetmap.org/search";
  static final produitUrl=
      "https://www.rapide-achat.com/wp-json/public-woo/v1/products";

  Future<ProduitResponse> getProduit(String categorie, String id) {
    return http
        .get(produitUrl+ "?" + categorie + "=" + id)
        .then((http.Response response) {
      final String res = response.body;
      if (response.statusCode == 200) {
        return new ProduitResponse.fromMap(json.decode(res));
      } else {
        throw new Exception("Error while fetching data");
      }
    });
  }

  Future<NominatimResponse> nominatim(String lat, String lon) {
    return http
        .get(nominatimUrl +
            "?" +
            "lat=" +
            lat +
            "&lon=" +
            lon +
            "&format=json&addressdetails=1")
        .then((http.Response response) {
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
    return http
        .get(nominatimSearchUrl +
            "?" +
            "q=" +
            search +
            "&format=json&polygon=0&addressdetails=1&countrycodes=fr")
        .then((http.Response response) {
      final String res = response.body;
      if (response.statusCode == 200) {
        return new NominatimSearch.fromJson(json.decode(res));
      } else {
        throw new Exception("Error while fetching data");
      }
    });
  }

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "cache-control": "no-cache",
    "authorization":
        "Basic OTdiMGE5YzMtNWI5ZS00OGVjLTkyMTMtNjU1YTM3MDc2ZjU5OkZoOXpZaDk2NXQydzByNTc1WEc2MmhrNWpocXUyRQ=="
  };

  Future<VivaWallet> getVivawallet(
      String fullName, String email, int amount, String produit) {
    final msg = jsonEncode({
      "Email": email,
      "FullName": fullName,
      "PaymentTimeOut": 300,
      "RequestLang": "fr",
      "MaxInstallments": 2,
      "AllowRecurring": true,
      "IsPreAuth": true,
      "Amount": amount,
      "MerchantTrns": "Paiement pour Rapide Réparation",
      "CustomerTrns": produit
    });

    return http
        .post("https://www.vivapayments.com/api/orders",
            headers: headers, body: msg)
        .then((http.Response response) {
      final String res = response.body;
      if (response.statusCode == 200) {

        return new VivaWallet.fromJson(json.decode(res));
      } else {
        throw new Exception("Error while fetching data");
      }
    });
  }


  Future<Response> reservation(
      String appareil,
      String email,
      String modele,
      String probleme,
      String assistance,
      String dateR,
      String token,
      String societe,
      String adresse,
      String code,
      String etage,
      String infos,
      String ville,
      String telephone) {
    return http.post(reservationUrl, body: {
      "email": email,
      "appareil": appareil,
      "modele": modele,
      "probleme": probleme,
      "assistance": assistance,
      "dateR": dateR,
      "token": token,
      "societe": societe,
      "adresse": adresse,
      "code": code,
      "etage": etage,
      "infos": infos,
      "ville": ville,
      "telephone": telephone
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


  Future<Dist> getd(String societe, String lng, String lat) {
    return http.post(distanceUrl, body: {
      "societe": societe,
      "lng": lng,
      "lat": lat
    }).then((http.Response response) {
      final String res = response.body;
      if (response.statusCode == 200) {
        var j = json.decode(res);
        String status = j['status'];
        if (status == "success") {
          return new Dist.fromJson(json.decode(res));
        } else {
          return new Dist.fromJson(json.decode(res));
        }
      } else {
        return null;
      }
    });
  }


}
