import 'package:flutter/material.dart';
import 'package:shop/apartment/apartment.dart';
import 'package:shop/pages/apartment_detail_page.dart';
import 'package:shop/pages/application_form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Apartment>> futureApartments;

  // Переменные для фильтров
  String selectedSort = 'По умолчанию';
  String selectedType = 'Все';

  @override
  void initState() {
    super.initState();
    futureApartments = loadApartmentsFromJson();
  }

  void _onApartmentTap(Apartment apartment) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ApartmentDetailPage(apartment: apartment),
      ),
    );
  }

  // Метод для фильтрации и сортировки квартир
  Future<List<Apartment>> _filterAndSortApartments(List<Apartment> apartments) async {
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

  void _goHome() {
    // Логика для перехода на главную страницу
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void _addApartment() {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AplicationFormPage()),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120), // Увеличьте высоту AppBar
        child: AppBar(
          title: Text('Квартиры'),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 143, 145, 233),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40), // Высота для фильтров
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<String>(
                    value: selectedSort,
                    icon: const Icon(Icons.sort),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSort = newValue!;
                      });
                    },
                    items: <String>[
                      'По умолчанию',
                      'От дешевого к дорогому',
                      'От дорогого к дешевому'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  DropdownButton<String>(
                    value: selectedType,
                    icon: const Icon(Icons.filter_list),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedType = newValue!;
                      });
                    },
                    items: <String>[
                      'Все',
                      'Аренда',
                      'Покупка'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
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
            return Center(child: Text('No apartments available.'));
          } else {
            final apartments = snapshot.data!;
            return FutureBuilder<List<Apartment>>(
              future: _filterAndSortApartments(apartments),
              builder: (context, filteredSnapshot) {
                if (filteredSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (filteredSnapshot.hasError) {
                  return Center(child: Text('Error: ${filteredSnapshot.error}'));
                } else if (!filteredSnapshot.hasData || filteredSnapshot.data!.isEmpty) {
                  return Center(child: Text('No apartments available.'));
                } else {
                  final filteredApartments = filteredSnapshot.data!;
                  return ListView.builder(
                    itemCount: filteredApartments.length,
                    itemBuilder: (context, index) {
                      final apartment = filteredApartments[index];
                      return GestureDetector(
                        onTap: () => _onApartmentTap(apartment),
                        child: Card(
                          child: Container(
                            height: 300,
                            child: Row(
                              children: [
                                Container(
                                  child: Image.asset(
                                    apartment.image[0],
                                    fit: BoxFit.contain, 
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(apartment.description),
                                      Text(
                                        '\$${apartment.price.toStringAsFixed(2)} - ${apartment.rent ? "Аренда" : "Покупка"} \nРасположение: ${apartment.location}',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: _goHome,
              tooltip: "",
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: _addApartment,
              tooltip: 'Добавить квартиру',
            ),
          ],
        ),
      ),
    );
  }
}
