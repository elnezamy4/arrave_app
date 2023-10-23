import 'package:arrive_app/models/trip.dart';
import 'package:arrive_app/widgets/trip_item.dart';
import 'package:flutter/material.dart';

class CategoryTripsScreens extends StatelessWidget {
  // ignore: constant_identifier_names
  static const ScreenRoute = 'category-trips';

  final List<Trip> availableTrips;
  const CategoryTripsScreens(this.availableTrips, {super.key});
  @override
  Widget build(BuildContext context) {
    final routeArg =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryId = routeArg['id'];
    final categoryTitle = routeArg['title'];
    final filteredTrips = availableTrips.where((trip) {
      return trip.categories.contains(categoryId);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return TripItem(
            id: filteredTrips[index].id,
            title: filteredTrips[index].title,
            duration: filteredTrips[index].duration,
            imageUrl: filteredTrips[index].imageUrl,
            seasson: filteredTrips[index].season,
            tripType: filteredTrips[index].tripType,
          );
        },
        itemCount: filteredTrips.length,
      ),
    );
  }
}
