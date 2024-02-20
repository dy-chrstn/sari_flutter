// To parse this JSON data, do
//
//     final businessAcc = businessAccFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

BusinessAcc businessAccFromJson(String str) => BusinessAcc.fromJson(json.decode(str));

String businessAccToJson(BusinessAcc data) => json.encode(data.toJson());

class BusinessAcc {
    BusinessAcc({
        required this.id,
        required this.username,
        required this.password,
    });

    ObjectId id;
    String username;
    String password;
    

    factory BusinessAcc.fromJson(Map<String, dynamic> json) => BusinessAcc(
        id: json["_id"],
        username: json["username"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "password": password,
        
    };
}
