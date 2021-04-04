import 'package:flutter/material.dart';
import '../models/note.dart';
import '../data/databaseHelper.dart';
import '../screens/add_note.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  DbHelper helper;
  @override
  void initState() {
    super.initState();
    helper = DbHelper();
  }

  refreshOnBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.search,
          ),
          onPressed: () {},
        ),
        title: Text(
          'Notes',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.grid_on_rounded,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: FutureBuilder(
        future: helper.allNotes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            //Loding progress indicator
            return Padding(
              padding: EdgeInsets.only(top: 15),
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff4CAF50)),
                backgroundColor: Colors.white,
              ),
            );
          } else if (snapshot?.data?.isEmpty ?? true) {
            //If there are no students show Empty Icon with no student text
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox_rounded,
                    size: 120,
                    color: Colors.grey.withOpacity(.8),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'No Notes Yet',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.withOpacity(.8),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              Note note = Note.fromMap(snapshot.data[index]);
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddNote(
                          note: note,
                        ),
                      )).then(refreshOnBack);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                        width: 2.5,
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            note.noteTitle,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Spacer(),
                          Row(
                            children: List.generate(
                              note.notePriority,
                              (index) => SizedBox(
                                width: 10,
                                child: Icon(
                                  Icons.priority_high_rounded,
                                  color: note.notePriority == 1
                                      ? Colors.green
                                      : note.notePriority == 2
                                          ? Colors.yellow
                                          : Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(
                        note.noteDesc,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          note.noteDate,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddNote()))
              .then(refreshOnBack);
        },
        child: Icon(Icons.add, color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        mini: false,
        shape: StadiumBorder(
          side: BorderSide(
            color: Colors.black,
            width: 2.5,
          ),
        ),
      ),
    );
  }
}
