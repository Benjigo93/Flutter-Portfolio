class Pokemon {
  final int id;
  final String name;
  final String image;

  const Pokemon({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final id = json['id'] ?? int.parse(json['url'].split('/').reversed.elementAt(1));
    return Pokemon(
      id: id,
      name: json['name'],
      image: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}