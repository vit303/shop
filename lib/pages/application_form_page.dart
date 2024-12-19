import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:shop/pages_components/form_page_comp.dart';

class AplicationFormPage extends StatefulWidget {
  @override
  _ApplicationFormPageState createState() => _ApplicationFormPageState();
}

class _ApplicationFormPageState extends State<AplicationFormPage> {
  final _apartmentFormKey = GlobalKey<FormState>();
  final _clientFormKey = GlobalKey<FormState>(); // Новый ключ для формы клиента
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

  String _clientLastName = '';
  String _clientAddress = '';
  String _clientPhone = '';
  String _registrationNumber = '';
  String _descriptionPreference = '';

  final ImagePicker _picker = ImagePicker();
  final ApartmentService _apartmentService = ApartmentService();

  void _submitApartmentForm() {
    if (_apartmentFormKey.currentState!.validate()) {
      _apartmentFormKey.currentState!.save();
      _saveApartmentData();
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

  Future<void> _saveApartmentData() async {
    Map<String, dynamic> apartmentData = {
      "phoneNumber": _phoneNumber,
      "description": _description,
      "price": _price,
      "location": _location,
      "district": _district,
      "floor": _floor,
      "rooms": _rooms,
      "totalArea": _totalArea,
      "livingArea": _livingArea,
      "kitchenArea": _kitchenArea,
      "hasBalcony": _hasBalcony,
      "hasLoggia": _hasLoggia,
      "houseDescription": _houseDescription,
      "isRent": _isRent,
      "images": _images.map((image) => image.path).toList(),
    };

    await _apartmentService.saveDataToJson(apartmentData, 'lib/data_base/aplications.json');
  }

  Future<void> _saveClientData() async {
    if (_clientFormKey.currentState!.validate()) {
      _clientFormKey.currentState!.save(); // Сохраните данные клиента
      Map<String, dynamic> clientData = {
        "lastName": _clientLastName,
        "address": _clientAddress,
        "phone": _clientPhone,
        "registrationNumber": _registrationNumber,
        "description": _descriptionPreference,
      };

      // Сохраните данные клиента в формате JSON
      await _apartmentService.saveDataToJson(clientData, 'lib/data_base/clients.json');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Количество вкладок
      child: Scaffold(
        appBar: AppBar(
          title: Text('Управление квартирами'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Добавить квартиру'),
              Tab(text: 'Заявка на покупку или аренду'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Первая вкладка - форма добавления квартиры
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _apartmentFormKey,
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
                      onPressed: _submitApartmentForm, // Вызовите метод для отправки формы квартиры
                      child: Text('Добавить квартиру'),
                    ),
                  ],
                ),
              ),
            ),
            // Вторая вкладка - форма информации о клиенте
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _clientFormKey, // Используйте новый ключ для формы клиента
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
                      onPressed: _saveClientData, // Вызывайте метод для сохранения данных клиента
                      child: Text('Отправить информацию о клиенте'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
