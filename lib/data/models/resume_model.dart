import '../../domain/entities/resume_entity.dart';

class ResumeModel extends ResumeEntity {
  ResumeModel({
    required super.id,
    required super.title,
    super.photoPath,
    required super.fullName,
    required super.jobTitle,
    required super.email,
    required super.phone,
    required super.address,
    required super.linkedin,
    required super.portfolio,
    required super.summary,
    required super.templateId,
    required super.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'photoPath': photoPath,
      'fullName': fullName,
      'jobTitle': jobTitle,
      'email': email,
      'phone': phone,
      'address': address,
      'linkedin': linkedin,
      'portfolio': portfolio,
      'summary': summary,
      'templateId': templateId,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory ResumeModel.fromMap(Map<String, dynamic> map) {
    return ResumeModel(
      id: map['id'],
      title: map['title'],
      photoPath: map['photoPath'],
      fullName: map['fullName'],
      jobTitle: map['jobTitle'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
      linkedin: map['linkedin'],
      portfolio: map['portfolio'],
      summary: map['summary'],
      templateId: map['templateId'],
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  factory ResumeModel.fromEntity(ResumeEntity entity) {
    return ResumeModel(
      id: entity.id,
      title: entity.title,
      photoPath: entity.photoPath,
      fullName: entity.fullName,
      jobTitle: entity.jobTitle,
      email: entity.email,
      phone: entity.phone,
      address: entity.address,
      linkedin: entity.linkedin,
      portfolio: entity.portfolio,
      summary: entity.summary,
      templateId: entity.templateId,
      updatedAt: entity.updatedAt,
    );
  }
}
