import 'package:sozluk_uygulamasi/data/veritabani_yardimcisi.dart';
import 'package:sozluk_uygulamasi/models/kelime.dart';

class KelimelerDao {
  Future<List<Kelime>> tumKelimeler() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM kelimeler");

    return List.generate(
      maps.length,
      (index) {
        var satir = maps[index];
        return Kelime(
            kelimeId: satir["kelime_id"],
            ingilizce: satir["ingilizce"],
            turkce: satir["turkce"]);
      },
    );
  }

  Future<List<Kelime>> KelimeAra(String arananKelime) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM kelimeler where ingilizce like '%$arananKelime%'");

    return List.generate(
      maps.length,
      (index) {
        var satir = maps[index];
        return Kelime(
            kelimeId: satir["kelime_id"],
            ingilizce: satir["ingilizce"],
            turkce: satir["turkce"]);
      },
    );
  }
}
