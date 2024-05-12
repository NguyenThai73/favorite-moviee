// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:favorite_movie/constants/dialog.app.dart';
import 'package:flutter/material.dart';

class DialogChangeName extends StatefulWidget {
  final String nameNow;
  const DialogChangeName({super.key, required this.nameNow});

  @override
  State<DialogChangeName> createState() => _DialogChangeNameState();
}

class _DialogChangeNameState extends State<DialogChangeName> {
  TextEditingController name = TextEditingController();
  @override
  void initState() {
    super.initState();
    name.text = widget.nameNow;
  }

  @override
  Widget build(BuildContext context) {
    return DialogApp(
      child: Container(
        child: Column(
          children: [
            Text(
              "Change name",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF335a3e),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20, top: 20),
              padding: EdgeInsets.only(right: 10),
              height: 56,
              decoration: BoxDecoration(color: Color(0xFFE1E5E2), borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "Full name",
                  helperStyle: TextStyle(fontSize: 14, color: Color(0xFF999898)),
                  prefixIcon: Padding(padding: EdgeInsets.only(top: 10), child: Icon(Icons.person)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 18),
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context, name.text);
                  },
                  child: Container(
                    width: 120,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFF335a3e),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text('OK', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
