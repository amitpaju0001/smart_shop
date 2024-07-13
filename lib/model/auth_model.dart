class AuthModel {
  String username;
  String password;

  AuthModel({required this.username, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }
  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      username: map['username'],
      password: map['password'],
    );
  }

  @override
  String toString() {
    return 'UserModel{username: $username, password: $password}';
  }
}