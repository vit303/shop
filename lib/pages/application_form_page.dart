import 'package:flutter/material.dart';

class AplicationFormPage extends StatefulWidget {
  @override
  _AplicationFormPageState createState() => _AplicationFormPageState();
}

class _AplicationFormPageState extends State<AplicationFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _description = '';
  double _price = 0.0;
  String _location = '';
  bool _isRent = false;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Здесь вы можете обработать данные, например, отправить их на сервер или добавить в локальное хранилище
      print('Описание: $_description');
      print('Цена: $_price');
      print('Локация: $_location');
      print('Аренда: $_isRent');

      // Закрываем экран после успешного добавления
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить квартиру'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Описание'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите описание';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Цена'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите цену';
                  }
                  return null;
                },
                onSaved: (value) {
                  _price = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Локация'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите локацию';
                  }
                  return null;
                },
                onSaved: (value) {
                  _location = value!;
                },
              ),
              SwitchListTile(
                title: Text('Аренда'),
                value: _isRent,
                onChanged: (bool value) {
                  setState(() {
                    _isRent = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Добавить квартиру'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
