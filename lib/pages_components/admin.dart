

class Admin {
  final String name;
  final int id;
  final String code;

  Admin({
    required this.name,
    required this.id,
    required this.code
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      name: json['name'],
      id: json['id'],
      code: json['code'],
    );
  }
}

