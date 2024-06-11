class Character {
  String name;
  String house;
  String dateOfBirth;
  String actor;
  String species;
  bool guessed;
  int attempts;

  Character({
    required this.name,
    required this.house,
    required this.dateOfBirth,
    required this.actor,
    required this.species,
    this.guessed = false,
    this.attempts = 0,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'house': house,
        'dateOfBirth': dateOfBirth,
        'species': species,
        'actor': actor,
      };

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        name: json['name'],
        house: json['house'],
        dateOfBirth: json['dateOfBirth'],
        actor: json['actor'],
        species: json['species'],
      );

  Map<String, dynamic> toJsonFromCurrent() => {
        'name': name,
        'house': house,
        'dateOfBirth': dateOfBirth,
        'species': species,
        'actor': actor,
        'guessed': guessed,
        'attempts': attempts,
      };

  factory Character.fromJsonToCurrent(Map<String, dynamic> json) => Character(
        name: json['name'],
        house: json['house'],
        dateOfBirth: json['dateOfBirth'],
        actor: json['actor'],
        species: json['species'],
        guessed: json['guessed'] ?? false,
        attempts: json['attempts'] ?? 0,
      );
}
