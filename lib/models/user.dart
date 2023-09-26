class User {
  String? id;
  String? email;
  String? name;
  String? phone;
  String? password;

  User({this.id, this.email, this.name, this.phone, this.password});

  User.fromJson(Map user) {
    id = user['user_id'] ?? "";
    email = user['user_email'] ?? "";
    name = user['user_firstname'] ?? "";
    phone = user['user_phone'] ?? "";
    password = user['user_password'] ?? "";
  }

  toJson() {
    return {'user_id': id, 'user_email': email, 'user_firstname': name, 'user_phone': phone, 'user_password': password};
  }
}
