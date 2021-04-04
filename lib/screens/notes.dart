import 'package:flutter/material.dart';
import 'package:take_notes/screens/add_note.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
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
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, num) {
          return NoteCon();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNote()));
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

class NoteCon extends StatelessWidget {
  NoteCon({
    this.noteHead = 'Note Title',
    this.noteDec = 'Note description goes here',
    this.noteTime = 'May 10.2019',
    this.noteColor = Colors.blue,
    this.priority = 1,
    this.priorityColor = Colors.red,
  });
  final String noteHead;
  final String noteDec;
  final String noteTime;
  final Color noteColor;
  final int priority;
  final Color priorityColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: noteColor,
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
                noteHead,
                style: Theme.of(context).textTheme.headline1,
              ),
              Spacer(),
              Row(
                children: List.generate(
                  priority,
                  (index) => SizedBox(
                    width: 10,
                    child: Icon(
                      Icons.priority_high_rounded,
                      color: priorityColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Text(
            noteDec,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: 5),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              noteTime,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
