class Country {
  final String name;
  final String officialName;
  final String capital;
  final int population;
  final String subregion;
  final String languages;
  final String currencies;
  final String timezones;
  final String callingCode;
  final String flagUrl;

  Country({
    required this.name,
    required this.officialName,
    required this.capital,
    required this.population,
    required this.subregion,
    required this.languages,
    required this.currencies,
    required this.timezones,
    required this.callingCode,
    required this.flagUrl,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'] ?? 'N/A',
      officialName: json['name']['official'] ?? 'N/A',
      capital: (json['capital'] as List?)?.first ?? 'N/A',
      population: json['population'] ?? 0,
      subregion: json['subregion'] ?? 'N/A',
      languages: (json['languages'] as Map<String, dynamic>?)?.values.join(', ') ?? 'N/A',
      currencies: (json['currencies'] as Map<String, dynamic>?)?.values
          .map((curr) => curr['name'])
          .join(', ') ?? 'N/A',
      timezones: (json['timezones'] as List?)?.join(', ') ?? 'N/A',
      callingCode: json['idd']?['root'] ?? 'N/A',
      flagUrl: json['flags']['png'] ?? '',
    );
  }
}