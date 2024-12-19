import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Apartment {
  final List<String> image;
  final String description;
  final double price;
  final bool rent;
  final String location;
  final String title;
  final String area;
  final int floor;
  final int roomNumber;
  final double fullSquare;
  final double livingSquare;
  final double kitchenSquare;
  final bool balcony;
  final bool loggia;
  final String phoneNumber;

  Apartment({
    required this.title,
    required this.image,
    required this.description,
    required this.price,
    required this.rent,
    required this.location,
    required this.area,
    required this.floor,
    required this.roomNumber,
    required this.fullSquare,
    required this.livingSquare,
    required this.kitchenSquare,
    required this.balcony,
    required this.loggia,
    required this.phoneNumber,
  });

  factory Apartment.fromJson(Map<String, dynamic> json) {
    return Apartment(
      title: json['title'],
      image: List<String>.from(json['image']),
      description: json['description'],
      price: (json['price'] is int) ? (json['price'] as int).toDouble() : json['price'] as double,
      rent: json['rent'],
      location: json['location'],
      area: json['area'],
      floor: json['floor'],
      roomNumber: json['roomNumber'],
      fullSquare: (json['fullSquare'] is int) ? (json['fullSquare'] as int).toDouble() : json['fullSquare'] as double,
      livingSquare: (json['livingSquare'] is int) ? (json['livingSquare'] as int).toDouble() : json['livingSquare'] as double,
      kitchenSquare: (json['kitchenSquare'] is int) ? (json['kitchenSquare'] as int).toDouble() : json['kitchenSquare'] as double,
      balcony: json['balcony'],
      loggia: json['loggia'],
      phoneNumber: json['phoneNumber'],
    );
  }
}

Future<List<Apartment>> loadApartmentsFromJson() async {
  final jsonString = await rootBundle.loadString('lib/data_base/apartments.json');
  final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;

  final apartments = jsonData.values.map((apartmentJson) {
    return Apartment.fromJson(apartmentJson);
  }).toList();
  
  return apartments;
}
