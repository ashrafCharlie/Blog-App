class UserDataModel {
  final String name;
  final String email;
  UserDataModel({required this.name, required this.email});

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name, 
      'email': email
      };
  }
}
