import 'package:flutter/material.dart';
import 'package:sozluk_uygulamasi/data/kelimeler_dao.dart';
import 'package:sozluk_uygulamasi/detay_sayfa.dart';
import 'package:sozluk_uygulamasi/models/kelime.dart';

import 'widgets/custom_search_delegate.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: const AnaSayfa());
  }
}

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  bool aramaYapiliyorMu = false;
  String aramaKelimesi = "";

  Future<List<Kelime>> tumKelimeleriGetir() async {
    var kelimelerListesi = await KelimelerDao().tumKelimeler();

    return kelimelerListesi;
  }

  Future<List<Kelime>> aramaYap(String arananKelime) async {
    var kelimelerListesi = await KelimelerDao().KelimeAra(arananKelime);

    return kelimelerListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                //_showSearchPage();
                setState(() {
                  aramaYapiliyorMu = true;
                });
              },
              icon: const Icon(Icons.search_rounded)),
        ],
        title: aramaYapiliyorMu
            ? TextField(
                decoration: const InputDecoration(
                    hintText: "Arama yapmak için birşeyler yaz"),
                onChanged: (value) {
                  setState(() {
                    aramaKelimesi = value;
                  });
                },
              )
            : const Text("Sözlük Uygulaması"),
      ),
      body: FutureBuilder(
        future:
            aramaYapiliyorMu ? aramaYap(aramaKelimesi) : tumKelimeleriGetir(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var oAnkiKelime = snapshot.data![index];
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
          } else {
            return const Center();
          }
        },
      ),
    );
  }

  void _showSearchPage() async {
    await showSearch(
        context: context,
        delegate: CustomSearchDelegate(await tumKelimeleriGetir()));
  }
}
