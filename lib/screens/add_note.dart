import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
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
          'Add Note',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PriorityCon(priorityLevel: 'Low'),
                PriorityCon(priorityLevel: 'High'),
                PriorityCon(priorityLevel: 'Very High'),
              ],
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
            TextField(
              style: TextStyle(fontWeight: FontWeight.bold),
              maxLength: 255,
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(fontWeight: FontWeight.bold),
                border: InputBorder.none,
              ),
            ),
            TextField(
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
  });
  final String priorityLevel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black, width: 2.5)),
        child: Text(
          priorityLevel,
          style: Theme.of(context)
              .textTheme
              .headline1
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
