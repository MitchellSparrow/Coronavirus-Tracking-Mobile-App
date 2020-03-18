class Album {
  final int latest;
  final String last_updated;
  final List clocations;
  final List dlocations;
  final List rlocations;
  final int confirmed;
  final int deaths;
  final int recovered;

  Album(
      {this.latest,
      this.last_updated,
      this.clocations,
      this.confirmed,
      this.deaths,
      this.recovered,
      this.dlocations,
      this.rlocations});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      confirmed: json['latest']['confirmed'],
      deaths: json['latest']['deaths'],
      recovered: json['latest']['recovered'],
      latest: json['latest']['confirmed'],
      last_updated: json['last_updated'],
      clocations: json['confirmed']['locations'],
      dlocations: json['deaths']['locations'],
      rlocations: json['recovered']['locations'],
    );
  }
}

class TotalsAlbum {
  final int last_updated;
  final int cases;
  final int deaths;
  final int recovered;

  TotalsAlbum({
    this.last_updated,
    this.cases,
    this.deaths,
    this.recovered,
  });

  factory TotalsAlbum.fromJson(Map<String, dynamic> json) {
    return TotalsAlbum(
      cases: json['cases'],
      deaths: json['deaths'],
      recovered: json['recovered'],
      last_updated: json['updated'],
    );
  }
}

class CountryList {
  final List<CountryAlbum> countries;

  CountryList({
    this.countries,
  });

  factory CountryList.fromJson(List<dynamic> parsedJson) {
    List<CountryAlbum> countries = new List<CountryAlbum>();
    countries = parsedJson.map((i) => CountryAlbum.fromJson(i)).toList();
    //print(countries[1].country);
    return new CountryList(countries: countries);
  }
}

class CountryAlbum {
  final String country;
  final int countryCases;
  final int countryDeaths;
  final int countryRecoveries;
  final int countryTodayCases;
  final int countryTodayDeaths;
  final int countryCritical;

  CountryAlbum({
    this.country,
    this.countryCases,
    this.countryDeaths,
    this.countryRecoveries,
    this.countryTodayCases,
    this.countryTodayDeaths,
    this.countryCritical,
  });

  factory CountryAlbum.fromJson(Map<String, dynamic> json) {
    return new CountryAlbum(
      country: json['country'].toString(),
      countryCases: json['cases'],
      countryDeaths: json['deaths'],
      countryRecoveries: json['recovered'],
      countryTodayCases: json['todayCases'],
      countryTodayDeaths: json['todayDeaths'],
      countryCritical: json['critical'],
    );
  }
}
