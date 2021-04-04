class Note {
  int _id;
  String _noteTitle;
  String _noteDesc;
  int _notePriority;
  String _noteDate;
  String _noteColor;

  Note(dynamic obj) {
    _id = obj['noteId'];
    _noteTitle = obj['noteTitle'];
    _noteDesc = obj['noteDesc'];
    _notePriority = obj['notePriority'];
    _noteDate = obj['noteDate'];
    _noteColor = obj['noteColor'];
  }

  Note.fromMap(Map<String, dynamic> data) {
    _id = data['noteId'];
    _noteTitle = data['noteTitle'];
    _noteDesc = data['noteDesc'];
    _notePriority = data['notePriority'];
    _noteDate = data['noteDate'];
    _noteColor = data['noteColor'];
  }

  Map<String, dynamic> toMap() => {
        'noteId': _id,
        'noteTitle': _noteTitle,
        'noteDesc': _noteDesc,
        'notePriority': _notePriority,
        'noteDate': _noteDate,
        'noteColor': _noteColor,
      };

  int get noteId => _id;
  String get noteTitle => _noteTitle;
  String get noteDesc => _noteDesc;
  int get notePriority => _notePriority;
  String get noteDate => _noteDate;
  String get noteColor => _noteColor;
}
