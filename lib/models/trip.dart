enum Seasson {
  winter,
  spring,
  summer,
  autum,
}

enum TripType {
  recovery,
  exploration,
  activities,
  therapy,
}

class Trip {
  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> activities;
  final List<String> program;
  final int duration;
  final Seasson season;
  final TripType tripType;
  final bool isInSummer;
  final bool isInWinter;
  final bool isInForFamilies;
  const Trip({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.activities,
    required this.duration,
    required this.season,
    required this.tripType,
    required this.isInSummer,
    required this.isInForFamilies,
    required this.isInWinter,
    required this.program,
  });
}
