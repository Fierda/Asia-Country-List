import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail_screen.dart';
import '../models/country.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedRegion;
  List<Country> countries = [];
  bool isLoading = false;

  final regions = [
    {'label': 'Select Region', 'value': ''},
    {'label': 'South Asia', 'value': 'Southern Asia'},
    {'label': 'Southeast Asia', 'value': 'South-Eastern Asia'},
    {'label': 'East Asia', 'value': 'Eastern Asia'},
    {'label': 'Central Asia', 'value': 'Central Asia'},
    {'label': 'Western Asia', 'value': 'Western Asia'},
  ];

  Future<void> searchCountries() async {
    if (selectedRegion == null || selectedRegion!.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('https://restcountries.com/v3.1/region/asia'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final filteredData = data.where(
                (country) => country['subregion'] == selectedRegion
        ).toList();

        setState(() {
          countries = filteredData.map((json) => Country.fromJson(json)).toList();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch countries')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asian Countries'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: selectedRegion,
                isExpanded: true,
                hint: const Text('Select Region'),
                items: regions.map((region) {
                  return DropdownMenuItem(
                    value: region['value'],
                    child: Text(region['label']!),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRegion = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: selectedRegion?.isNotEmpty == true ? searchCountries : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Search'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];
                  return Card(
                    child: ListTile(
                      title: Text(country.name),
                      trailing: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(
                            country.flagUrl,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(country: country),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}