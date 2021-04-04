import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:take_notes/data/databaseHelper.dart';
import 'package:take_notes/models/note.dart';

class AddNote extends StatefulWidget {
  AddNote({this.note});
  final Note note;
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  DbHelper _helper;
  TextEditingController teTitle = TextEditingController();
  TextEditingController teDesc = TextEditingController();
  List<bool> isSelected = [true, false, false];
  int priorityLevel = 1;
  @override
  void initState() {
    super.initState();
    _helper = DbHelper();
    if (widget.note != null) {
      teTitle.text = widget.note.noteTitle;
      teDesc.text = widget.note.noteDesc;
      priorityLevel = widget.note.notePriority;
      isSelected = [
        widget.note.notePriority == 1,
        widget.note.notePriority == 2,
        widget.note.notePriority == 3
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.note != null ? 'Edit Note' : 'Add Note',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              if (widget.note == null) {
                Note note = Note({
                  'noteTitle': teTitle.text,
                  'noteDesc': teDesc.text,
                  'notePriority': priorityLevel,
                  'noteDate': DateFormat("MMM d.yyyy").format(DateTime.now()),
                  'noteColor': '0xffF92472',
                });
                await _helper.newNote(note);
              } else {
                Note note = Note({
                  'noteId': widget.note.noteId,
                  'noteTitle': teTitle.text,
                  'noteDesc': teDesc.text,
                  'notePriority': priorityLevel,
                  'noteDate': widget.note.noteDate,
                  'noteColor': '0xffF92472',
                });
                await _helper.updateCity(note);
              }
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await _helper.deleteNote(widget.note.noteId);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ToggleButtons(
              borderRadius: BorderRadius.circular(8),
              fillColor: Colors.green,
              selectedBorderColor: Colors.black,
              selectedColor: Colors.white,
              borderWidth: 2.5,
              onPressed: (int newIndex) {
                setState(() {
                  for (int index = 0; index < isSelected.length; index++) {
                    if (index == newIndex) {
                      isSelected[index] = true;
                    } else {
                      isSelected[index] = false;
                    }
                  }
                });
                priorityLevel = newIndex + 1;
              },
              children: [
                PriorityCon(
                  priorityLevel: 'Low',
                ),
                PriorityCon(
                  priorityLevel: 'High',
                ),
                PriorityCon(
                  priorityLevel: 'Very High',
                ),
              ],
              isSelected: isSelected,
            ),
            Container(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, i) => Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 20, 20),
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.black, width: 2.5),
                  ),
                  child: Visibility(
                    visible: false,
                    child: IconButton(
                      icon: Icon(
                        Icons.check,
                        size: 20,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),
            TextField(
              controller: teTitle,
              style: TextStyle(fontWeight: FontWeight.bold),
              maxLength: 255,
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(fontWeight: FontWeight.bold),
                border: InputBorder.none,
              ),
            ),
            TextField(
              controller: teDesc,
              keyboardType: TextInputType.multiline,
              maxLines: 15,
              maxLength: 255,
              decoration: InputDecoration(
                hintText: 'Description',
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PriorityCon extends StatelessWidget {
  PriorityCon({
    this.priorityLevel = 'Low',
    this.onTap,
  });
  final String priorityLevel;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Text(
          priorityLevel,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
