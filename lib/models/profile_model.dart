class ProfileModel {
  final String id;
  final String email;

  final String firstName;
  final String lastName;

  ProfileModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}
