import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:shop/apartment/apartment.dart';

class ApartmentService {
  Future<List<Apartment>> loadApplicationsFromJson(String link) async {
    final jsonString = await rootBundle.loadString(link);
    final List<dynamic> jsonData = jsonDecode(jsonString);

    final apartments = jsonData.map((apartmentJson) {
      return Apartment.fromJson(apartmentJson as Map<String, dynamic>);
    }).toList();

    return apartments;
  }

  Future<void> addApartment(Apartment apartment, String filePath) async {
    final file = File(filePath);
    List<Map<String, dynamic>> jsonData;

    try {
      if (await file.exists()) {
        final jsonString = await file.readAsString();
        jsonData = jsonDecode(jsonString);
      } else {
        jsonData = [];
      }

      // Добавляем новую квартиру в список
      jsonData.add(apartment.toJson());

      // Сохраняем обновленный список обратно в файл
      await file.writeAsString(jsonEncode(jsonData));

      print('Apartment added: ${apartment.description}');
    } catch (e) {
      print('Error adding apartment: $e');
      throw e; // Перекинем ошибку для обработки на уровне UI
    }
  }
  
}