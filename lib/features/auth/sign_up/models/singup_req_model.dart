class SingupReqModel {
  String name;
  String email;
  String password;
  String avatar = "https://lipsum.app/640x480/000/fff";
  SingupReqModel({
    required this.name,
    required this.email,
    required this.password,
  });
}
