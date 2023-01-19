import 'package:flutter/material.dart';
import 'package:sozluk_uygulamasi/models/kelime.dart';

import '../detay_sayfa.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Kelime> kelimeler;

  CustomSearchDelegate(this.kelimeler);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query.isEmpty ? null : query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return GestureDetector(
        onTap: () {
          close(context, "");
        },
        child: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: 24,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Kelime> arananKelimeler = kelimeler
        .where((element) =>
            element.ingilizce!.toLowerCase().contains(query.toLowerCase()) ||
            element.turkce!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: arananKelimeler.length,
      itemBuilder: (context, index) {
        var oAnkiKelime = arananKelimeler[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetaySayfa(kelime: oAnkiKelime),
                ));
          },
          child: SizedBox(
            height: 50,
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    oAnkiKelime.ingilizce!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(oAnkiKelime.turkce!)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
