class UserDto {
  final String nome;
  final String email;
  final String password;

  UserDto({required this.nome, required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {"email": email, "password": password};
  }
}
