class UserEntity {
  final String uid;
  final String? name;
  final String? email;
  final String? photo;

  UserEntity({
    required this.uid,
    this.name,
    this.email,
    this.photo,
  });
}
