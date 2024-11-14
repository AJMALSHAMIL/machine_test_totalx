import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  DateTime createTime;
  String name;
  int age;
  String photoUrl;
  List<dynamic> search;

  UserModel(
      {required this.createTime,
      required this.name,
      required this.age,
      required this.photoUrl,
      required this.search});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      createTime: json['createTime'].toDate(),
      name: json['name'] as String,
      age: json['age'] as int,
      photoUrl: json['photoUrl'] as String,
      search: json['search'] as List<dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["createTime"] = createTime;
    data["name"] = name;
    data["age"] = age;
    data["photoUrl"] = photoUrl;
    data['search'] = search;
    return data;
  }

  UserModel copyWith({
    DateTime? createTime,
    String? id,
    String? name,
    int? age,
    String? photoUrl,
    List<dynamic>? search,
  }) {
    return UserModel(
      createTime: createTime ?? this.createTime,
      age: age ?? this.age,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      search: search ?? this.search,
    );
  }
}
