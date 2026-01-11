class UserModel {
  final String nome;
  final String email;
  final String uuid;

  UserModel({required this.nome, required this.email, required this.uuid});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      nome: json["nome"],
      email: json["email"],
      uuid: json["uuid"],
    );
  }
}
