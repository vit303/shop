import 'package:flutter/material.dart';
import 'package:shop/apartment/apartment.dart';
import 'package:shop/pages_components/home_page_comp.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageComp homePageComp;

  @override
  void initState() {
    super.initState();
    homePageComp = HomePageComp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120), 
        child: AppBar(
          title: Text('Квартиры'),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 143, 145, 233),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<String>(
                    value: homePageComp.selectedSort,
                    icon: const Icon(Icons.sort),
                    onChanged: (String? newValue) {
                      setState(() {
                        homePageComp.selectedSort = newValue!;
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
                    value: homePageComp.selectedType,
                    icon: const Icon(Icons.filter_list),
                    onChanged: (String? newValue) {
                      setState(() {
                        homePageComp.selectedType = newValue!;
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
        future: homePageComp.futureApartments,
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
              future: homePageComp.filterAndSortApartments(apartments),
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
                        onTap: () => homePageComp.onApartmentTap(context, apartment),
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
                                        '\${apartment.price.toStringAsFixed(2)} - ${apartment.rent ? "Аренда" : "Покупка"} \nРасположение: ${apartment.location}',
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
              onPressed: () => homePageComp.goHome(context),
              tooltip: "",
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => homePageComp.addApartment(context),
              tooltip: 'Добавить квартиру',
            ),
          ],
        ),
      ),
    );
  }
}
