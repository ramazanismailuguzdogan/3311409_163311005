final String tableUsers = 'users';

class UsersFields {
  static final List<String> values = [
    id, email, password
  ];

  static final String id = '_id';
  static final String email = 'email';
  static final String password = 'password';
}

class User {
  final int? id;
  final String email;
  final String password;

  const User({
    this.id,
    required this.email,
    required this.password,
  });

  User copy({
    int? id,
    String? title,
    String? description,
  }) =>
      User(
        id: id ?? this.id,
        email: title ?? this.email,
        password: description ?? this.password,
      );

  static User fromJson(Map<String, Object?> json) => User(
    id: json[UsersFields.id] as int?,
    email: json[UsersFields.email] as String,
    password: json[UsersFields.password] as String,
  );

  Map<String, Object?> toJson() => {
    UsersFields.id: id,
    UsersFields.email: email,
    UsersFields.password: password,
  };
}