import 'package:flutter/material.dart';
import 'package:shop/apartment/apartment.dart';
import 'package:shop/pages/apartment_detail_page.dart';
import 'package:shop/pages/application_form_page.dart';

class HomePageComp {
  late Future<List<Apartment>> futureApartments;

  // Переменные для фильтров
  String selectedSort = 'По умолчанию';
  String selectedType = 'Все';

  HomePageComp() {
    futureApartments = loadApartmentsFromJson('lib/data_base/apartments.json');
  }

  void onApartmentTap(BuildContext context, Apartment apartment) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ApartmentDetailPage(apartment: apartment),
      ),
    );
  }

  Future<List<Apartment>> filterAndSortApartments(List<Apartment> apartments) async {
    List<Apartment> filteredApartments;

    // Фильтрация по типу
    if (selectedType == 'Аренда') {
      filteredApartments = apartments.where((apartment) => apartment.rent).toList();
    } else if (selectedType == 'Покупка') {
      filteredApartments = apartments.where((apartment) => !apartment.rent).toList();
    } else {
      // Если выбран "Все", просто копируем оригинальный список
      filteredApartments = List.from(apartments);
    }

    // Если выбран "По умолчанию", возвращаем отфильтрованный список в оригинальном порядке
    if (selectedSort == 'По умолчанию') {
      return filteredApartments; // Возвращаем отфильтрованный список
    }

    // Сортировка по цене
    if (selectedSort == 'От дешевого к дорогому') {
      filteredApartments.sort((a, b) => a.price.toDouble().compareTo(b.price.toDouble()));
    } else if (selectedSort == 'От дорогого к дешевому') {
      filteredApartments.sort((a, b) => b.price.toDouble().compareTo(a.price.toDouble()));
    }

    return filteredApartments;
  }

  void goHome(BuildContext context) {
    // Логика для перехода на главную страницу
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void addApartment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AplicationFormPage()),
    );
  }
}
