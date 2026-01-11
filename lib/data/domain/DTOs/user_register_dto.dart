class UserRegisterDto {
  final String uuid;
  final String nome;
  final String email;

  UserRegisterDto({required this.uuid, required this.nome, required this.email});

  Map<String, String> toJson(){
    return {"uuid": uuid, "nome": nome, "email": email};
  }
}