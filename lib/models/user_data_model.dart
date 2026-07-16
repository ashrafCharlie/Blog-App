class UserDataModel {
  final String name;
  final String email;
  
  UserDataModel({required this.name, required this.email});

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(name: map['name'] ?? '', email: map['email'] ?? '' );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email};
  }
}
