import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class House {
  String houseId;
  String houseName;
  String userName;
  String userPhone;
  String phoneNumber;
  String province;
  String district;
  String ward;
  String street;
  double lat;
  double lng;
  String facilities;
  String? description;
  String? img;
  String createdAt;
  String status;

  String get address => '$street, $ward, $district, $province';
  String get documentId => houseId;

  House({
    required this.houseId,
    required this.houseName,
    required this.userName,
    required this.userPhone,
    required this.phoneNumber,
    required this.province,
    required this.district,
    required this.ward,
    required this.street,
    required this.lat,
    required this.lng,
    required this.facilities,
    this.description,
    this.img,
    required this.createdAt,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'houseName':houseName,
      'userPhone': userPhone,
      'phoneNumber': phoneNumber,
      'province': province,
      'district': district,
      'ward': ward,
      'street': street,
      'lat': lat,
      'lng': lng,
      'facilities': facilities,
      'description': description,
      'img': img,
      'createdAt': createdAt,
      'status': status,
    };
  }

  factory House.fromMap(Map<String, dynamic> map) {
    return House(
      houseId: map['documentId'] ?? '',
      houseName: map['houseName'] ?? '',
      userName: map['userName'] ?? "",
      userPhone: map['userPhone'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      province: map['province'] ?? "",
      district: map['district'] ?? "",
      ward: map['ward'] ?? "",
      street: map['street'] ?? "",
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
      facilities: map['facilities'] ?? "",
      description: map['description'],
      img: map['img'],
      createdAt: map['createdAt'] ?? "",
      status: map['status'] ?? "",
    );
  }

  factory House.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic>? data = snapshot.data();
    if (data == null) {
      // Handle the case when data is null, return a default instance or throw an error.
      return House(
        houseId:'',
        houseName:'',
        userName: '',
        userPhone: '',
        phoneNumber: '',
        province: '',
        district: '',
        ward: '',
        street: '',
        lat: 0.0,
        lng: 0.0,
        facilities: '',
        createdAt: '',
        status: '',
      );
    }

    try {
      return House(
        houseId: snapshot.id,
        houseName:data['houseName'] as String? ?? '',
        userName: data['userName'] as String? ?? '',
        userPhone: data['userPhone'] as String? ?? '',
        phoneNumber: data['phoneNumber'] as String? ?? '',
        province: data['province'] as String? ?? '',
        district: data['district'] as String? ?? '',
        ward: data['ward'] as String? ?? '',
        street: data['street'] as String? ?? '',
        lat: (data['lat'] as num?)?.toDouble() ?? 0.0,
        lng: (data['lng'] as num?)?.toDouble() ?? 0.0,
        facilities: data['facilities'] as String? ?? '',
        description: data['description'] as String?,
        img: data['img'] as String?,
        createdAt: data['createdAt'] as String? ?? '',
        status: data['status'] as String? ?? '',
      );
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("Error parsing House from snapshot: $e\n$stackTrace");
      }
      return House(
        houseId: snapshot.id,
        houseName: '',
        userName: '',
        userPhone: '',
        phoneNumber: '',
        province: '',
        district: '',
        ward: '',
        street: '',
        lat: 0.0,
        lng: 0.0,
        facilities: '',
        createdAt: '',
        status: '',
      );
    }
  }

  String toJson() => json.encode(toMap());

  factory House.fromJson(String source) =>
      House.fromMap(json.decode(source));
}
