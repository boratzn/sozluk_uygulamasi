import 'package:flutter/material.dart';

import 'package:sozluk_uygulamasi/models/kelime.dart';

class DetaySayfa extends StatefulWidget {
  final Kelime kelime;
  DetaySayfa({
    required this.kelime,
  });

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detay Sayfası"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.kelime.ingilizce!,
              style: TextStyle(
                  fontSize: 40, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            Text(
              widget.kelime.turkce!,
              style: TextStyle(fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
