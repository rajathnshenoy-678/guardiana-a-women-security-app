class UserModel {
  String? name;
  String? id;
  String? phone;
  String? userEmail;
  String? guardianEmail;
  String? type;
  UserModel(
      {this.name, this.id, this.phone, this.userEmail, this.guardianEmail,this.type});

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'id': id,
        'userEmail': userEmail,
        'guardianEmail': guardianEmail,
        'type': type,
      };
}
