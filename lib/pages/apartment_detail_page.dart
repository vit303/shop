import 'package:flutter/material.dart';
import 'package:shop/apartment/apartment.dart';
import 'package:shop/pages/ImageGalleryPage.dart';
import 'package:shop/pages/customer_page.dart';

class ApartmentDetailPage extends StatelessWidget {
  final Apartment apartment;

  const ApartmentDetailPage({Key? key, required this.apartment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(apartment.title),
      ),
      body: SingleChildScrollView( // Добавляем прокручиваемый виджет
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.7, // 70% высоты экрана
              width: double.infinity,
              child: Image.asset(
                apartment.image[0],
                fit: BoxFit.contain, // Изменено на BoxFit.contain для отображения изображения целиком
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '${apartment.rent ? "Аренда" : "Покупка"} \$${apartment.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                apartment.description,
                style: TextStyle(fontSize: 16),
              ),
            ),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Расположение: ${apartment.location}",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageGalleryPage(images: apartment.image),
                    ),
                  );
                },
                child: Text('Посмотреть все изображения'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomerPage(apartment: apartment),
                    ),
                  );
                },
                child: Text('Оставить заявку на покупку'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
