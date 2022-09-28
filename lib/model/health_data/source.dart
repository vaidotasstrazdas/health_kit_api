library health_kit_api;

class Source {
  final String? name;
  final String? slug;
  final String? logo;

  const Source({
    required this.name,
    required this.slug,
    required this.logo,
  });

  factory Source.fromObject(final Map<String, dynamic> object) => Source(
        name: object['name'],
        slug: object['slug'],
        logo: object['logo'],
      );
}
