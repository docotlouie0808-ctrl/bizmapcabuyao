import 'dart:convert';

class ResearcherMember {
  final String id;
  final String name;
  final String role;
  final String imageUrl;
  final String? bio;

  ResearcherMember({
    required this.id,
    required this.name,
    required this.role,
    required this.imageUrl,
    this.bio,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'imageUrl': imageUrl,
      'bio': bio ?? '',
    };
  }

  factory ResearcherMember.fromMap(Map<String, dynamic> map, {String? docId}) {
    return ResearcherMember(
      id: docId ?? map['id'] ?? '',
      name: map['name'] ?? '',
      role: map['role'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      bio: map['bio'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResearcherMember.fromJson(String source) =>
      ResearcherMember.fromMap(json.decode(source));
}
