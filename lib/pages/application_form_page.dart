import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AplicationFormPage extends StatefulWidget {
  @override
  _AplicationFormPageState createState() => _AplicationFormPageState();
}

class _AplicationFormPageState extends State<AplicationFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _phoneNumber = '';
  String _description = '';
  double _price = 0.0;
  String _location = '';
  String _district = '';
  int _floor = 0;
  int _rooms = 0;
  double _totalArea = 0.0;
  double _livingArea = 0.0;
  double _kitchenArea = 0.0;
  bool _hasBalcony = false;
  bool _hasLoggia = false;
  String _houseDescription = '';
  bool _isRent = false;
  List<File> _images = [];

  final ImagePicker _picker = ImagePicker();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Здесь вы можете обработать данные, например, отправить их на сервер или добавить в локальное хранилище
      print('Описание: $_description');
      print('Цена: $_price');
      print('Локация: $_location');
      print('Район: $_district');
      print('Этаж: $_floor');
      print('Количество комнат: $_rooms');
      print('Общая площадь: $_totalArea');
      print('Жилая площадь: $_livingArea');
      print('Площадь кухни: $_kitchenArea');
      print('Наличие балкона: $_hasBalcony');
      print('Наличие лоджии: $_hasLoggia');
      print('Описание дома: $_houseDescription');
      print('Аренда: $_isRent');
      print('Фотографии: ${_images.map((image) => image.path).toList()}');

      // Закрываем экран после успешного добавления
      Navigator.pop(context);
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить квартиру'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Номер телефона'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите номер телефона';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phoneNumber = value!;
                },
              ),
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Район'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите район';
                  }
                  return null;
                },
                onSaved: (value) {
                  _district = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Этаж'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите этаж';
                  }
                  return null;
                },
                onSaved: (value) {
                  _floor = int.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Количество комнат'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите количество комнат';
                  }
                  return null;
                },
                onSaved: (value) {
                  _rooms = int.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Общая площадь (м²)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите общую площадь';
                  }
                  return null;
                },
                onSaved: (value) {
                  _totalArea = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Жилая площадь (м²)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите жилую площадь';
                  }
                  return null;
                },
                onSaved: (value) {
                  _livingArea = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Площадь кухни (м²)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите площадь кухни';
                  }
                  return null;
                },
                onSaved: (value) {
                  _kitchenArea = double.parse(value!);
                },
              ),
              SwitchListTile(
                title: Text('Наличие балкона'),
                value: _hasBalcony,
                onChanged: (bool value) {
                  setState(() {
                    _hasBalcony = value;
                  });
                },
              ),
              SwitchListTile(
                title: Text('Наличие лоджии'),
                value: _hasLoggia,
                onChanged: (bool value) {
                  setState(() {
                    _hasLoggia = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Описание дома'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите описание дома';
                  }
                  return null;
                },
                onSaved: (value) {
                  _houseDescription = value!;
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
                onPressed: _pickImage,
                child: Text('Добавить фотографию'),
              ),
              SizedBox(height: 20),
              _images.isNotEmpty
                  ? Wrap(
                      spacing: 8.0,
                      children: _images.map((image) {
                        return Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.file(
                              image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _images.remove(image);
                                });
                              },
                            ),
                          ],
                        );
                      }).toList(),
                    )
                  : Container(),
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
