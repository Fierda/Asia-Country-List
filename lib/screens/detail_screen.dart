import 'package:flutter/material.dart';
import '../models/country.dart';

class DetailScreen extends StatelessWidget {
  final Country country;

  const DetailScreen({super.key, required this.country});

  Widget _buildInfoItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(country.name),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              color: Colors.grey[100],
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                ),
                child: Image.network(
                  country.flagUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoItem('Official Name', country.officialName),
                  _buildInfoItem('Capital', country.capital),
                  _buildInfoItem('Population', country.population.toString()),
                  _buildInfoItem('Region', country.subregion),
                  _buildInfoItem('Languages', country.languages),
                  _buildInfoItem('Currencies', country.currencies),
                  _buildInfoItem('Time Zones', country.timezones),
                  _buildInfoItem('Calling Code', country.callingCode),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}