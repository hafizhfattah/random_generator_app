import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final sty = GoogleFonts.montserrat(
    letterSpacing: 1,
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Generate Random Word",
          style: GoogleFonts.montserrat(
            fontSize: 16,
            letterSpacing: 1,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(vertical: 12),
          children: [
            FutureBuilder(
              future: Dio().get(
                "https://katanime.vercel.app/api/getrandom",
                options: Options(
                  contentType: "application/json",
                ),
              ),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                Response response = snapshot.data;
                Map obj = response.data;
                List items = obj["result"];

                return ListView.builder(
                  itemCount: items.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var item = items[index];

                    return Card(
                      child: ListTile(
                        subtitle: Text(
                          "${item["indo"]}",
                          style: sty,
                        ),
                        title: Text(
                          "Character: ${item["character"]}, Anime: ${item["anime"]}",
                          style: sty,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            FutureBuilder(
              future: Dio().get(
                "https://api.banghasan.com/quran/format/json/acak",
              ),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                Response response = snapshot.data;
                Map obj = response.data;
                Map items = obj;

                return ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        subtitle: Text(
                          "${items["surat"]["keterangan"]}",
                          style: sty,
                        ),
                        title: Text(
                          "Nama Surah: ${items["surat"]["name"]}, Arti: ${items["surat"]["arti"]}, Surah Ke: ${items["surat"]["nomor"]}, Ayat: ${items["surat"]["ayat"]}, Dari: ${items["surat"]["type"]}",
                          style: sty,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
