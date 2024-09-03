import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Item {
  final String id;
  final String content;
  final String date_begin;
  final String date_end;
  Item({
    required this.id,
    required this.content,
    required this.date_begin,
    required this.date_end,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'date_begin': date_begin,
      'date_end': date_end,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as String,
      content: map['content'] as String,
      date_begin: map['date_begin'] as String,
      date_end: map['date_end'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) =>
      Item.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Item(id: $id, content: $content, date_begin: $date_begin, date_end: $date_end)';
  }

  Item copyWith({
    String? id,
    String? content,
    String? date_begin,
    String? date_end,
  }) {
    return Item(
      id: id ?? this.id,
      content: content ?? this.content,
      date_begin: date_begin ?? this.date_begin,
      date_end: date_end ?? this.date_end,
    );
  }

  @override
  bool operator ==(covariant Item other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.content == content &&
        other.date_begin == date_begin &&
        other.date_end == date_end;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        content.hashCode ^
        date_begin.hashCode ^
        date_end.hashCode;
  }
}
