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
