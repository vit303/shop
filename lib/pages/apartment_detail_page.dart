import 'package:flutter/material.dart';
import 'package:shop/apartment/apartment.dart';

class ApartmentDetailPage extends StatelessWidget {
  final Apartment apartment;

  const ApartmentDetailPage({Key? key, required this.apartment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(apartment.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            apartment.image,
            fit: BoxFit.cover,
            height: 700, 
            width: double.infinity, 
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
        ],
      ),
    );
  }
}