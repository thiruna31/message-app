class UserModel {
  final String uid;
  final String firstName;
  final String lastName;
  final String role;
  final DateTime? registeredAt;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.role,
    this.registeredAt,
  });

  factory UserModel.fromMap(String uid, Map<String, dynamic> map) {
    final ts = map['registeredAt'];
    DateTime? dt;
    if (ts != null) {
      if (ts is DateTime) dt = ts;
      else if (ts is int) dt = DateTime.fromMillisecondsSinceEpoch(ts);
      else if (ts is String) dt = DateTime.tryParse(ts);
    }
    return UserModel(
      uid: uid,
      firstName: map['firstname'] ?? '',
      lastName: map['lastname'] ?? '',
      role: map['role'] ?? 'user',
      registeredAt: dt,
    );
  }
}
