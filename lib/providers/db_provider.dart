import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:yt_download/models/id_model.dart';
import 'package:yt_download/models/thumbnail_model.dart';
import 'package:yt_download/models/video_database_model.dart';
import 'package:yt_download/models/video_model.dart';
import 'package:yt_download/providers/tabela.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database!;

    // If database don't exists, create one
    _database = await initDB();

    return _database!;
  }

  // Create the database and the Employee table
  initDB() async {
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(await getDatabasesPath(), 'yt_download.db');

    // Deleta banco de dados
    await deleteDatabase(path);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(Database db, int version) async {
    await db.execute(Tabela.tableVideoContents);
  }

  createVideoContents(Video newVideo) async {
    final db = await database;
    Id videoId = newVideo.id;
    Snippet videoConteudo = newVideo.snippet;
    Thumbnails thumbnail = videoConteudo.thumbnail.thumbnails;

    VideoDatabase videoDatabase = VideoDatabase(
        videoId: videoId.id,
        kind: videoId.kind,
        title: videoConteudo.title,
        description: videoConteudo.description,
        channelTitle: videoConteudo.channelTitle,
        url: thumbnail.url,
        width: thumbnail.width,
        height: thumbnail.height);
    print("Criando ${videoDatabase.title}");
    final res = await db.insert(
      "VideoContents",
      videoDatabase.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return res;
  }

  Future<List<VideoDatabase>> getAllVideoContents() async {
    final db = await database;
    final res = await db.query('VideoContents');

    return res.isNotEmpty
        ? res.map((e) => VideoDatabase.fromJson(e)).toList()
        : [];
  }

  Future<int> deleteAllVideoContents() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM VideoContents');

    return res;
  }
}
