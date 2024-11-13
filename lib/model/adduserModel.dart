import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String id;
  DateTime createTime;
  String name;
  String age;
  String photoUrl;
  DocumentReference? reference;

  UserModel({
    required this.id,
    required this.createTime,
    required this.name,
    required this.age,
    required this.photoUrl,
    this.reference,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      createTime: json['createTime'].toDate(),
      name: json['name'] as String,
      age: json['age'] as String,
      photoUrl: json['photoUrl'] as String,
      reference: json['reference'] as DocumentReference,
      id: json['id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["createTime"] = createTime ;
    data["id"] = id;
    data["name"] = name ;
    data["age"] = age ;
    data["photoUrl"] = photoUrl ;
    data['reference'] = reference ?? reference;
    return data;
  }

  UserModel copyWith({
    DateTime? createTime,
    String? id,
    String? name,
    String? age,
    String? photoUrl,
    DocumentReference? reference,
  }) {
    return UserModel(
      createTime: createTime ?? this.createTime,
      id: id ?? this.id,
      age: age ?? this.age,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      reference: reference ?? this.reference,
    );
  }
}