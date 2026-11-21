class Giveaway {
  const Giveaway({
    required this.id,
    required this.title,
    required this.worth,
    required this.thumbnail,
    required this.image,
    required this.description,
    required this.instructions,
    required this.giveawayUrl,
    required this.publishedDate,
    required this.type,
    required this.platforms,
    required this.endDate,
    required this.users,
    required this.status,
  });

  final int id;
  final String title;
  final String worth;
  final String thumbnail;
  final String image;
  final String description;
  final String instructions;
  final String giveawayUrl;
  final String publishedDate;
  final String type;
  final String platforms;
  final String endDate;
  final int users;
  final String status;

  String get displayWorth => worth == 'N/A' || worth.isEmpty ? 'Free' : worth;

  String get displayEndDate => endDate == 'N/A' || endDate.isEmpty
      ? 'While supplies last'
      : endDate.split(' ').first;

  factory Giveaway.fromJson(Map<String, dynamic> json) {
    String text(String key, String fallback) {
      final value = json[key];
      return value is String && value.trim().isNotEmpty ? value : fallback;
    }

    return Giveaway(
      id: json['id'] is int ? json['id'] as int : 0,
      title: text('title', 'Untitled giveaway'),
      worth: text('worth', 'N/A'),
      thumbnail: text('thumbnail', ''),
      image: text('image', ''),
      description: text('description', 'No description available.'),
      instructions: text('instructions', 'Open the giveaway page for details.'),
      giveawayUrl: text('open_giveaway_url', text('gamerpower_url', '')),
      publishedDate: text('published_date', 'N/A'),
      type: text('type', 'Game'),
      platforms: text('platforms', 'Unknown'),
      endDate: text('end_date', 'N/A'),
      users: json['users'] is int ? json['users'] as int : 0,
      status: text('status', 'Active'),
    );
  }
}
