import 'dart:convert';

Bible bibleFromJson(String str) => Bible.fromJson(json.decode(str));

String bibleToJson(Bible data) => json.encode(data.toJson());

class Bible {
  Bible({
    required this.id,
    required this.book,
    required this.chapter,
    required this.verse,
    required this.content,
  });

  int id;
  String book;
  String chapter;
  String verse;
  String content;

  factory Bible.fromJson(Map<String, dynamic> json) => Bible(
        id: json["Id"],
        book: json["Book"],
        chapter: json["Chapter"],
        verse: json["Verse"],
        content: json["Content"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Book": book,
        "Chapter": chapter,
        "Verse": verse,
        "Content": content,
      };
}
