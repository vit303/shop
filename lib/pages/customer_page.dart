import 'package:flutter/material.dart';
import 'package:shop/apartment/apartment.dart';
import 'package:shop/forms/client_form.dart';
import 'package:shop/pages_components/form_page_comp.dart';

class CustomerPage extends StatefulWidget {
  final Apartment apartment;

  const CustomerPage({Key? key, required this.apartment}) : super(key: key);

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final ApartmentService _apartmentService = ApartmentService();

  Future<void> _saveData(Map<String, dynamic> clientData) async {
    // Создаем словарь с данными о квартире и клиенте
    Map<String, dynamic> dataToSave = {
      "apartment": {
        "title": widget.apartment.title,
        "price": widget.apartment.price,
        "description": widget.apartment.description,
        "location": widget.apartment.location,
        "rent": widget.apartment.rent,
      },
      "client": clientData,
    };

    // Сохраняем данные в JSON
    await _apartmentService.saveDataToJson(dataToSave, 'lib/data_base/buyflat.json');
    // Обработка успешного сохранения, например, показать сообщение
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Данные успешно сохранены!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Заявка на покупку квартиры'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Здесь можно добавить информацию о квартире
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Квартира: ${widget.apartment.title}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Цена: ${widget.apartment.price.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Описание: ${widget.apartment.description}',
                style: TextStyle(fontSize: 16),
              ),
            ),
            // Вставляем форму клиента
            ClientForm(onSubmit: (clientData) {
              _saveData(clientData); // Сохраняем данные о клиенте и квартире
            }),
          ],
        ),
      ),
    );
  }
}
