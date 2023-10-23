// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:arrive_app/models/trip.dart';
import 'package:arrive_app/widgets/trip_item.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Trip> favouriteTrips;
  const FavoritesScreen(this.favouriteTrips, {super.key});

  @override
  Widget build(BuildContext context) {
    if (favouriteTrips.isEmpty) {
      return const Center(
        child: Text('ليس لديك اي رحلة في قائمة المفضلة'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return TripItem(
            id: favouriteTrips[index].id,
            title: favouriteTrips[index].title,
            duration: favouriteTrips[index].duration,
            imageUrl: favouriteTrips[index].imageUrl,
            seasson: favouriteTrips[index].season,
            tripType: favouriteTrips[index].tripType,
          );
        },
        itemCount: favouriteTrips.length,
      );
    }
  }
}
