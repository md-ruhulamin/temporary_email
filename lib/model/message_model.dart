class Message {
  String id;
  String msgid;
  From from;
  List<To> to;
  String subject;
  String intro;
  bool seen;
  bool isDeleted;
  bool hasAttachments;
  int size;
  String downloadUrl;
  String sourceUrl;
  String createdAt;
  String updatedAt;

  Message({
    required this.id,
    required this.msgid,
    required this.from,
    required this.to,
    required this.subject,
    required this.intro,
    required this.seen,
    required this.isDeleted,
    required this.hasAttachments,
    required this.size,
    required this.downloadUrl,
    required this.sourceUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      msgid: json['msgid'],
      from: From.fromJson(json['from']),
      to: (json['to'] as List).map((e) => To.fromJson(e)).toList(),
      subject: json['subject'],
      intro: json['intro'],
      seen: json['seen'],
      isDeleted: json['isDeleted'],
      hasAttachments: json['hasAttachments'],
      size: json['size'],
      downloadUrl: json['downloadUrl'],
      sourceUrl: json['sourceUrl'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class From {
  String address;
  String name;

  From({required this.address, required this.name});

  factory From.fromJson(Map<String, dynamic> json) {
    return From(
      address: json['address'],
      name: json['name'],
    );
  }
}

class To {
  String address;
  String name;

  To({required this.address, required this.name});

  factory To.fromJson(Map<String, dynamic> json) {
    return To(
      address: json['address'],
      name: json['name'],
    );
  }
}
