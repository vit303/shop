import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Apartment {
  final List<String> image;
  final String description;
  final double price;
  final bool rent;
  final String location;
  final String title;

  Apartment({
    required this.title,
    required this.image,
    required this.description,
    required this.price,
    required this.rent,
    required this.location
  });

  factory Apartment.fromJson(Map<String, dynamic> json) {
    return Apartment(
      title: json['title'],
      image: List<String>.from(json['image']),
      description: json['description'],
      price: (json['price'] is int) ? (json['price'] as int).toDouble() : json['price'] as double,
      rent: json['rent'],
      location: json['location']
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