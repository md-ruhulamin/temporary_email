
class Domain {
  final String id;
  final String domain;
  final bool isActive;
  final bool isPrivate;
  final String createdAt;
  final String updatedAt;

  Domain({
    required this.id,
    required this.domain,
    required this.isActive,
    required this.isPrivate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Domain.fromJson(Map<String, dynamic> json) {
    return Domain(
      id: json['id'],
      domain: json['domain'],
      isActive: json['isActive'],
      isPrivate: json['isPrivate'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}