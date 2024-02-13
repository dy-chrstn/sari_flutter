import 'package:flutter/material.dart';

class NoteAdd extends StatelessWidget {
  const NoteAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            TextField(
              decoration: InputDecoration.collapsed(
                hintText: "Title",
                hintStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                focusColor: Colors.blue,
              ),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Type note here...', style: TextStyle(fontWeight: FontWeight.w700, color: Color.fromARGB(221, 139, 139, 139)),)
          ]),
        ),
      ),
    );
  }
}
