class ExperienceEntity {
  final String id;
  final String resumeId;
  final String company;
  final String position;
  final String duration;
  final String responsibilities;
  final String achievements;

  ExperienceEntity({
    required this.id,
    required this.resumeId,
    required this.company,
    required this.position,
    required this.duration,
    required this.responsibilities,
    required this.achievements,
  });
}

class EducationEntity {
  final String id;
  final String resumeId;
  final String institution;
  final String degree;
  final String graduationDate;
  final String grade;

  EducationEntity({
    required this.id,
    required this.resumeId,
    required this.institution,
    required this.degree,
    required this.graduationDate,
    required this.grade,
  });
}

class SkillEntity {
  final String id;
  final String resumeId;
  final String name;
  final double level; // 0.0 to 1.0

  SkillEntity({
    required this.id,
    required this.resumeId,
    required this.name,
    required this.level,
  });
}

class ProjectEntity {
  final String id;
  final String resumeId;
  final String title;
  final String description;
  final String technologies;
  final String url;

  ProjectEntity({
    required this.id,
    required this.resumeId,
    required this.title,
    required this.description,
    required this.technologies,
    required this.url,
  });
}

class CertificationEntity {
  final String id;
  final String resumeId;
  final String title;
  final String issuer;
  final String date;

  CertificationEntity({
    required this.id,
    required this.resumeId,
    required this.title,
    required this.issuer,
    required this.date,
  });
}

class LanguageEntity {
  final String id;
  final String resumeId;
  final String language;
  final String proficiency;

  LanguageEntity({
    required this.id,
    required this.resumeId,
    required this.language,
    required this.proficiency,
  });
}
