
import 'package:flutter/material.dart';
import 'package:shop/pages_components/form_page_comp.dart';

class ClientForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;

  const ClientForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _ClientFormState createState() => _ClientFormState();
}

class _ClientFormState extends State<ClientForm> {
  final _formKey = GlobalKey<FormState>();
  String _clientLastName = '';
  String _clientAddress = '';
  String _clientPhone = '';
  String _registrationNumber = '';
  String _descriptionPreference = '';
  final ApartmentService _apartmentService = ApartmentService();

  Future<void> _saveClientData() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Сохраните данные клиента
      Map<String, dynamic> clientData = {
        "lastName": _clientLastName,
        "address": _clientAddress,
        "phone": _clientPhone,
        "registrationNumber": _registrationNumber,
        "description": _descriptionPreference,
      };

      await _apartmentService.saveDataToJson(clientData, 'lib/data_base/clients.json');
      widget.onSubmit(clientData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Фамилия'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Пожалуйста, введите фамилию';
                }
                return null;
              },
              onSaved: (value) {
                _clientLastName = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Адрес'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Пожалуйста, введите адрес';
                }
                return null;
              },
              onSaved: (value) {
                _clientAddress = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Телефон'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Пожалуйста, введите телефон';
                }
                return null;
              },
              onSaved: (value) {
                _clientPhone = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Регистрационный номер'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Пожалуйста, введите регистрационный номер';
                }
                return null;
              },
              onSaved: (value) {
                _registrationNumber = value!;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'Описание'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Пожалуйста, введите описание';
                }
                return null;
              },
              onSaved: (value) {
                _descriptionPreference = value!;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveClientData,
              child: Text('Отправить информацию о клиенте'),
            ),
          ],
        ),
      ),
    );
  }
}
