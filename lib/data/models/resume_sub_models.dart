import '../../domain/entities/resume_sub_entities.dart';

class ExperienceModel extends ExperienceEntity {
  ExperienceModel({
    required super.id,
    required super.resumeId,
    required super.company,
    required super.position,
    required super.duration,
    required super.responsibilities,
    required super.achievements,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'resumeId': resumeId,
      'company': company,
      'position': position,
      'duration': duration,
      'responsibilities': responsibilities,
      'achievements': achievements,
    };
  }

  factory ExperienceModel.fromMap(Map<String, dynamic> map) {
    return ExperienceModel(
      id: map['id'],
      resumeId: map['resumeId'],
      company: map['company'],
      position: map['position'],
      duration: map['duration'],
      responsibilities: map['responsibilities'],
      achievements: map['achievements'],
    );
  }
}

class EducationModel extends EducationEntity {
  EducationModel({
    required super.id,
    required super.resumeId,
    required super.institution,
    required super.degree,
    required super.graduationDate,
    required super.grade,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'resumeId': resumeId,
      'institution': institution,
      'degree': degree,
      'graduationDate': graduationDate,
      'grade': grade,
    };
  }

  factory EducationModel.fromMap(Map<String, dynamic> map) {
    return EducationModel(
      id: map['id'],
      resumeId: map['resumeId'],
      institution: map['institution'],
      degree: map['degree'],
      graduationDate: map['graduationDate'],
      grade: map['grade'],
    );
  }
}

class SkillModel extends SkillEntity {
  SkillModel({
    required super.id,
    required super.resumeId,
    required super.name,
    required super.level,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'resumeId': resumeId,
      'name': name,
      'level': level,
    };
  }

  factory SkillModel.fromMap(Map<String, dynamic> map) {
    return SkillModel(
      id: map['id'],
      resumeId: map['resumeId'],
      name: map['name'],
      level: (map['level'] as num).toDouble(),
    );
  }
}

class ProjectModel extends ProjectEntity {
  ProjectModel({
    required super.id,
    required super.resumeId,
    required super.title,
    required super.description,
    required super.technologies,
    required super.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'resumeId': resumeId,
      'title': title,
      'description': description,
      'technologies': technologies,
      'url': url,
    };
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'],
      resumeId: map['resumeId'],
      title: map['title'],
      description: map['description'],
      technologies: map['technologies'],
      url: map['url'],
    );
  }
}

class CertificationModel extends CertificationEntity {
  CertificationModel({
    required super.id,
    required super.resumeId,
    required super.title,
    required super.issuer,
    required super.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'resumeId': resumeId,
      'title': title,
      'issuer': issuer,
      'date': date,
    };
  }

  factory CertificationModel.fromMap(Map<String, dynamic> map) {
    return CertificationModel(
      id: map['id'],
      resumeId: map['resumeId'],
      title: map['title'],
      issuer: map['issuer'],
      date: map['date'],
    );
  }
}

class LanguageModel extends LanguageEntity {
  LanguageModel({
    required super.id,
    required super.resumeId,
    required super.language,
    required super.proficiency,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'resumeId': resumeId,
      'language': language,
      'proficiency': proficiency,
    };
  }

  factory LanguageModel.fromMap(Map<String, dynamic> map) {
    return LanguageModel(
      id: map['id'],
      resumeId: map['resumeId'],
      language: map['language'],
      proficiency: map['proficiency'],
    );
  }
}
