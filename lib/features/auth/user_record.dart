class UserRecord {
  const UserRecord({required this.nombre, required this.email});

  final String nombre;
  final String email;

  factory UserRecord.fromMap(Map<String, Object?> map) {
    return UserRecord(
      nombre: (map['usuarionombre'] ?? '') as String,
      email: (map['usuarioemail'] ?? '') as String,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'usuarionombre': nombre,
      'usuarioemail': email,
    };
  }
}
