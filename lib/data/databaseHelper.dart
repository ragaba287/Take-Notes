import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/note.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;
  DbHelper.internal();
  static Database _db;

  //Database Name
  static const _DatabaseName = 'Notes.db';

  static const _NotesTable = 'notesTable';
  static const _NoteId = 'noteId';
  static const _NoteTitle = 'noteTitle';
  static const _NoteDesc = 'noteDesc';
  static const _NotePriority = 'notePriority';
  static const _NoteDate = 'noteDate';
  static const _NoteColor = 'noteColor';

  Future<Database> createDatabase() async {
    if (_db != null) {
      return _db;
    }

    String path = join(await getDatabasesPath(), _DatabaseName);
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int v) {
        db.execute(
            'CREATE TABLE $_NotesTable ($_NoteId INTEGER PRIMARY KEY AUTOINCREMENT,$_NoteTitle varchar(255) , $_NoteDesc varchar(255), $_NotePriority INTEGER ,$_NoteDate varchar(50), $_NoteColor varchar(10))');
      },
    );
    return _db;
  }

  closeDatabase() async {
    Database db = await createDatabase();
    await db.close();
  }

  Future<int> newNote(Note note) async {
    Database db = await createDatabase();
    return db.insert(_NotesTable, note.toMap());
  }

  Future<List> allNotes() async {
    Database db = await createDatabase();
    return db.query(_NotesTable);
  }

  Future<int> updateCity(Note note) async {
    Database db = await createDatabase();
    return db.update(
      _NotesTable,
      note.toMap(),
      where: '$_NoteId = ?',
      whereArgs: [note.noteId],
    );
  }

  Future<int> deleteNote(Note note) async {
    Database db = await createDatabase();
    return db.delete(
      _NotesTable,
      where: '$_NoteId = ?',
      whereArgs: [note.noteId],
    );
  }

  Future deleteAll() async {
    Database db = await createDatabase();
    db.delete(_NotesTable);
  }
}
