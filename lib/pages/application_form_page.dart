// lib/pages/aplication_form_page.dart
import 'package:flutter/material.dart';
import 'package:shop/forms/apartment_form.dart';
import 'package:shop/forms/client_form.dart';
import 'package:shop/pages_components/form_page_comp.dart';
import 'package:shop/apartment/apartment.dart';


class AplicationFormPage extends StatelessWidget {
  final ApartmentService _apartmentService = ApartmentService();

  void _submitApartment(Apartment apartment) {
    _apartmentService.saveDataToJson(apartment.toJson(), 'lib/data_base/aplications.json');
  }

  void _submitClientData(Map<String, dynamic> clientData) {
    
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
            ApartmentForm(onSubmit: _submitApartment),
            ClientForm(onSubmit: _submitClientData),
          ],
        ),
      ),
    );
  }
}
