class Qa {
  final int id;
  final String theme;
  final String question;
  final String reponse;

  const Qa({
    required this.id,
    required this.theme,
    required this.question,
    required this.reponse,
  });

  factory Qa.fromJson(Map<String, dynamic> json) {
    return Qa(
      id: json['id'],
      theme: json['theme'],
      question: json['question'],
      reponse: json['reponse'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'theme': theme,
      'question': question,
      'reponse': reponse,
    };
  }
}