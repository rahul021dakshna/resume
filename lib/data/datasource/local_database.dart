import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._init();
  static Database? _database;

  LocalDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('resume_builder.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const textNullableType = 'TEXT';
    const realType = 'REAL NOT NULL';

    await db.execute('''
      CREATE TABLE resumes (
        id $idType,
        title $textType,
        photoPath $textNullableType,
        fullName $textType,
        jobTitle $textType,
        email $textType,
        phone $textType,
        address $textType,
        linkedin $textType,
        portfolio $textType,
        summary $textType,
        templateId $textType,
        updatedAt $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE experiences (
        id $idType,
        resumeId $textType,
        company $textType,
        position $textType,
        duration $textType,
        responsibilities $textType,
        achievements $textType,
        FOREIGN KEY (resumeId) REFERENCES resumes (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE education (
        id $idType,
        resumeId $textType,
        institution $textType,
        degree $textType,
        graduationDate $textType,
        grade $textType,
        FOREIGN KEY (resumeId) REFERENCES resumes (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE skills (
        id $idType,
        resumeId $textType,
        name $textType,
        level $realType,
        FOREIGN KEY (resumeId) REFERENCES resumes (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE projects (
        id $idType,
        resumeId $textType,
        title $textType,
        description $textType,
        technologies $textType,
        url $textType,
        FOREIGN KEY (resumeId) REFERENCES resumes (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE certifications (
        id $idType,
        resumeId $textType,
        title $textType,
        issuer $textType,
        date $textType,
        FOREIGN KEY (resumeId) REFERENCES resumes (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE languages (
        id $idType,
        resumeId $textType,
        language $textType,
        proficiency $textType,
        FOREIGN KEY (resumeId) REFERENCES resumes (id) ON DELETE CASCADE
      )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
