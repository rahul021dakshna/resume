class ResumeEntity {
  final String id;
  final String title;
  final String? photoPath;
  final String fullName;
  final String jobTitle;
  final String email;
  final String phone;
  final String address;
  final String linkedin;
  final String portfolio;
  final String summary;
  final String templateId;
  final DateTime updatedAt;

  ResumeEntity({
    required this.id,
    required this.title,
    this.photoPath,
    required this.fullName,
    required this.jobTitle,
    required this.email,
    required this.phone,
    required this.address,
    required this.linkedin,
    required this.portfolio,
    required this.summary,
    required this.templateId,
    required this.updatedAt,
  });

  ResumeEntity copyWith({
    String? id,
    String? title,
    String? photoPath,
    String? fullName,
    String? jobTitle,
    String? email,
    String? phone,
    String? address,
    String? linkedin,
    String? portfolio,
    String? summary,
    String? templateId,
    DateTime? updatedAt,
  }) {
    return ResumeEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      photoPath: photoPath ?? this.photoPath,
      fullName: fullName ?? this.fullName,
      jobTitle: jobTitle ?? this.jobTitle,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      linkedin: linkedin ?? this.linkedin,
      portfolio: portfolio ?? this.portfolio,
      summary: summary ?? this.summary,
      templateId: templateId ?? this.templateId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
