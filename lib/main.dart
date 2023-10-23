import 'package:arrive_app/app_data.dart';
import 'package:arrive_app/screen/category_trips_screens.dart';
import 'package:arrive_app/screen/login_screen.dart';
import 'package:arrive_app/screen/register_screen.dart';
import 'package:arrive_app/screen/splash_screen.dart';
import 'package:arrive_app/screen/tabs_screen.dart';
import 'package:arrive_app/screen/trip_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './models/trip.dart';
import './screen/filters_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'summer': false,
    'winter': false,
    'family': false,
  };
  List<Trip> _availableTrips = tripsData;
  final List<Trip> _favouriteTrips = [];
  void _changeFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableTrips = tripsData.where((trip) {
        if (_filters['summer'] == true && trip.isInSummer != true) {
          return false;
        }
        if (_filters['winter'] == true && trip.isInWinter != true) {
          return false;
        }
        if (_filters['family'] == true && trip.isInForFamilies != true) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _manageFavourite(String tripId) {
    final existingIndex =
        _favouriteTrips.indexWhere((trip) => trip.id == tripId);
    if (existingIndex >= 0) {
      setState(() {
        _favouriteTrips.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteTrips.add(tripsData.firstWhere((trip) => trip.id == tripId));
      });
    }
  }

  bool _isFavorite(String id) {
    return _favouriteTrips.any((trip) => trip.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'AE'),
      ],
      title: 'Travel App',
      theme: ThemeData(
        fontFamily: 'ElMessiri',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline5: const TextStyle(
                color: Colors.blue,
                fontSize: 24,
                fontFamily: 'ELMessiri',
                fontWeight: FontWeight.bold,
              ),
              headline6: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontFamily: 'ElMessiri',
                fontWeight: FontWeight.bold,
              ),
            ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.amber),
      ),
      initialRoute: SplashView.ScreenRoute,
      routes: {
        SplashView.ScreenRoute: (context) => const SplashView(),
        LoginScreen.ScreenRoute: (context) => const LoginScreen(),
        RegisterPage.ScreenRoute: (context) => const RegisterPage(),
        '/': (context) => TabsScreen(_favouriteTrips),
        CategoryTripsScreens.ScreenRoute: (context) =>
            CategoryTripsScreens(_availableTrips),
        TripDetailScreen.screenRoute: (context) =>
            TripDetailScreen(_manageFavourite, _isFavorite),
        FiltersScreen.screenRoute: (context) =>
            FiltersScreen(_changeFilters, _filters),
      },
    );
  }
}
