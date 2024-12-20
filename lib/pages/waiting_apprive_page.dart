import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/apartment/apartment.dart';

class WaitingApprovePage extends StatefulWidget {
  const WaitingApprovePage({super.key});

  @override
  State<WaitingApprovePage> createState() => _WaitingApprovePageState();
}

class _WaitingApprovePageState extends State<WaitingApprovePage> {
  late Future<List<Apartment>> futureApartments;

  Future<List<Apartment>> loadApplicationsFromJson(String link) async {
    final jsonString = await rootBundle.loadString(link);
    final List<dynamic> jsonData = jsonDecode(jsonString);

    final apartments = jsonData.map((apartmentJson) {
      return Apartment.fromJson(apartmentJson as Map<String, dynamic>);
    }).toList();

    return apartments;
  }

  @override
  void initState() {
    super.initState();
    futureApartments = loadApplicationsFromJson("lib/data_base/aplications.json");
  }

  Future<void> _addApartment(Apartment apartment) async {
    // Путь к файлу
    final filePath = 'lib/data_base/apartments.json';

    // Читаем существующий JSON-файл
    final file = File(filePath);
    List<dynamic> jsonData;

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Квартира добавлена: ${apartment.title}')),
      );
    } catch (e) {
      print('Error adding apartment: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка при добавлении квартиры: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          title: Text('Одобрение заявок'),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 143, 145, 233),
        ),
      ),
      body: FutureBuilder<List<Apartment>>(
        future: futureApartments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Нет доступных квартир.'));
          } else {
            final apartments = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: apartments.map((apartment) {
                  return GestureDetector(
                    onTap: () {
                      // Здесь вы можете добавить логику для перехода на страницу деталей квартиры
                    },
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 300,
                                  child: Image.asset(
                                    apartment.image[0],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        apartment.title,
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        apartment.description,
                                        style: TextStyle(color: Colors.grey[700]),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Цена: ${apartment.price.toStringAsFixed(2)} - ${apartment.rent ? "Аренда" : "Покупка"}',
                                        style: TextStyle(color: Colors.grey[700]),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Расположение: ${apartment.location}',
                                        style: TextStyle(color: Colors.grey[600]),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text('Расположение: ${apartment.area}'),
                            Text('Этаж: ${apartment.floor}'),
                            Text('Количество комнат: ${apartment.roomNumber}'),
                            Text('Общая площадь: ${apartment.fullSquare.toStringAsFixed(2)} м²'),
                            Text('Жилая площадь: ${apartment.livingSquare.toStringAsFixed(2)} м²'),
                            Text('Площадь кухни: ${apartment.kitchenSquare.toStringAsFixed(2)} м²'),
                            Text('Балкон: ${apartment.balcony ? "Да" : "Нет"}'),
                            Text('Лоджия: ${apartment.loggia ? "Да" : "Нет"}'),
                            Text('Телефон: ${apartment.phoneNumber}'),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () => _addApartment(apartment),
                              child: Text('Добавить'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}