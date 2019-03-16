import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rapide_achat/models/response.dart';

class ApiRest {
  static final REGISTERF_URL =
      "http://myevent.sjpcommunity.cm/registerf";
      static final REGISTER_URL =
      "http://myevent.sjpcommunity.cm/register";

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
}