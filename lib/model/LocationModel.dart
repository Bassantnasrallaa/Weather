class Location {
  String? name;
  String? country;

  Location(
      {this.name,
        this.country});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
  }
}